#!/bin/bash

# usage : datediff '1 Nov' '1 Aug'
datediff () {
		d1=$(date -d "$1" +%s)
		d2=$(date -d "$2" +%s)
		echo $(( (d1 - d2) / 86400 ))
}

recent_user_info () {
		
		
		touch userTmp.txt
 		fichier="userTmp.txt"
		ls -la /home/*/ | cut -f3,7,10,12 -d' ' | grep .bash_logout | cut -f1-3 -d' ' >userTmp.txt; 
		
		date_today=date | cut -f2,3 -d' '
	

		count=0
		
		while read -r ligne; do
			set -- "$ligne"
			dateUserCreate= `cut --complement -f1 -d' ' "$ligne"`
			countDay= `dateUserCreate "$date_today" "$dateUserCreate"`
			if [ "$countDay" -le 3 ]; then
				echo " ------>  $1 is $dateUserCreate and your personnal folder is /home/$1 \n"
				let i = $i + 1
			fi
		done < $fichier
		
		if [ "$count" -eq 0 ]; then
			echo "No user saved during three pass day"
		fi
		
}



xampp () {
		#echo " Adding repository  ~~ #### 0/100 ####~~"
		#sudo add-apt-repository ppa:upubuntu-com/web
		#sleep 2
		echo " Adding repository  ~~ #### 20/100 ####~~"
		sudo apt-get update
		sleep 2
		echo " Adding repository  ~~ #### 40/100 ####~~"
		sudo apt-get install xampp
		sleep 2
		echo " Adding repository  ~~ #### 60/100 ####~~"
		sleep 2
		sudo /opt/lampp/lampp start
		sleep 2
		echo " Starting   ~~ #### 80/100 ####~~"
		sudo /opt/lampp/share/xampp-control-panel/xampp-control-panel
		echo " Launch XAMP control panel  ~~ #### 100/100 ####~~"
		sleep 2
}


ressource_info () {
	free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
	df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
	top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 
}

backup () {
	echo "Not omplemented"
}


usage () {
	echo " Please type correct value ";
}

show_menu () {
	#clear;
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**************** AUTHOR TSUALA Florian 14A349 FS *************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Display user info who editing or create below 3 day ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Download install and launch XAMPP ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Archive user's document who are editing by sudoer in external device ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Percent of Consommation Ressources  ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Quitter ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}

function option_picked () {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        recent_user_info;
		sleep 3;
        show_menu;
        ;;

        2) clear;
            xampp;
			sleep 3;
			show_menu;
            ;;

        3) clear;
            
		sleep 3;
			backup;
            show_menu;
            ;;

        4) clear;
            ressource_info;
			sleep 3;
            show_menu;
            ;;

        x)
		echo " Good Bye "
		exit;
        ;;

        \n)
		echo " Good Bye "
		exit;
        ;;

        *)clear;
        usage;
        show_menu;
        ;;
    esac
   fi
done
