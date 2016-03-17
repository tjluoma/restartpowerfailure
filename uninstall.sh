#!/bin/zsh -f

NAME="$0:t:r"

PLIST='/Library/LaunchDaemons/com.tjluoma.setrestartpowerfailure.on.plist'

if [[ ! -e "$PLIST" ]]
then
	echo "$NAME: $PLIST does not exist."
	exit 0
fi 

function die
{
	echo "$NAME: $@"
	exit 1
}

sudo -v -p "

	Your administrator password is required to continue. 
	This is the password that you use to log in to your '%u' account on this computer.
	Password: "

####################################################################################

LABEL=`defaults read "$PLIST" Label`

sudo launchctl stop "$LABEL" \
|| die "launchctl stop: failed"

echo "$NAME: launchctl stop $LABEL was successful"

####################################################################################

sudo launchctl unload "$PLIST" \
|| die "launchctl unload failed"

echo "$NAME: launchctl unload $LABEL was successful"

####################################################################################

sudo rm -f "$PLIST" \
|| die "Failed to remove $PLIST"

echo "$NAME: rm (remove) $PLIST was successful"

####################################################################################

echo "$NAME: Exiting after all steps were successful."

####################################################################################

exit 0
