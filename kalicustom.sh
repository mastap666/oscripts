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
   
                                        by Patrick Frei - v.1.5 - FEB2019
											


												
"

#### Variables ####
read -p "Choose your keyboard layout (ch;de;us): " -i ch -e keyboard
read -p "Choose your system time zone (Europe/Zurich): " -i Europe/Zurich -e timezone
read -p "Choose your ntp server: " -i ch.pool.ntp.org -e ntp
read -p "Install Vmbox guest tools? (y/n): " -i y -e vbox
read -p "Install Custom Tools? (y/n): " -i y -e tools
read -p "Enable SSH with root access? (y/n): " -i n -e ssh
read -p "Change root password? (y/n): " -i n -e password
read -p "Install all Kali updates? (y/n): " -i y -e update
echo "

" 


#### main script #####


# expand the ls command
alias ls='ls -lan --color=auto'


# set keyboard layout
gsettings set org.gnome.desktop.input-sources sources "[('xkb', '$keyboard')]"



#install tools
echo "Default tools will be installed...
----------------------------------
"
sleep 3
apt-get install ntpdate -y
if [ $tools == "y" ]
		then 
			echo "
			
Custom tools will be installed...
----------------------------------

			"
			sleep 3
			apt-get install terminator -y
			apt-get install ipcalc -y
			apt-get install mtr -y
			echo "
			
tool installations completed...

"
			sleep 3
	elif [ $vbox == "y" ]
        then
			apt-get install -y virtualbox-guest-x11 
    




fi



#set ntp server
echo "

Set ntp server...
-----------------
"
ntpdate $ntp
sleep 3


# enable ssh with root access
if [ $ssh == "y" ]
        then
		echo "

Setup SSH Server...
-------------------

"
			echo SSH will be enabled with root access...
			echo "PubkeyAuthentication yes" >/etc/ssh/sshd_config
			echo "PermitRootLogin yes" >/etc/ssh/sshd_config
			/etc/init.d/ssh enable
			/etc/init.d/ssh start 

fi
echo "
"
sleep 3


# set timezone
timedatectl set-timezone $timezone


#set new password
if [ $password == y ]
		then
			echo "

change root password...
-------------------

"
			sleep 2
			passwd root
			sleep 5
			
fi

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



