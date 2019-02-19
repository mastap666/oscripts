#!/bin/bash

###################################
###################################
#### Kali Custom - under GPLv3 ####
#### by Patrick Frei           ####
####                           ####
#### Thanks to the community!  ####
###################################
###################################

# Title
clear

echo "
   __  _   ____  _      ____         __  __ __  _____ ______   ___   ___ ___       _____   __  ____   ____  ____  ______ 
  |  |/ ] /    || |    |    |       /  ]|  |  |/ ___/|      | /   \ |   |   |     / ___/  /  ]|    \ |    ||    \|      |
  |  ' / |  o  || |     |  |       /  / |  |  (   \_ |      ||     || _   _ |    (   \_  /  / |  D  ) |  | |  o  )      |
  |    \ |     || |___  |  |      /  /  |  |  |\__  ||_|  |_||  O  ||  \_/  |     \__  |/  /  |    /  |  | |   _/|_|  |_|
  |     ||  _  ||     | |  |     /   \_ |  :  |/  \ |  |  |  |     ||   |   |     /  \ /   \_ |    \  |  | |  |    |  |  
  |  .  ||  |  ||     | |  |     \     ||     |\    |  |  |  |     ||   |   |     \    \     ||  .  \ |  | |  |    |  |  
  |__|\_||__|__||_____||____|     \____| \__,_| \___|  |__|   \___/ |___|___|      \___|\____||__|\_||____||__|    |__|  
   
                                        by Patrick Frei - v.1.0 - FEB2019
											


												
"

#### Variables ####
read -p "Choose your keyboard layout (ch;de;us): " -i ch -e keyboard
read -p "Choose your system time zone (Europe/Zurich): " -i Europe/Zurich -e timezone
read -p "Choose your ntp server: " -i ch.pool.ntp.org -e ntp
read -p "Install Vmbox guest tools? (y/n): " -i y -e vbox
read -p "Install Custom Tools? (y/n): " -i y -e tools
read -p "Enable SSH with root access? (y/n): " -i n -e ssh
read -p "Install all Kali updates? (y/n): " -i y -e update
echo "

" 


#### main script #####


# expand the ls command
alias ls='ls --color=auto'
echo "alias ls='ls -la --color=auto'" >>~/.bashrc
echo "alias sfs='cd /root/tools/sfs/scripts'" >>~/.bashrc
echo "alias mastap='cd /root/tools/github/mastap666/scripts'" >>~/.bashrc
echo "alias chris='cd /root/tools/github/christiankropf'" >>~/.bashrc

# set keyboard layout
gsettings set org.gnome.desktop.input-sources sources "[('xkb', '$keyboard')]"



#install tools
echo "Default tools will be installed...
----------------------------------
"
sleep 3
apt-get install ntpdate -y
apt-get install terminator -y
apt-get install ipcalc -y
apt-get install mtr -y
if [ $vbox == "y" ]
        then
			apt-get install -y virtualbox-guest-x11 
                
        else
                echo .

fi
echo "
tool installations completed...
"
sleep 3


#set ntp server
echo "

Set ntp server...
-----------------
"
ntpdate $ntp
sleep 3


# enable ssh with root access
echo "

Setup SSH Server...
-------------------
"
if [ $ssh == "y" ]
        then
			echo SSH will be enabled with root access...
			echo "PubkeyAuthentication yes" >/etc/ssh/sshd_config
			echo "PermitRootLogin yes" >/etc/ssh/sshd_config
			/etc/init.d/ssh enable
			/etc/init.d/ssh start
                
        else

                echo No SSH access will be started...

fi
echo "
"
sleep 3


# set timezone
timedatectl set-timezone $timezone


# update kali
echo "
"
if [ $update == "y" ]
        then
                echo Updates will be installed, please sleep...
				sleep 3
                apt-get update -y && apt-get upgrade -y
				nmap --script-updatedb
                apt-get dist-upgrade -y
                
        else

                echo No updates will be installed... 

fi

echo "



Script is complete.... Thank you for using!



"

#### END #####



