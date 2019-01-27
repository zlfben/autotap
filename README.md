AutoTap: A user-friendly synthesizing/debugging tool for trigger-action programs in smart home
===
# How to get the artifact
Our artifact is available on GitHub [zlfben/autotap](https://github.com/zlfben/autotap).

# Introduction

This is the artifact for “Synthesizing and Repairing Trigger-Action Programs Using LTL Properties” (#399). It encompasses both the software we developed and the data from our user studies. The purpose of distributing this artifact is two-fold: 
 -  To publish an intuitive running example of the tool mentioned in our paper 
 - To provide trigger-action programs/properties written by real-world users as potential benchmarks for researchers in the same domain

No specific knowledge from the reviewers is assumed as our application aims at novice users. 

# The AutoTap software
The software AutoTap is for novice end-users to create and modify trigger-action programs (TAP) for smart devices at home. It allows users to input natural-language-based properties they want in their smart home. AutoTap tells whether a provided TAP program satisfies the specified properties; if not, AutoTap synthesizes TAP programs or program modifications to satisfy the properties. 

This repository consists of AutoTap as a web-application. There are three components - the database, the backend and the frontend - that supports this web-application. The following instructions will show how to set up a local server and play with AutoTap.

## Setting up the AutoTap web application
First, follow the instructions in [INSTALL.md](INSTALL.md) in order to build the docker images for the three components.

Before setting up the server, make sure that these 2 ports are not occupied by other processes: 8000 and 4200. Our backend process will use port 8000 and the frontend will use port 4200.

Then from the root directory of this project:
```console
user@host:/path/to/this/repo$ docker-compose up
```
It may take time for the database to initialize if it is set up for the first time. During this time, the backend will show something like this repeatly:
```
backend_1   | DB unavailable - sleeping
```
Please allow 10 seconds (if typical SSD is used) to 3 minute (if HDD is used) for the database to initialize. Once this process finished, the console output will be stable and show that frontend and backend are listening to requests.

You can access the following url with your browser to check AutoTap's interface. 
```
localhost:4200/user/1
```
Note that we use two fields to identify a workspace: username and task id, where username is a string and task id is a number. In the above example, "user" is the username and "1" is the task id. In general, you can use "localhsot:4200/\<username\>/\<task id\>localhsot:4200/\<username\>/\<task id\>" to retrieve properties and rules you've written in that workspace.

Note that our webpage was originally designed for large screen. If the content doesn't show well on your browser, please make the window bigger or zoom out the webpage (to 60%, for example).

For a more detailed tutorial, please read our user study [survey](./data/survey.pdf), which contains tutorials for creating both rules and properties.

## Example 1 (Synthesizing rules)
This example shows how to use AutoTap to synthesize rules to satisfy "AC is on and bedroom window is open should not be active together".

 - Step 1: Goto "localhost:4200/user/1" (or whatever empty workspace) with your browser.

 - Step 2: Click "Add a New Property"->"This state and this state should always/never occur together".

 - Step 3: Click the first "this state"->"Temperature"->"Thermostat"->"AC On/Off"->Choose "The AC is On"->Submit.

 - Step 4: Click the second "this state"->"Windows & Doors"->"Bedroom Window"->"Open/Close Window"->Choose "Bedroom Window is Open"->Submit

 - Step 5: Click "Never"->Save

 - Step 6: Click "Verify/Synthesize Rules with Properties"

## Example 2 (Debugging rules)
This example shows how to user AutoTap to debug current rules to satisfy "AC is on and bedroom window is open should not be active together".

 - Step 1: Follow the same instructions in example 1 to create a property, or go to the same workspace as example 1 to reuse the property created.

 - Step 2: On the right half of the webpage, click "Add a New Rule".

 - Step 3: Click "this"->"Temperature"->"Thermostat"->"AC On/Off"->Choose "The AC turns On"->Submit

 - Step 4: Click "that"->"Windows & Doors"->"Bedroom Window"->"Open/Close Window"->Choose "Close Bedroom Window"->Submit

 - Step 5: Click "Save"

 - Step 6: Click "Verify/Synthesize Rules with Properties"

We can see that comparing to the results in example 1, there will only be two options. In both of them, The behavior of the original rule is preserved.

# The user-study data
We provide the data collected from our two user studies, including the tasks we asked participants to achieve in smart home, properties written by participants, TAP rules written by participants, etc. Moreover, instructions on reproducing the synthesizing and debugging results in our paper are also provided. 

We don't publish all of our user study data. Some of them were collected when we were still in our final round of piloting. The question about data releasing 
was added after that. Therefore, we believed that we should not release their data until we got their permissions. We deleted data from 27 out of 78 participants because 
of this reason. For the other 51 users who opted-in to publish their data, we use "p1", "p2", ... "p51" to represent them in our database.

## Accessing user study data
Data of both user study 1 and user study 2 mentioned in our paper is in the spreadsheets.
```
data/"Data - User Study 1.xlsx"
data/"Data - User Study 2.xlsx"
```
### Data - User Study 1
Data from User Study reported in Section III.
 - Result: data from the survey (discarded data is not included in this sheet)
 - Discarded Data: data from participants who gave off-topic answers or reported having no smart devices in the survey

NOTE:
As part of the consent form, we gave participants an optional, opt-in choice to allow their data to be shared as part of a public research data set. 73 of the 75 participants opted-in to this optional data sharing. Of course, this file excludes the 2 participants who did not opt-in.
The data from participants who did not opt-in are marked as empty cells with <span style="background-color:#c9daf8">light blue</span> background.

### Data - User Study 2
Data from User Study reported in Section VI.
 - Tasks: the task descriptions
 - Property Result: properties written by half of the participants. Each one is graded by two coders and all conflicts are resolved. (resolved score: 1-incorrect, 4-correct)
 - TAP Rule Result: TAP rules written by the other half of the participants. Each one is graded by two coders and all conflicts are resolved. (resolved score: 1-incorrect, 4-correct)
 - Survey Result: data from the survey (discarded data is not included in this sheet)
 - AutoTap’s Synthesizing Result: The TAP patches generated by AutoTap for those user-written properties marked as correct (the only one for which AutoTap failed is marked with <span style="background-color:red">red</span> background)
 - Discarded Survey Data: data from participants who gave irrelevant answers in the survey

NOTE:
As part of the consent form, we gave participants an optional, opt-in choice to allow their data to be shared as part of a public research data set. 53 of the 81 participants opted-in to this optional data sharing. Of course, this file excludes the 28 participants who did not opt-in.
It worth noting that, from these 28 participants, 27 of them never saw the opt-in choice because the choice was added after they finished the survey.
The data from participants who did not opt-in are marked as empty cells with <span style="background-color:#c9daf8">light blue</span> background.


## Reproducing synthesizing/debugging results from the paper
We also provide the properties/rules written by participants in our user study, and therefore you can ask AutoTap to directly work on those data. This will reproduce the result we showed in our paper.

Follow the same instructions as in section "Setting up the AutoTap web application".

Then in your browser, access this page:
```
localhost:8000/autotap/reproduce
```
Follow the instructions on the page.

In the result page, links to a more user-friendly page will be provided for each workspace.
