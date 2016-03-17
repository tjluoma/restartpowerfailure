# restartpowerfailure

Purpose: This script will install a launchd plist to check to make sure that the Mac is set to restart automatically after a power failure

![OS X version 10.11.3 Energy Saver Preference Panel](system-preferences.jpg)

OS X has a setting which is designed to automatically restart a Mac if the power goes out. However, for some reason this 
feature keeps getting set to “off” even after the user has set it “on”. In order to alleviate that problem, this script (and a launchd plist)
will check periodically to make sure that the setting has not been turned “off” and if it has been, then it will be turned back on. 

_Note:_ some Macs, such as the MacBook (Retina, 12-inch, Early 2015), do not support this feature. Look for a setting in **System Preferences.app** under “Energy Saver” for a setting like the one shown above.

## Requires Administrator Permissions

Due to OS X’s requirements, this script must be run as an administrator (which is accomplished using 'sudo' even if the user forgets).

## License and (Lack of) Warranty 

This script and its related plist are released free of charge for anyone to use, modify, and change it in any way they see fit.
All I ask if that my name be listed as a contributor and a link to the original at https://github.com/tjluoma/restartpowerfailure be included. 

***This script comes without any guarantee/warranty/etc, expressed or implied.***

Use at your own risk.

## How to install/run

1.	Launch "/Applications/Utilities/Terminal.app" 

2.	Copy and paste these three lines:

	cd ~/Desktop/
	
	curl -LO http://luo.ma/restartpowerfailure.sh
	
	sudo zsh ./restartpowerfailure.sh

### “What do those lines do?”

The first line: `cd ~/Desktop/` changes the directory that you are in (`cd`) to your Desktop (`~/Desktop`). When you paste that line into Terminal, you will not see any feedback, it simply changes the directory that you are in.

The second line `curl -LO http://luo.ma/restartpowerfailure.sh` will download the file `restartpowerfailure.sh` from the server `http://luo.ma/`. In this case, <http://luo.ma/restartpowerfailure.sh> is a simple redirect to <https://raw.githubusercontent.com/tjluoma/restartpowerfailure/master/restartpowerfailure.sh> which you can verify by clicking on the link to <http://luo.ma/restartpowerfailure.sh>. You can use the `githubusercontent.com` URL instead if you prefer, the short URL is provided simply to avoid line wrapping.

Note that the `curl -LO` command is `curl` followed by `-` followed by an uppercase `L` and uppercase `O` (NOT a zero). It is the same as `curl --location --remote-name`.

When you paste the `curl` line in to Terminal, you will see a few lines which will look similar to this:


	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
									 Dload  Upload   Total   Spent    Left  Speed
	100   275  100   275    0     0   1432      0 --:--:-- --:--:-- --:--:--  1439
	100  5239  100  5239    0     0   4531      0  0:00:01  0:00:01 --:--:-- 45163


The `sudo zsh ./restartpowerfailure.sh` is where you are _actually_ running the shell commands found in the file `./restartpowerfailure.sh`.

You will be prompted for your password. Use the same password that you use to log in to your Mac.

If you have not used `sudo` before, you may see a scary-looking warning like this:

	WARNING: Improper use of the sudo command could lead to data loss
	or the deletion of important system files. Please double-check your
	typing when using sudo. Type "man sudo" for more information.

	To proceed, enter your password, or type Ctrl-C to abort.

You should _never_ run `sudo` on any file that you have downloaded from the Internet unless you fully trust what it is going to do.





.
