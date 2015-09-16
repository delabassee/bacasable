${bootstrap}${markdown}
<#--title=How to setup Cargo Tracker in Eclipse-->
<#--author=Etienne Poirier-->
<#--triggerUpdate=3-->
##Prerequisites

* JDK 8 or higher
* GlassFish 4.1
* Eclipse Mars(4.5) or higher

##Download

[Download](http://java.net/projects/cargotracker/downloads) the source code zip file and unzip it, ideally into *'/Projects'*. Note that this is a Maven project. 

##Eclipse Setup

To download Eclipse Mars (latest release as September 2015), go to the Eclipse [download page](https://eclipse.org/downloads/packages/release/Mars/R) and select 'Eclipse IDE for Java EE Developers'. Make sure to select the download that match your operating system.

![ ](/ct/e_step2.png)

Unzip  into the desired location. Launch Eclipse and create/select an adequate workspace to import the Cargo Tracker project. You can now close the Welcome page.

In the 'Project Explorer' (Window->Show View->Project Explorer), right click and choose 'Import->Import...'

![ ](/ct/e_step3.png)

Select 'Existing Maven Projects' in the 'Maven' entry.

![ ](/ct/e_step4.png)

Select the location where the Cargo Tracker sources have been unzipped and click 'Finish'. 
You should end up with the Cargo Project loaded in the 'Project Explorer' and some warnings in the 'Markers' pane.

![ ](/ct/e_step4.png)

##Install the Glassfish Plug-in for Eclipse

Open the 'Servers' view (Window->Show View->Servers) and click the 'No servers are available' link. 
Click 'Download additional server adapters. 

![ ](/ct/e_step5.png)

Select 'GlassFish Tools' from the list, 'Next' and 'Accept the terms of the license agreements'. 
GlassFish Tools will then be downloaded and installed. To finish this step, Eclipse should be restarted.
In the 'Servers' view (Window->Show View->Servers), click the 'No servers are available to create a new server' link .

![ ](/ct/e_step6.png)

From the list, expand the GlassFish folder and select 'GlassFish 4', click 'Next.  
Assign an admin and server name if necessary, click 'Next'.
Define a server root by navigating to the directory of your GlassFish 4.x installation.
Select the JDK that you want to use. If none are available from the dropdown list, add one through the icon on the right side of the dropdown list. Uncheck any JRE version selected and click 'Add'. Use 'Standard VM' and 'Next'. Select a JDK environment using the 'Directory' button. Click 'Finish'.

![ ](/ct/e_step7.png)

Select the newly created JDK link. Select the JDK from the dropdown list, 'Finish'.

![ ](/ct/e_step8.png)

##Fix inconsistencies between the Build Path and the environment

![ ](/ct/e_step9.png)

In the 'Project Explorer', right-click the Cargo Tracker project, 'Properties->Java Build Path', 'Libraries' tab. 
Select 'JRE System Library[JavaSE-XX]', click 'Edit...'; select 'Workspace default JRE (jdk1.x.x_xx)', then 'Finish'.

![ ](/ct/e_step10.png)

Give Eclipse some time to compile the project...

##Build Cargo Tracker

In the 'Project Explorer', right click on the pom.xml file, 'Run As->Maven Install'

![ ](/ct/e_step11.png)

Depending on your machine capabilities, the initial build might take some time...

![ ](/ct/e_step12.png)

##Deploy Cargo Tracker

On the 'Servers' tab, select your GlassFish instance and click 'Restart'.

![ ](/ct/e_step13.png)

In the 'Project Explorer', right-click the Cargo Tracker project, 'Run As'->'On server', your GF instance should be selected. Check the 'Always use this server when running this project'.

![ ](/ct/e_step14.png)

The project main page should be available from within Eclipse or you can also access it from any external browser.

![ ](/ct/e_step15.png)

There is a tracking interface to track the current status of cargo and a booking interface to book and route cargo. You should explore both interfaces before diving into the code. You should also check out the [REST](https://java.net/projects/cargotracker/sources/svn/content/tags/1.0/src/main/java/net/java/cargotracker/interfaces/handling/rest/HandlingReportService.java) and [file processing](https://java.net/projects/cargotracker/sources/svn/content/tags/1.0/src/main/java/net/java/cargotracker/interfaces/handling/file/UploadDirectoryScanner.java) interfaces to register handling events as well as the HTML5/JavaScript client that uses the REST interface and targets mobile devices. You can test against the REST interfaces using our [soapUI tests](https://java.net/projects/cargotracker/sources/svn/show/tags/1.0/src/test/soapui).
