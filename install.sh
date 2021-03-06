#!/bin/zsh -f

NAME="$0:t:r"

INSTALL_TO='/Library/LaunchDaemons/com.tjluoma.setrestartpowerfailure.on.plist'

PLIST_URL='https://raw.githubusercontent.com/tjluoma/restartpowerfailure/master/com.tjluoma.setrestartpowerfailure.on.plist'

if [[ -e "$INSTALL_TO" ]]
then
	echo "$NAME: $INSTALL_TO already exists. You must remove this file to continue."
	exit 0
fi 

function die
{
	echo "$NAME: $@"
	exit 1
}

zmodload zsh/datetime # needed for strftime

TIME=`strftime "%Y-%m-%d--%H.%M.%S" "$EPOCHSECONDS"`

function timestamp { strftime "%Y-%m-%d--%H.%M.%S" "$EPOCHSECONDS" }

TEMPDIR="${TMPDIR-/tmp}/${NAME}.${TIME}.$$.$RANDOM"

mkdir -p "$TEMPDIR" \
|| die "Failed to create dir: $TEMPDIR"

cd "$TEMPDIR" \
|| die "Failed to chdir to $TEMPDIR"


curl --location --remote-name --progress-bar "$PLIST_URL" \
|| die "curl failed"

if [ ! -s "com.tjluoma.setrestartpowerfailure.on.plist" ]
then
	echo "$NAME: Failed to download $PLIST_URL"
	exit 1
fi 

sudo -v -p "

	Your administrator password is required to continue. 
	This is the password that you use to log in to your '%u' account on this computer.
	Password: "

####################################################################################
	
chmod 644 "com.tjluoma.setrestartpowerfailure.on.plist" \
|| die "chmod failed"

echo "$NAME: chmod was successful"

####################################################################################

sudo chown root:wheel "com.tjluoma.setrestartpowerfailure.on.plist" \
|| die "chown failed"

echo "$NAME: chown was successful"

####################################################################################

sudo mv -v "com.tjluoma.setrestartpowerfailure.on.plist" "$INSTALL_TO" \
|| die "Failed to move 'com.tjluoma.setrestartpowerfailure.on.plist' to $INSTALL_TO"

echo "$NAME: mv (move) was successful"

####################################################################################

sudo launchctl load "$INSTALL_TO" \
|| die "launchctl load failed"

echo "$NAME: launchctl load was successful"

####################################################################################

echo "$NAME: Exiting after all steps were successful."

####################################################################################

exit 0

