# Setup a MUMPS (GTM) development enviroment in Linux a virtual Machine

## Setup Ubuntu in a virtual machine (*You can skip this section if you have linux already*)
1. Download Virtual Box [here](https://www.virtualbox.org/wiki/Downloads). You can use another VM platform, I just know this one is simple and free
2. Download an Ubuntu image [here](https://ubuntu.com/download/desktop)
3. Install VBox and create a new VM. Select the downloaded image for "iso" and finish through the prompts.
   After setting up the VM and ubuntu installs all the software, your linux distro should be ready to use!
   - Since its a fresh install of ubuntu, your current user will not have sudo permissions to install software. A great video on how to fix this [here](https://www.youtube.com/watch?v=WBgkuGQkwzk)
   
## Installing fis-gtm (MUMPS)
  Open up a terminal and install fis-gtm with 
   ```
   sudo apt-get install fis-gtm
   ```
  Now we want to create folder where we will keep our .m files, I made a folder on the desktop just to make it easy
   ```
   mkdir mumpscode
   ```
   Then lets create our first .m file inside that folder
   ```
   cd mumpscode
   touch helloworld.m
   ```
   Now we can add some code to our file. I installed Visual studio [code](https://code.visualstudio.com/download), but you can use vi or nano via the terminal
   (Inside helloworld.m)
   ```
    write "Hello World",!
   ```
  Now that we have a file to run, we are almost ready to run it. Next lets open up our terminal and enter the following
  ```
  ln -s <path-to-your-folder>/*  ~/.fis-gtm/V6.3-003A_x86_64/r
  source /usr/lib/x86_64-linux-gnu/fis-gtm/V6.3-014_x86_64/gtmprofile
  cp -r (path to mumpscode folder)/* $gtmdir/$gtmver/r
  mumps -run ^helloworld.m (or) mumps -run ^helloworld
  ```
   - Note, your "V6.3-014_x86_64" version may be different than mine, just replace with which ever was installed.
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
