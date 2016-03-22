${bootstrap}${markdown}
<#--title=Running Cargo Tracker with WebLogic-->
<#--author=Reza Rahman-->
<#--triggerUpdate=3-->
<#--origin="https://java.net/projects/cargotracker/pages/Characterization"-->

It is possible to run Cargo Tracker on WebLogic with any Maven capable IDE or without an IDE. In the following instructions we will outline how to do so specifically with NetBeans. The instructions should be generally helpful with running the application any other way using WebLogic such as in another Maven capable IDE like IntelliJ. Note that we currently do not recommend Eclipse due to it's weak support of Maven. For detailed reasons why this is the case, please look [here](https://java.net/jira/browse/CARGOTRACKER-76).


##Installing and Configuring WebLogic

The first step to running Cargo Tracker on WebLogic is properly installing and configuring the application server. For GlassFish this is a trivial matter of unzipping the downloaded distribution anywhere in the file system. For WebLogic the instructions are more involved. We have outlined the instructions that should work for Cargo Tracker below.

* Make sure you have JDK 8+ installed. The version of WebLogic that supports Java EE 7 is WebLogic 12.2.1. It requires JDK 8.

* Download WebLogic 12.2.1 from [here](http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-for-dev-1703574.html). You will need to download the Generic installer (784 MB) for Cargo Tracker. Unfortunately you will not be able to use the Quick Installer (211 MB) for Cargo Tracker due to a bug. In the future it may be possible to use the simpler Quick Installer. You can use your downloaded copy of WebLogic for free using at OTN license.

* Please unzip the zip file. You will find a jar file that is the graphical installer for WebLogic.

* Using the JDK's java executable (not the one for the JRE), run java -jar fmw_12.2.1.0.0_wls.jar. Make sure you are running with admin rights. The installer GUI should start momentarily.

* Accept all the defaults for the "Welcome", "Auto Updates" and "Installation Location" screens. On the "Installation Type" screen, make sure you choose installation type "Complete with Examples". This will make the rest of the setup for this project far simpler for you.

![ ](/ct/wls_step1.png)
 
* Accept the default for the "Prerequisite Checks" screen. Entering your email and password on the "Security Updates" screen is optional, feel free to skip it if you don't want security update notifications.

![ ](/ct/wls_step2.png)
 
* The installation will take a few minutes after you hit "Install" on the "Installation Summary" screen. On the "Installation Complete" screen make sure to keep the "Automatically Launch Quickstart Configuration Wizard" option selected before you hit "Finish". This will launch the domain configuration wizard which makes setting up the domain far easier than doing it manually.

* On the "Configuration" screen you'll need to enter a username and password. You can enter the username/password as weblogic/weblogic1. You should accept all the rest of the defaults on this screen and subsequent screens. Once the wizard is done it will exit and WebLogic will be ready to use.

![ ](/ct/wls_step3.png)
 
## Running Cargo Tracker on WebLogic with NetBeans

The [Cargo Tracker NetBeans instructions with GlassFish](http://git.delabassee.com/ct/NetBeansHowTo.html) largely applies to WebLogic. In this section we will focus on the differences instead of repeating what is common. It will help to open those instructions on another browser tab and flip back and forth with this page.

* For the prerequisites there is obviously no need to install GlassFish if you are using WebLogic. NetBeans 8.1 is still best suited for Cargo Tracker. You should follow the NetBeans instructions to download the project. The initial NetBeans setup will differ however.

* Do not setup GlassFish in NetBeans - we will setup WebLogic instead. After starting NetBeans go in the ‘Services’ tab, right click ‘Servers’ and hit ‘Add Server’.

![ ](/ct/wls_step4.png)
 
* On the ‘Add Server Instance’ dialog, choose WebLogic and give the instance a sensible name. Hit ‘Next’.

![ ](/ct/wls_step5.png)
 
* Point the ‘Server Location’ to where you have WebLogic installed on your file system. Hit ‘Next’.

![ ](/ct/wls_step6.png)
 
* In  the "Instance Properties" screen accept the default domain. Enter the username/password as weblogic/weblogic1. Hit "Finish".

![ ](/ct/wls_step7.png)
 
* After setting up the server follow the NetBeans instructions to open the Cargo Tracker project. After you open the project but before you build, you will need to switch the Maven profile for the project. The project by default builds for GlassFish, not WebLogic. There are minor configuration differences between WebLogic and GlassFish that are handled by the Maven profile. To switch the Maven profile right click on the project and select "Properties". Go to the Configurations tab and select weblogic. Now make sure to hit "Activate". You can now continue with the NetBeans instructions and initially build the project. Before you run the project you will need to set the server for the project as WebLogic instead of GlassFish.

* To set the project target server as WebLogic, right-click the project and select ‘Properties’. Then select ‘Run’. Select the WebLogic instance you just created as the ‘Server’, make sure the ‘Context Path’ is set to ‘/cargo-tracker’, accept the rest of the defaults and hit ‘OK’. You can now follow the rest of the NetBeans instructions and run the project.

![ ](/ct/wls_step8.png)

![ ](/ct/wls_step9.png)
 

## Running Cargo Tracker with Cargo

Cargo Tracker includes support for running the application using the [Cargo](https://codehaus-cargo.github.io/cargo/Home.html) Maven plug-in. As a result you can get the application running simply by entering "mvn cargo:run" in the project directory. Under the hood the Cargo Maven plug-in downloads GlassFish, installs the application server and runs the application against it. This is provided as a convenience quick start of the application that requires minimal effort - certainly avoiding application server setup or an IDE. This is possible because GlassFish can be installed and run by simply unzipping a distributable. Unfortunately a similar minimalist quick start with WebLogic is not currently possible due to it's more involved installation and configuration. As a result we do not currently support running Cargo Tracker using WebLogic via Cargo. Note that Cargo as such does support running against pre-installed and configured WebLogic remote instances. Such support is primarily intended for operational automation rather than the quick start mechanism more relevant for this project.
