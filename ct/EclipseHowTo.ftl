${bootstrap}${markdown}
<#--title=How to setup Cargo Tracker in Eclipse-->
<#--author=Etienne Poirier-->
<#--triggerUpdate=3-->
##Prerequisites

* JDK 8 or higher
* GlassFish 4.1
* Eclipse Mars(4.5) or higher

##Download

[Download](http://java.net/projects/cargotracker/downloads) the source code zip file and expand it somewhere in your file system, ideally into *'/Projects'*. Note that this is a Maven project. 

##Eclipse Download and Setup Instructions

To download and install Eclipse Mars (latest release as of 2015-09-04), go to the Eclipse [download page](https://eclipse.org/downloads/packages/release/Mars/R).
![ ](/ct/e_step1.png)

Choose "Eclipse IDE for Java EE Developers" and make sure to select the download that match your operating system.
![ ](/ct/e_step2.png)

Save the file and unzip it into the desired location. 
Launch Eclipse and create/select an adequate workspace to import the Cargo Tracker project. You can now close the Welcome page.

In the 'Project Explorer' (Window->Show View->Project Explorer), right click and choose Import->Import...
![ ](/ct/e_step3.png)

Maven->'Existing Maven Projects'
![ ](/ct/e_step4.png)

Browse to the location where you unzipped the cargo-tracker project and click 'Finish'. You should end up with a project in the 'Project Explorer' and warnings in the 'Markers' pane.
![ ](/ct/e_step4.png)

##Download and install the Glassfish Plug-ins for Eclipse
Open the 'Servers' view (Window->Show View->Servers) and click the link 'No servers are available. 
Click 'Download additional server adapters. 
![ ](/ct/e_step5.png)

Select GlassFish Tools from the list, Next, Accept the terms of the license agreements. 
GlassFish Tools will be downloaded/installed and allow Eclipse to restart when prompted. 
In the 'Servers' view (Window->Show View->Servers), again, click the link 'No servers are available to create a new server'.
![ ](/ct/e_step6.png)

From the list, expand the GlassFish folder and select GlassFish4, click 'Next. 
Assign an admin and server name if desired. Click 'Next' 

Define a server root by navigating to the location on your hard drive of the install directory of the GlassFish4.X server that you want to use. 

Select the JDK that you want to use. If none are available from the dropdown list, add one through the icon on the right side of the dropdown list. Uncheck any JRE version selected and click 'Add'. Use 'Standard VM' and 'Next'. Select a JDK environment using the 'Directory' button. Click 'Finish'.
![ ](/ct/e_step7.png)

Select the newly create JDK link. Select the JDK from the dropdown list. 'Next' Assign a new admin name and password if you want to. 'Finish'.
![ ](/ct/e_step8.png)

##Fixing inconsistency between the Build Path and the execution environment
![ ](/ct/e_step9.png)

In the 'Project Explorer', right-click the cargo-tracker project, Properties->Java Build Path, Libraries tab. 

Select JRE System Library[JavaSE-XX], click Edit... 

Select Workspace default JRE (jdk1.x.x_xx), Finish.

![ ](/ct/e_step10.png)

Give Eclipse the time to recompile the project.

##Building the project

In the 'Project Explorer', right click on the pom.xml file, Run As->Maven Install
![ ](/ct/e_step11.png)

Depending on your machine capabilities, the first build could take some time. On an Intel Core i5 with 32G of RAM, it took just over 6 minutes.
![ ](/ct/e_step12.png)

##Starting the GlassFish server and Deploying the cargo-tracker project

On the 'Servers' tab, select your GF server and click the 'Restart' button (green play button).
![ ](/ct/e_step13.png)

In the Project Explorer, right-click the cargo-tracker project, 'Run As'->'On server', your GF server should be selected. Check the 'Always use this server when running this project'
![ ](/ct/e_step14.png)

The project main page should be available from within Eclipse or you can also access it from an external browser.
![ ](/ct/e_step15.png)

There is a tracking interface to track the current status of cargo and a booking interface to book and route cargo. You should explore both interfaces before diving into the code. You should also check out the REST and file processing interfaces to register handling events as well as the HTML5/JavaScript client that uses the REST interface and targets mobile devices. You can test against the REST interfaces using our soapUI tests.






