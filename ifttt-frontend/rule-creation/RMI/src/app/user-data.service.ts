import { Injectable } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { environment } from '../environments/environment';

export interface Task {
  description: String;
  rules: Object[];
}

export interface Rule {
  ifClause: Clause[];
  thenClause: Clause[];
  priority?: number;
  temporality: string;
  id?: number;
}

export interface Sp1 {
  thisState: Clause[];
  thatState: Clause[];
  compatibility: boolean;
}

export interface Sp2 {
  stateClause: Clause[];
  compatibility: boolean;
  comparator?: String;
  time?: Time;
  alsoClauses?: Clause[];
}

export interface Sp3 {
  triggerClause: Clause[];
  compatibility: boolean;
  timeComparator?: string;
  otherClauses?: Clause[];
  afterTime?: Time;
}

export interface Time {
  seconds: number;
  minutes: number;
  hours: number;
}

export interface Clause {
  channel: Channel;
  device: Device;
  capability: Capability;
  parameters?: Parameter[];
  parameterVals?: any[];
  text: string;
  id?: number;
}

export interface Channel {
  id: number;
  name: string;
  icon: string;
}

export interface Device {
  id: number;
  name: string;
}

export interface Capability {
  id: number;
  name: string;
  label: string;
}

export interface Parameter {
  id: number;
  name: string;
  type: string;
  values: any[];
}


@Injectable()
export class UserDataService {

  // user variables
  private taskList: Task[];
  private currentTaskIndex: number = 0;
  public hashed_id: string;
  public user_id: number;
  public task_id: number;
  public mode: string;

  // rule variables
  public currentlyStagedRuleIndex: number = 0;
  public currentlyStagedRule: Rule | null = null;
  public currentObjectType: string = "trigger";

  // temporality variables
  public isCurrentObjectEvent: boolean = false;
  public currentObjectIndex: number = -1;
  public temporality: string = "event-state";

  //sp variables
  public currentlyStagedSp1: Sp1 | null = null;
  public currentlyStagedSp2: Sp2 | null = null;
  public currentlyStagedSp3: Sp3 | null = null;
  public currentlyStagedSpIndex: number = 0;
  public currentSpType: number;
  public currentSpClauseType: string;
  public compatibilityPhrase: string = '';
  public comparator: string = '';
  public hasAfterTime: boolean;
  public whileOrAfter: boolean = true;
  public hideSp2Time: boolean = false;
  public hideSp2Also: boolean = false;

  // clause variables
  public channels: Channel[];
  public selectedChannel: Channel;
  public selectedDevice: Device;
  public selectedCapability: Capability;
  public parameters: Parameter[];
  public currentClause: Clause;

  // meta clause variables
  public currentHistoryObjectIndex: number;
  public historyClause: Clause;
  public historyClauseParameterIndex: number;
  public isCurrentHistoryEvent: string = '';
  public currentHistoryObjectType: string = '';

  // editing variables
  public editing: boolean;
  public editingRuleID: number;
  public stopLoadingEdit: boolean;
  public editingSpID: number;

  private apiUrl: string = environment.apiUrl;

  constructor(private router: Router, private route: ActivatedRoute,
              private http: HttpClient) {
    this.getUserTasks().then((tasks: Task[]) => {
      this.taskList = tasks;
    });
    this.editing == false;
  }

  // unused
  public shouldShowPriority(): boolean {
    const shouldShow = this.temporality === "state-state";
    if (shouldShow && !this.currentlyStagedRule.priority) {
      this.currentlyStagedRule['priority'] = 1;
    }
    return shouldShow;
  }

  // unused
  public getDescriptionFromClause(clause: Clause) {
    return this.currentClause.text;
  }

  // unused
  private getUserTasks(): Promise<Task[]> {
    return new Promise((resolve, reject) => {
      resolve([
        {
          description: `Your dog, Fido, likes to play outside in the rain, but he then tracks mud into 
            the house. Therefore, if Fido happens to be outside in the rain, call him inside.`,
          rules: []
        }
      ]);
    });
  }

  // unused
  public getCurrentTask(): Task {
    return this.taskList[this.currentTaskIndex];
  }

  // unused
  public getTotalNumberTasks(): number {
    return this.taskList.length;
  }

  // unused
  public getCurrentTaskNumber(): string {
    // return this.currentTaskIndex + 1;
    return "hello"; // thanks abhi
  }

  // unused
  public isRuleCurrentlyStaged(): boolean {
    return !!this.currentlyStagedRule;
  }

  // stages empty rule if no rule
  public stageRule(): void {
    if (!this.currentlyStagedRule) {
      this.currentlyStagedRule = {
        ifClause: [],
        thenClause: [],
        temporality: this.temporality,
      };
    }
  }

  // adds current clause to either "if" or "then" clauses or current rule
  public addClauseToRule() {
    const clause = this.getTextForClause(this.currentClause);
    delete this.currentClause;
    delete this.parameters;
    if (this.currentObjectType == "trigger") {
      if (this.currentObjectIndex == -1) {
        clause.id = this.currentlyStagedRule.ifClause.length;
        this.currentlyStagedRule.ifClause.push(clause);
      }
      else {
        clause.id = this.currentObjectIndex;
        this.currentlyStagedRule.ifClause[this.currentObjectIndex] = clause;
      }
    }
    else {
      clause.id = 0;
      this.currentlyStagedRule.thenClause[0] = clause;
    }
  }

  // benches current clause to "this.historyClause" so the clause to fulfill
  // the meta parameter can be chosen for rules
  public selectHistoryClause(historyClauseParameterIndex: number, currentParameterVals: any[], temporality: string) {
    this.historyClauseParameterIndex = historyClauseParameterIndex;
    this.historyClause = this.currentClause;
    this.historyClause.parameterVals = currentParameterVals;
    this.currentHistoryObjectIndex = this.currentObjectIndex;
    delete this.currentClause;
    var is_event = (temporality == 'event' ? -1 : 1);
    this.gotoChannelSelector('trigger', is_event);
  }

  // benches current clause to "this.historyClause" so the clause to fulfill
  // the meta parameter can be chosen for sps
  public selectSpHistoryClause(sptype: number, historyClauseParameterIndex: number, currentParameterVals: any[], temporality: string) {
    this.historyClauseParameterIndex = historyClauseParameterIndex;
    this.historyClause = this.currentClause;
    this.historyClause.parameterVals = currentParameterVals;
    delete this.currentClause;
    this.currentHistoryObjectIndex = this.currentObjectIndex;
    var trigger = (temporality == 'event' ? 'trigger' :'not-trigger');
    this.gotoSpChannelSelector(trigger, this.currentSpClauseType, 0);
  }

  // takes historyClause off the bench and adds the current clause as
  // its meta parameter
  public addClauseToHistoryChannelClause() {
    this.historyClause.parameterVals[this.historyClauseParameterIndex] = {"value":this.getTextForClause(this.currentClause), "comparator":"="}
    this.currentClause = this.historyClause;
    delete this.historyClause;
    this.isCurrentObjectEvent = this.isCurrentHistoryEvent == 'event' ? true : false;
    this.isCurrentHistoryEvent = '';
    this.currentObjectIndex = this.currentHistoryObjectIndex;
    delete this.currentHistoryObjectIndex;
    this.selectedDevice = this.currentClause.device;
    this.selectedCapability = this.currentClause.capability;
  }

  // reloads parameter configuration page now that we've selected the
  // meta parameter for rules
  public reloadForHistoryClause() {
    this.router.navigate(['../create'], {skipLocationChange: true}).then(()=>
    this.router.navigate(['../create/configureParameters', 
                        this.currentClause.channel.id, 
                        this.currentClause.device.id, 
                        this.currentClause.capability.id]));
  }

  // reloads parameter configuration page now that we've selected the
  // meta parameter for sps
  public reloadForSpHistoryClause() {
    this.router.navigate(['../createSp'], {skipLocationChange: true}).then(()=>
    this.router.navigate(['../createSp/configureParameters', 
                        this.currentClause.channel.id, 
                        this.currentClause.device.id, 
                        this.currentClause.capability.id]));
  }

  public reloadForRuleClear() {
    delete this.currentlyStagedRule;
    this.stopLoadingEdit = true;
    this.router.navigate([this.hashed_id + "/" + this.task_id + "/rules"], {skipLocationChange: true}).then(()=>
    this.router.navigate(['../create']));
  }

  public  reloadForSp1Clear() {
    delete this.currentlyStagedSp1;
    this.stopLoadingEdit = true;
    this.router.navigate(['../createSp'], {skipLocationChange: true}).then(()=>
    this.router.navigate(['../createSp/sp1']));
  }

  public  reloadForSp2Clear() {
    delete this.currentlyStagedSp2
    this.stopLoadingEdit = true;
    this.router.navigate(['../createSp'], {skipLocationChange: true}).then(()=>
    this.router.navigate(['../createSp/sp2']));
  }

  public  reloadForSp3Clear() {
    this.whileOrAfter = true;
    delete this.currentlyStagedSp3;
    this.stopLoadingEdit = true;
    this.router.navigate(['../createSp'], {skipLocationChange: true}).then(()=>
    this.router.navigate(['../createSp/sp3']));
  }

  // uses a ruleid to get a full rule from the backend for editing
  public getFullRule(ruleid: number) {
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    let body = {"userid": this.user_id, "ruleid":ruleid};
    this.http.post(this.apiUrl + "user/rules/get/", body, option)
              .subscribe(
                data => {this.currentlyStagedRule = data["rule"];
              }
              );
  }

  // sends current rule to backend for saving
  public finishRule() {
    var mode = (this.editing ? "edit" : "create");
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    var ruleid = (this.editing ? this.editingRuleID : 0)
    let body = {"rule": this.currentlyStagedRule, "userid": this.user_id, "taskid": this.task_id, "mode": mode, "ruleid":ruleid};

    this.editing = false;
    this.compatibilityPhrase = '';
    this.http.post(this.apiUrl + "user/rules/new/", body, option)
             .subscribe(
                data => {this.currentlyStagedRule = null;
                this.router.navigate([this.hashed_id + "/" + this.task_id + "/rules"]);}
             );
  }

  // deletes rule at ruleid
  public deleteRule(ruleid: number) {
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    let body = {"userid": this.user_id, "taskid":this.task_id, "ruleid": ruleid}
    return this.http.post(this.apiUrl + "user/rules/delete/", body, option)
  }

  // checks if staged rule is valid to be saved
  public stagedRuleIsValid(): boolean {
    return (this.currentlyStagedRule && this.currentlyStagedRule.ifClause.length > 0 
            && this.currentlyStagedRule.thenClause.length > 0);
  }

  // navigates to rule creation
  public gotoCreate() {
    this.router.navigate(["../create/"]);
  }

  //navigates to sp creation
  public gotoCreateSp(sptype: number) {
    if (sptype == 1) {
      this.router.navigate(["../createSp/sp1"]);
    }
    else if (sptype == 2) {
      this.router.navigate(["../createSp/sp2"]);
    }
    else if (sptype == 3) {
      this.router.navigate(["../createSp/sp3"]);
    }
    else {this.router.navigate(["../createSp/"]);}
  }

  // navigates to channel selector for rules
  public gotoChannelSelector(objectType: string, index: number): void {
    if (objectType == 'trigger' || objectType == 'action') this.currentObjectType = objectType;
    if (objectType == 'triggerAdd') {this.currentObjectType = 'trigger';}
    this.currentObjectIndex = index;
    if (objectType == "trigger" && index <= 0) {
      this.isCurrentObjectEvent = true;
    } else {
      this.isCurrentObjectEvent = false;
    }
    this.router.navigate(["../create/selectChannel"], {relativeTo: this.route});
  }

  // navigates to channel selector for sps
  public gotoSpChannelSelector(objectType: string, spClauseType: string, index: number): void {
    this.currentObjectType = objectType;
    this.currentSpClauseType = spClauseType;
    this.currentObjectIndex = index;
    if (spClauseType == 'trigger' || spClauseType == 'otherEvent') {this.isCurrentObjectEvent = true} 
    else {this.isCurrentObjectEvent = false}
    this.router.navigate(["../createSp/selectChannel"], {relativeTo: this.route});
  }

  // navigates to device selector for rules
  public gotoDeviceSelector(channel: Channel): void {
    this.selectedChannel = channel;
    this.router.navigate(['../create/selectDevice', String(channel.id)])
  }

  // navigates to device selector for sps
  public gotoSpDeviceSelector(channel: Channel): void {
    this.selectedChannel = channel;
    this.router.navigate(['../createSp/selectDevice', String(channel.id)])
  }

  //navigates to capability selector for rules
  public gotoCapabilitySelector(selectedDevice: Device, channelID: number, deviceID: number): void {
    this.selectedDevice = selectedDevice;
    this.router.navigate(['../create/selectCapability', String(channelID), String(deviceID)]);
  }

  // navigates to capability selector for sps
  public gotoSpCapabilitySelector(selectedDevice: Device, channelID: number, deviceID: number): void {
    this.selectedDevice = selectedDevice;
    this.router.navigate(['../createSp/selectCapability', String(channelID), String(deviceID)]);
  }

  // navigates to parameter configuration for rules
  public gotoParameterConfiguration(selectedCapability: Capability, channelID: number, deviceID: number, capabilityID: number) {
    this.selectedCapability = selectedCapability;
    this.currentClause = {"channel":this.selectedChannel, "device":this.selectedDevice, "capability":this.selectedCapability, "text":this.selectedCapability.label}
    var parameters;
    this.getParametersForCapability(true, true, deviceID, capabilityID).subscribe(
      data => { 
        parameters = data["params"];
        if (parameters.length > 0) {
          this.router.navigate(['../create/configureParameters', String(channelID), String(deviceID), String(capabilityID)]);
        }
        else {
          this.addClauseToRule()
          this.gotoCreate();}
      });
  }

  // navigates to parameter configuration for sps
  public gotoSpParameterConfiguration(selectedCapability: Capability, channelID: number, deviceID: number, capabilityID: number) {
    this.selectedCapability = selectedCapability;
    this.currentClause = {"channel":this.selectedChannel, "device":this.selectedDevice, "capability":this.selectedCapability, "text":this.selectedCapability.label}
    var parameters;
    this.getParametersForCapability(true, true, deviceID, capabilityID).subscribe(
      data => { 
        parameters = data["params"];
        if (parameters.length > 0) {
          this.router.navigate(['../createSp/configureParameters', String(channelID), String(deviceID), String(capabilityID)]);
        }
        else {
          if (this.currentlyStagedSp1){
            this.addClauseToSp1()
            this.gotoCreateSp(1);
          }
          else if (this.currentlyStagedSp2){
            this.addClauseToSp2()
            this.gotoCreateSp(2);
          }
          else {
            this.addClauseToSp3()
            this.gotoCreateSp(3);
          }
        }
      }
    );
  }

  // get csrf cookie from the backend
  public getCsrfCookie(): any {
    let option = {withCredentials: true};
    return this.http.get(this.apiUrl + "user/get_cookie/", option);
  }

  // get patches for a certain (user_id, task_id) based on its sps and rules
  public verifyTask(hashed_id: string): any {
    let body = {"userid": this.user_id, "taskid": this.task_id, "code": hashed_id, "compact": 0, "named": 0};
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    return this.http.post(this.apiUrl + "autotap/fix/", body, option);
  }

  // gets a user's rules from the backend using their user_id, as well as 
  // will get their numerical user id based on their string 
  // hashed_id URL parameter if a user_id field isn't provided in this call.
  public getRules(hashed_id: string): any {
    let body = {"userid": this.user_id, "taskid": this.task_id, "code":hashed_id};
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    return this.http.post(this.apiUrl + "user/rules/", body, option);
  }

  // gets all channels from the backend
  public getChannels(is_Trigger: boolean, is_Event: boolean): any {
    let body = {"userid": this.user_id, "is_trigger": is_Trigger};
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    return this.http.post(this.apiUrl + "user/chans/", body, option);
  }

  // gets all devices related to selected channel
  public getDevicesForChannel(is_Trigger: boolean, is_Event: boolean, channel_id: number): any {
    let body = {"userid": this.user_id, "is_trigger": is_Trigger, "channelid": channel_id};
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    return this.http.post(this.apiUrl + "user/chans/devs/", body, option);
  }

  // gets all capabilities related to selected device
  public getCapabilitiesForDevice(is_Trigger: boolean, is_Event: boolean, device_id: number, channel_id: number): any {
    let body = {"channelid": channel_id, 
                "deviceid": device_id, 
                "is_trigger": is_Trigger,
                "is_event": is_Event
              };
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    return this.http.post(this.apiUrl + "user/chans/devs/caps/", body, option);
  }

  // gets all parameters for selected capability
  public getParametersForCapability(is_Trigger: boolean, is_Event: boolean, device_id: number, capability_id: number): any {
    let body = {"capid": capability_id};
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    return this.http.post(this.apiUrl + "user/chans/devs/caps/params/", body, option);
  }

  // wherever a full clause shows up (in /rules, /sp, /create, or /createSp)
  // this function uses regular expressions on its label to put the
  // add its selected values
  public getTextForClause(clause: Clause): Clause {
    var label = clause.capability.label;
    label = label.replace("{DEVICE}", clause.device.name);
    var parameter: any;
    for (parameter in clause.parameters) {
      if (clause.parameters[parameter].type == "range" || clause.parameters[parameter].type == "input") {
        label = label.replace("{" + clause.parameters[parameter].name + "}", clause.parameterVals[parameter].value);
        const rangeComparators = ["=","!=",">","<"];
        var i: number;
        for (i = 0; i < rangeComparators.length; i++) {
          if (clause.parameterVals[parameter].comparator == rangeComparators[i]) {
            var re = new RegExp("{" + clause.parameters[parameter].name + "\/" + rangeComparators[i] + "\\|(.*?)}", "g");
            label = label.replace(re, "$1");  
          }
          else {
            var re  = new RegExp("{" + clause.parameters[parameter].name + "\/" + rangeComparators[i] + "\\|.*?}", "g");
            label = label.replace(re, "");
          }
        }
      }
      else if (clause.parameters[parameter].type == "set") {
        label = label.replace("{" + clause.parameters[parameter].name + "}", clause.parameterVals[parameter].value);
        const setComparators = ["=", "!="];
        var i: number;
        for (i = 0; i < setComparators.length; i++) {
          if (clause.parameterVals[parameter].comparator == setComparators[i]) {
            var re = new RegExp("{" + clause.parameters[parameter].name + "\/" + setComparators[i] + "\\|(.*?)}", "g");
            label = label.replace(re, "$1")  
          }
          else {
            var re  = new RegExp("{" + clause.parameters[parameter].name + "\/" + setComparators[i] + "\\|.*?}", "g");
            label = label.replace(re, "");
          }
        }
      }
      else if (clause.parameters[parameter].type == "duration") {
        var description = '';
        const sptime = clause.parameterVals[parameter].value;
        if (sptime.hours > 0) {description += (sptime.hours + "h ");}
        if (sptime.minutes > 0) {description += (sptime.minutes + "m ");}
        if (sptime.seconds > 0) {description += (sptime.seconds + "s ");}
        label = label.replace("{" + clause.parameters[parameter].name + "}", description);
        const durationComparators = [">", "<", "="];
        var i: number;
        for (i = 0; i < durationComparators.length; i++) {
          if (clause.parameterVals[parameter].comparator == durationComparators[i]) {
            var re = new RegExp("{" + clause.parameters[parameter].name + "\/" + durationComparators[i] + "\\|(.*?)}", "g");
            label = label.replace(re, "$1")  
          }
          else {
            var re  = new RegExp("{" + clause.parameters[parameter].name + "\/" + durationComparators[i] + "\\|.*?}", "g");
            label = label.replace(re, "");
          }
        }
      }
      else if (clause.parameters[parameter].type == "meta") {
        label = label.replace("{$trigger$}", clause.parameterVals[parameter].value.text)
      }
      else if (clause.parameters[parameter].type != "bin") {
        label = label.replace("{" + clause.parameters[parameter].name + "}", clause.parameterVals[parameter].value);
        // this is overkill but apparently it's needed in some cases
        const setComparators = ["=","!=",">","<"];
        var i: number;
        for (i = 0; i < setComparators.length; i++) {
          if (clause.parameterVals[parameter].comparator == setComparators[i]) {
            var re = new RegExp("{" + clause.parameters[parameter].name + "\/" + setComparators[i] + "\\|(.*?)}", "g");
            label = label.replace(re, "$1")  
          }
          else {
            var re  = new RegExp("{" + clause.parameters[parameter].name + "\/" + setComparators[i] + "\\|.*?}", "g");
            label = label.replace(re, "");
          }
        }
      }
      else {
        label = label.replace("{" + clause.parameters[parameter].name + "}", clause.parameterVals[parameter].value);
        // if binary value is true
        if (clause.parameterVals[parameter].value == clause.parameters[parameter].values[0]) {
          // get rid of false text
          var re = new RegExp("{" + clause.parameters[parameter].name + "\/F\\|.*?}", "g");
          label = label.replace(re, "");
          // leave true text but get rid of its capsule
          var re = new RegExp("{" + clause.parameters[parameter].name + "\/T\\|(.*?)}", "g");
          label = label.replace(re, "$1")  
        }
        else if (clause.parameterVals[parameter].value == clause.parameters[parameter].values[1]) {
          // get rid of true text
          var re = new RegExp("{" + clause.parameters[parameter].name + "\/T\\|.*?}", "g");
          label = label.replace(re, "");
          // leave false text but get rid of its capsule
          var re = new RegExp("{" + clause.parameters[parameter].name + "\/F\\|(.*?)}", "g");
          label = label.replace(re, "$1") 
        } else {
          // get rid of true text
          var re = new RegExp("{" + clause.parameters[parameter].name + "\/T\\|.*?}", "g");
          label = label.replace(re, "");
          // get rid of false text
          var re = new RegExp("{" + clause.parameters[parameter].name + "\/F\\|.*?}", "g");
          label = label.replace(re, "");
        }
      }
    }
    clause.text = label;
    return clause;
  }

  // SAFETY PROPERTY STUFF BELOW

  // gets a user's sps from the backend using their user_id, as well as 
  // will get their numerical user id based on their string 
  // hashed_id URL parameter if a user_id field isn't provided in this call.
  public getSps(hashed_id: string): any {
    let body = {"userid": this.user_id, "taskid":this.task_id, "code": hashed_id};
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    return this.http.post(this.apiUrl + "user/sps/", body, option);
  }

  // checks if currently staged sp is valid to be saved
  public stagedSpIsValid(sptype: number): boolean {
    if (sptype == 1) {
      return (this.currentlyStagedSp1 && this.currentlyStagedSp1.thisState.length > 0 
              && this.currentlyStagedSp1.thatState.length > 0 && this.compatibilityPhrase != '');
    }
    if (sptype == 2) {
      var bool = (this.currentlyStagedSp2 && this.currentlyStagedSp2.stateClause.length > 0 &&
                  this.compatibilityPhrase != '');
      return bool;
    }
    if (sptype == 3) {
      var bool = (this.currentlyStagedSp3 && this.currentlyStagedSp3.triggerClause.length > 0 
              && this.currentlyStagedSp3.compatibility == false);
      if (this.currentlyStagedSp3 && this.compatibilityPhrase != '' && this.currentlyStagedSp3.triggerClause.length > 0 &&
          (this.currentlyStagedSp3.otherClauses.length > 0 || 
          this.currentlyStagedSp3.afterTime)) {
        bool = true;
      }
      if (this.currentlyStagedSp3.afterTime && this.currentlyStagedSp3.otherClauses.length == 0) {
        bool = false
      }
      return bool;
    }
  }

  // stages an empty sp1 if there isn't one
  public stageSp1(): void {
    if (!this.currentlyStagedSp1) {
      this.currentlyStagedSp1 = {
        thisState: [],
        thatState: [],
        compatibility: true,
      };
    }
  }

  // stages an empty sp2 if there isn't one
  public stageSp2(): void {
    if (!this.currentlyStagedSp2) {
      this.currentlyStagedSp2 = {
        stateClause: [],
        alsoClauses: [],
        compatibility: true,
        comparator: '>',
        time: null,
      };
    }
  }

  // stages an empty sp3 if there isn't one
  public stageSp3(): void {
    if (!this.currentlyStagedSp3) {
      this.currentlyStagedSp3 = {
        triggerClause: [],
        otherClauses: [],
        compatibility: true,
        timeComparator: '<',
      };
    }
  }
  
  // adds current clause to currently staged sp1
  public addClauseToSp1() {
    const clause = this.getTextForClause(this.currentClause);
    delete this.currentClause;
    if (this.currentSpClauseType == "this") {
      clause.id = 0;
      this.currentlyStagedSp1.thisState[0] = clause;
    }
    else {
      if (this.currentObjectIndex == -1) {
        clause.id = 0;
        this.currentlyStagedSp1.thatState.push(clause);
      }
      else {
        clause.id = this.currentObjectIndex;
        this.currentlyStagedSp1.thatState[this.currentObjectIndex] = clause;
      }
    }
  }

  // adds current clause to currently staged sp2
  public addClauseToSp2() {
    const clause = this.getTextForClause(this.currentClause);
    delete this.currentClause;
    if (this.currentSpClauseType == "state") {
      clause.id = 0;
      this.currentlyStagedSp2.stateClause[0] = clause;
    }
    else {
      if (this.currentObjectIndex == -1) {
        clause.id = 0;
        this.currentlyStagedSp2.alsoClauses.push(clause);
      }
      else {
        clause.id = this.currentObjectIndex;
        this.currentlyStagedSp2.alsoClauses[this.currentObjectIndex] = clause;
      }
    }
  }

  // adds current clause to currently staged sp3
  public addClauseToSp3() {
    const clause = this.getTextForClause(this.currentClause);
    delete this.currentClause;
    if (this.currentSpClauseType == "trigger") {
      clause.id = 0;
      this.currentlyStagedSp3.triggerClause[0] = clause;
    }
    else {
      if (this.currentObjectIndex == -1) {
        clause.id = 0;
        this.currentlyStagedSp3.otherClauses.push(clause);
      }
      else {
        clause.id = this.currentObjectIndex;
        this.currentlyStagedSp3.otherClauses[this.currentObjectIndex] = clause;
      }
    }
  }

  // saves currently staged sp to the backend
  public finishSp(sptype: number) {
    var mode = (this.editing ? "edit" : "create");
    var spid = (this.editing ? this.editingSpID : 0)
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    this.editing == false;
    if (sptype == 1) {
      let body = {"sp": this.currentlyStagedSp1, "userid": this.user_id, "taskid": this.task_id, "mode": mode, "spid":spid};
      this.http.post(this.apiUrl + "user/sp1/new/", body, option)
             .subscribe(
                data => {this.currentlyStagedSp1 = null;
                this.router.navigate([this.hashed_id + "/" + this.task_id + "/sp"]);}
             );
    }
    else if (sptype == 2) {
      let body = {"sp": this.currentlyStagedSp2, "userid": this.user_id, "taskid": this.task_id, "mode": mode, "spid":spid};
      this.http.post(this.apiUrl + "user/sp2/new/", body, option)
             .subscribe(
                data => {this.currentlyStagedSp2 = null;
                this.router.navigate([this.hashed_id + "/" + this.task_id + "/sp"]);}
             );
    }
    else {
      let body = {"sp": this.currentlyStagedSp3, "userid": this.user_id, "taskid": this.task_id, "mode": mode, "spid":spid};
      this.http.post(this.apiUrl + "user/sp3/new/", body, option)
             .subscribe(
                data => {this.currentlyStagedSp3 = null;
                this.router.navigate([this.hashed_id + "/" + this.task_id + "/sp"]);}
             );
    }
  }

  // gets a full sp from the backend from its id for editing
  public getFullSp(spid: number, sptype: number) {
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    let body = {"userid": this.user_id, "spid":spid};
    if (sptype == 1) {
    this.http.post(this.apiUrl + "user/sp1/get/", body, option)
              .subscribe(
                data => {this.currentlyStagedSp1 = data["sp"];
                this.compatibilityPhrase = (data["sp"].compatibility ? 'always' : 'never');}
              );
    } else if (sptype == 2) {
      this.http.post(this.apiUrl + "user/sp2/get/", body, option)
                .subscribe(
                  data => {this.currentlyStagedSp2 = data["sp"];
                  this.compatibilityPhrase = (data["sp"].compatibility ? 'always' : 'never');
                  if (!this.currentlyStagedSp2.comparator) {
                    this.currentlyStagedSp2.comparator = '';
                  }
                  if (!this.currentlyStagedSp2.time) {
                    this.hideSp2Time = true;
                  } else {this.hideSp2Time = false;}
                  if (this.currentlyStagedSp2.alsoClauses.length == 0) {
                    this.hideSp2Also = true;
                  } else {this.hideSp2Also = false;}
                  });
    } else {
      this.http.post(this.apiUrl + "user/sp3/get/", body, option)
                .subscribe(
                  data => {this.currentlyStagedSp3 = data["sp"];
                  this.compatibilityPhrase = (data["sp"].compatibility ? 'always' : 'never');
                  this.hasAfterTime = (data["sp"].timeAfter ? true : false);
                  this.currentlyStagedSp3.timeComparator = '>';
                  }
                );
    }
  }

  // deletes sp by its id
  public deleteSp(spid: number) {
    let option = {headers: new HttpHeaders().set('Content-Type', 'application/json')};
    let body = {"userid": this.user_id, "taskid":this.task_id, "spid": spid}
    return this.http.post(this.apiUrl + "user/sps/delete/", body, option)
  }

}
