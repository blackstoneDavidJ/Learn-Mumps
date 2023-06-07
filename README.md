# Purpose
- This is a repo that was created in hopes to make a hub of information regarding MUMPS programming, specifically with fis-gtm as it is open source.
- Here you will find code examples that I wrote, links to useful information, installation guide, and common troubleshooting tips
- Please feel free to reach out about any changes :) - DJB

# Useful Information
- [fis-gtm Programmer's guide](http://tinco.pair.com/bhaskar/gtm/doc/books/pg/UNIX_manual/index.html)
- [fis-gtm Manual](http://www.mumps.cz/gtm/books/pg/UNIX_manual/webhelp/content/preface.html)
- [VS Code Extension: Language Pack](https://marketplace.visualstudio.com/items?itemName=jewuma.mumps-debug)
- [VS Code Extension: Syntax highlighting](https://marketplace.visualstudio.com/items?itemName=dsilin.mumps)
- [MUMPs / VISTA Tutorial](https://www.youtube.com/playlist?list=PLK0c6PKmcrdAhNmEzI8YFnDmHojqrTINw)
- [InterSystems Caché Documentation](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GORIENT_ch_intro#GORIENT_intro_sql)
# Setup a MUMPS (GTM) development enviroment in Linux a virtual Machine

## Setup Ubuntu in a virtual machine (*You can skip this section if you have linux already*)
1. Download Virtual Box [here](https://www.virtualbox.org/wiki/Downloads). You can use another VM platform, I just know this one is simple and free
2. Download an Ubuntu image [here](https://ubuntu.com/download/desktop)
3. Install VBox and create a new VM. Select the downloaded image for "iso" and finish through the prompts.
   After setting up the VM and ubuntu installs all the software, your linux distro should be ready to use!
   - Since its a fresh install of ubuntu, your current user will not have sudo permissions to install software. 
   
## Installing fis-gtm (MUMPS)
  Open up a terminal and install fis-gtm with 
   ```
   sudo apt-get install fis-gtm
   ```
  Now we want to create folder where we will keep our .m files, I made a folder on the desktop just to make it easy
   ```
   mkdir mumpscode
   ```
   Next lets open up our terminal and enter the following
   - Note, your "V6.3-014_x86_64" version may be different than mine, just replace with which ever was installed.
   ```
     source /usr/lib/x86_64-linux-gnu/fis-gtm/V6.3-014_x86_64/gtmprofile
     ln -s /home/vboxuser/Desktop/mumpscode/*  ~/.fis-gtm/V6.3-014_x86_64/r
     
  ```
   - Note, replace my */home/home/vboxuser/Desktop/mumpscode/* with where your folder is
   Then lets create our first .m file inside that folder
   ```
   cd mumpscode
   touch helloworld.m
   ```
   Now we can add some code to our file. I installed Visual studio [code](https://code.visualstudio.com/download), but you can use vi or nano via the terminal
   (Inside helloworld.m)
   ```
   <insert one tab or space here>write "Hello World",!
   ```
  Now for the last step, every time you want to run your mumps file, run these commands (can copy paste it all into the terminal)
  ```
  source /usr/lib/x86_64-linux-gnu/fis-gtm/V6.3-014_x86_64/gtmprofile
  cp -r /home/vboxuser/Desktop/mumpscode/* $gtmdir/$gtmver/r
  mumps -run ^helloworld.m (or) mumps -run ^helloworld
  ```
  - Note, hellworld.m seems to only work on older version of fis-gtm. try without the file extension.
  And that's it, you should the following output in your terminal.
  ```
  Hello World
  ```
  
## Troubleshooting
  - Error: "Error accessing database ... Must be recoved on cluster node"
  - Solution(not a good one): run commands
  ```
  $gtm_dist/mupip rundown -r "*"
  $gtm_dist/mupip rundown
  ```
  - These commands *should* fix the issue :), but deletes all globals
