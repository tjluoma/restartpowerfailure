#!/bin/zsh -f
##
## Purpose: This script will install a launchd plist to check to make sure that the Mac is set to restart automatically after a power failure
##
## Description: Mac OS X has a setting which is designed to automatically restart a Mac if the power goes out. However, for some reason this 
## feature keeps getting set to “off” even after the user has set it “on”. In order to alleviate that problem, this script (and a launchd plist)
## will check periodically to make sure that the setting has not been turned “off” and if it has been, then it will be turned back on. 
##
## Due to OS X’s requirements, this script must be run as an administrator (which is accomplished using 'sudo' even if the user forgets).
##
## This script is released free of charge for anyone to modify and change it as they see fit, but comes without any warranty, expressed or implied.
## Use at your own risk.
##
## From:	Timothy J. Luoma
## Mail:	luomat at gmail dot com
## Date:	2016-03-16
## Originally written for Mac OS X 10.11.3

	## This determines how often the check should be run to make sure everything is ok
	## The value is in seconds.
	## 86400 seconds = 24 hours
INTERVAL='86400'

	## This is the filename that will be used. It does not need to be changed,
	## but _can_ be if you have a good reason.
	## 
	## You can change the end of it (the filename portion), 
	## but it MUST end with ".plist"
	## and it SHOULD be saved to "/Library/LaunchDaemons" 
	## unless you are 100% sure you know what you are doing
	##
	## Installing it to "/Library/LaunchDaemons" ensures that it will run 
	## even if no user is logged into the console 
PLIST=/Library/LaunchDaemons/com.tjluoma.restartpowerfailure.plist



####|####|####|####|####|####|####|####|####|####|####|####|####|####|####
#
#		You should not need to change anything below this line.
#
####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

if [ "$EUID" != "0" ]
then
	echo "$0 must be run as root, re-running via 'sudo'"

	exec sudo "$0" "$@"

	exit 0
fi

####|####|####|####|####|####|####|####|####|####|####|####|####|####|####
#
# If you want to define your own PATH here, you can 
#
PATH='/usr/local/scripts:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin'

####|####|####|####|####|####|####|####|####|####|####|####|####|####|####
##
# $NAME will be able to be used as a way to refer to the filename
## of this script, without the path or extension added 
## 
NAME="$0:t:r"

## Diagnostic and information messages will be saved here
LOG="/var/log/$NAME.log"

## This is needed by zsh to use 'strftime' 
zmodload zsh/datetime

## This gives us a quick way to include the current time in the log files 
function timestamp { strftime "%Y-%m-%d at %H:%M:%S" "$EPOCHSECONDS" }

## By using 'log' followed by a message, it will be sent to stdout as well as the log file 
function log { echo "$NAME [`timestamp`]: $@" | tee -a "$LOG" }

####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

function create_plist {
		## If the plist file does not exist, create it
		
		:
}


function turn_restart_after_power_failure_on {
	## if the setting is off, turn it on 		
		:
		
}


function get_current_status {
		## put the current status of the 'systemsetup -getrestartpowerfailure' command
		## into a variable named "$CURRENT_STATUS"

		CURRENT_STATUS=`systemsetup -getrestartpowerfailure 2>&1 | tee -a "$LOG"`
		
		
}







####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

## Check the current status 
get_current_status

case "$CURRENT_STATUS" in	

	####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

	"Restart After Power Failure: On")

		log "The setting is correctly set (turned on)"
		
		## check to make sure plist exists
		## check to make sure plist is loaded 
		
		
		exit 0
	;;
	
	####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

	"Restart After Power Failure: Off")
		:

		## turn on 
		## check to make sure plist exists
		## check to make sure plist is loaded 

		# Do stuff
	;;
	
	####|####|####|####|####|####|####|####|####|####|####|####|####|####|####
	
	"Restart After Power Failure: Not supported on this machine.")
		log "This Mac does not support the Restart After Power Failure feature"
		
			## If the plist exists, log an error because there's no reason to keep running it 
		if [[ -e "$PLIST" ]]
		then
			log "Attempting to remove the file $PLIST so this does not run automatically."
			
			LABEL=`defaults read "$PLIST" Label"`
			
			launchctl stop "$LABEL" 2>/dev/null
			
			launchctl unload "$PLIST" 2>/dev/null
			
			/bin/rm -f "$PLIST" 
			
			if [[ -e "$PLIST" ]]
			then
				log "Failed to delete $PLIST"
				exit 1
			else
				log "$PLIST was successfully removed."
			fi		
		fi 
		
		exit 0
	;;
	
	
	####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

	
	*)
		log "The output of 'systemsetup -getrestartpowerfailure' was: $CURRENT_STATUS however I do not know what to do with that information. I will try again in $INTERVAL seconds"
		exit 0
	;;

esac

####|####|####|####|####|####|####|####|####|####|####|####|####|####|####






exit 0
#EOF
