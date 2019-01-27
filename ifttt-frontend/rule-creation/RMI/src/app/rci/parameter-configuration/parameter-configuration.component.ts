import {Component} from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import {Location} from '@angular/common';
import {UserDataService, Device, Capability, Parameter, Clause} from '../../user-data.service';

@Component({
  selector: 'app-behavior-configure',
  templateUrl: './parameter-configuration.component.html',
  styleUrls: ['./parameter-configuration.component.css']
})
export class ParameterConfigurationComponent {

  public selectedCapabilityID: number;
  public selectedDeviceID: number;
  public selectedChannelID: number;
  public selectedDevice: Device;
  public selectedCapability: Capability;
  public parameters: Parameter[];
  public parameterKeys: String[];
  public parameterVals: any[];
  public labelText: string[];
  public labelSelectors: any[];
  public rangeComparators: String[];
  public setComparators: String[];

  constructor(public userDataService: UserDataService, 
              private route: ActivatedRoute, public _location: Location) 
  {
    this.route.params.subscribe(params => {
      this.selectedChannelID = params["channel_id"];
      this.selectedDeviceID = params["device_id"];
      this.selectedCapabilityID = params["capability_id"];
    });
    // for extractLabel() and to display parameters in sentence form
    this.labelText = [];
    this.labelSelectors = [];

    this.selectedDevice = this.userDataService.selectedDevice;
    this.selectedCapability = this.userDataService.selectedCapability;

    // I don't think this is used anymore
    this.rangeComparators = ["=", "!=", "<", ">"];
    this.setComparators = ["=", "!="];
    if (this.userDataService.currentObjectType == 'action') {this.rangeComparators = this.setComparators;}
    
    // handle if we're coming from selecting a meta clause
    if (!this.userDataService.currentClause && this.userDataService.historyClause) {
      userDataService.currentClause = userDataService.historyClause;
      delete userDataService.historyClause;
      userDataService.parameters = userDataService.currentClause.parameters;
    }
    if (this.userDataService.isCurrentHistoryEvent != '') {
      this.userDataService.isCurrentObjectEvent = this.userDataService.isCurrentHistoryEvent == 'event' ? true : false;
      this.userDataService.isCurrentHistoryEvent = '';
    }
    if (this.userDataService.currentHistoryObjectType != '') {
      this.userDataService.currentObjectType = this.userDataService.currentHistoryObjectType;
      this.userDataService.currentHistoryObjectType = '';
    }
    if (!this.userDataService.parameters || !this.userDataService.currentClause.parameterVals) {
      this.userDataService.getParametersForCapability(
                          (this.userDataService.currentObjectType == "trigger"), 
                          this.userDataService.isCurrentObjectEvent,  
                          this.selectedDeviceID, 
                          this.selectedCapabilityID)
                        .subscribe(
                          data => { 
                            this.parameters = data["params"];
                            this.userDataService.currentClause.parameters = this.parameters;
                            this.parameterKeys = (this.parameters) ? Object.keys(this.parameters) : [];
                            this.parameterVals = [];
                            // set up parameterVals to accept values
                            var i: number;
                            for (i = 0; i < this.parameters.length; i++) {
                              if (this.parameters[i].type == "set") {
                                this.parameterVals.push({"value": "", "comparator":"="});
                              } else if (this.parameters[i].type == "range") {
                                this.parameterVals.push({"value": this.parameters[i].values[0], "comparator":"="});
                              } else if (this.parameters[i].type == "meta") {
                                this.parameterVals.push({"value": "", "comparator":"="});
                              } else if (this.parameters[i].type == "duration") {
                                this.parameterVals.push({"value":{"hours":0,"minutes":0,"seconds":0}, "comparator":"="});
                              } else {
                                this.parameterVals.push({"value": "", "comparator":"="});
                              }
                            }
                            this.extractLabel(this.parameters);
                          }
                        );
    } else {
      this.parameters = this.userDataService.parameters;
      this.parameterKeys = (this.parameters) ? Object.keys(this.parameters) : [];
      this.parameterVals = this.userDataService.currentClause.parameterVals;
      this.extractLabel(this.parameters);
    }
  }

  // this function parses the capability label character by character and 
  // prepares textLabel and selectorLabel arrays to display parameter 
  // configuration as a sentence
  extractLabel(parameters: Parameter[]) {
    const label = this.selectedCapability.label;
    var gettingParam = false;
    var text = '';
    var paramName = '';
    for (var i = 0; i < label.length; i++) {
      if (label.charAt(i) != '{' && gettingParam == false) {
        if (label.charAt(i) != '"') {
          text += label.charAt(i);
        }
      } else if (label.charAt(i) == '{' && gettingParam == false) {
        gettingParam = true;
      } else if (gettingParam == true && paramName == '') {
        var gettingParamName = true;
        var j = 0;
        while (gettingParamName) {
          if (!['/', '}'].includes(label.charAt(i+j))) {
            paramName += (label.charAt(i+j))
          } else if (label.charAt(i+j) == '}') {
            if (paramName == "DEVICE") {
              gettingParamName = false;
              gettingParam = false;
              text += this.selectedDevice.name + " ";
              paramName = '';
              i += j;
            } else if (paramName == "$trigger$") {
              gettingParamName = false;
              gettingParam = false;
              var paramType;
              var paramValPos;
              for (var k = 0; k < parameters.length; k++) {
                if (parameters[k].type == 'meta') {paramType = parameters[k].type; paramValPos = k}
              }
              this.labelText.push(text);
              text='';
              this.labelSelectors.push([paramName, 'value', paramType, paramValPos])
              paramName = '';
              i += j;
            } else {
              gettingParamName = false;
              gettingParam = false;
              var paramType;
              var paramValPos;
              for (var k = 0; k < parameters.length; k++) {
                if (parameters[k].name == paramName) {paramType = parameters[k].type; paramValPos = k}
              }
              this.labelText.push(text);
              text='';
              this.labelSelectors.push([paramName, 'value', paramType, paramValPos]);
              paramName = '';
              i += j
            }
          }
          else {
            gettingParamName = false;
            var re = new RegExp("{" + paramName + "\/(.*?)\\|(.*?)}", "g");
            var matches = [];
            var values = [];
            var jump = 0;
            var bin = false;
            for (var k = 0; k < parameters.length; k++) {
              if (parameters[k].name == paramName) {paramType = parameters[k].type; paramValPos = k}
            }
            while (matches = re.exec(label)) {
              jump += matches[0].length;
              if (matches[1] == "T") {
                values.push({"value":this.parameters[paramValPos].values[0], "display":matches[2]});
                bin = true;
              } else if (matches[1] == "F") {
                values.push({"value":this.parameters[paramValPos].values[1], "display":matches[2]});
                bin = true;
              } else {
                values.push({"value":matches[1], "display":matches[2]});
              }   
            }
            if (values.length == 1) {values.push({"value":" ", "display":" "});}
            this.labelText.push(text);
            text='';
            var choice = (bin ? 'binChoice' : 'choice');
            this.labelSelectors.push([paramName, choice, values, paramValPos]);
            paramName = '';
            i += jump-2;
          }
          j++;
        }
        gettingParam = false;
      }
    }
    this.labelText.push(text);
  }

  leaveMeta() {
    if (this.userDataService.historyClause) {
      this.userDataService.currentClause = this.userDataService.historyClause;
      delete this.userDataService.historyClause;
    }
    this._location.back()
  }

  setIsTrue(parameterKey: number) {
    this.parameterVals[parameterKey].comparator = "=";
  }

  setIsFalse(parameterKey: number) {
    this.parameterVals[parameterKey].comparator = "!=";
  }

  selectHistoryClauseGate(parameterKey: number, temporality: string) {
    this.userDataService.isCurrentHistoryEvent = this.userDataService.isCurrentObjectEvent ? 'event' : 'state';
    this.userDataService.currentHistoryObjectType = this.userDataService.currentObjectType;
    this.userDataService.selectHistoryClause(parameterKey, this.parameterVals, temporality);
  }

  completeParameterSelect() {
    var valid = true;
    var i: number;
    var invalidText = '"Please select a value for ';
    for (i = 0; i < this.parameterVals.length; i++) {
      if (this.parameterVals[i].value == "") {
        valid = false;
        invalidText += "parameter " + (i+1) + ": " + this.parameters[i].name + ", ";
      }
      else if (this.parameterVals[i].value-1 == -1) {valid = (valid && true);}
      else {valid = (valid && true);}
    }
    invalidText = invalidText.substring(0, invalidText.length-2);
    if (valid == false) {
      alert(invalidText);
    } else {
      this.userDataService.currentClause.parameterVals = this.parameterVals;
      if (this.userDataService.historyClause) {
        this.userDataService.addClauseToHistoryChannelClause();
        this.userDataService.parameters = this.userDataService.currentClause.parameters;
        this.userDataService.reloadForHistoryClause();
      } else {
        this.userDataService.addClauseToRule();
        this.userDataService.gotoCreate();
      }
    }
  }

}