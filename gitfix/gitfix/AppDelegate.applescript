--
--  AppDelegate.applescript
--  gitfix
--
--  Created by wahlmanj on 12/21/14.
--  Copyright (c) 2014 wahlmanj. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property theWindow : missing value
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
        set fileAsPOSIX to (POSIX path of "/etc/paths")
        set theString to quoted form of "/usr/local/git/bin"
        try
           set searchResult to do shell script "/usr/bin/grep -ic " & theString & space & quoted form of fileAsPOSIX
           if searchResult is equal to "1" then
               display dialog "Git crit already patched!..." with title "Git Status"
               set x to do shell script "export PATH=/usr/local/git/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH; which git"
               display dialog x with title "Git Status"
               end if
               end try
        try
            set searchResult to do shell script "/usr/bin/grep -ic " & theString & space & quoted form of fileAsPOSIX
            on error
            display dialog "Patching git crit..." with title "Git Status"
            do shell script "cd /Applications; curl -L https://github.com/wahlmanj/git/raw/master/git.zip > git.zip; ditto -xk git.zip /Applications; hdiutil attach /Applications/git-2.2.1-intel-universal-snow-leopard.dmg; cp /Volumes/Git\\ 2.2.1\\ Snow\\ Leopard\\ Intel\\ Universal/git-2.2.1-intel-universal-snow-leopard.pkg /Applications; sudo installer -pkg /Applications/git-2.2.1-intel-universal-snow-leopard.pkg -target /; hdiutil unmount /Volumes/Git\\ 2.2.1\\ Snow\\ Leopard\\ Intel\\ Universal; chmod 777 /Applications/git.zip; cd /Applications; rm git.zip" with administrator privileges
            do shell script "cd /etc; echo '/usr/local/git/bin' | cat - paths > temp && mv temp paths" with administrator privileges
            do shell script "chmod 777 /Applications/git-2.2.1-intel-universal-snow-leopard.pkg" with administrator privileges
            do shell script "chmod 777 /Applications/git-2.2.1-intel-universal-snow-leopard.dmg" with administrator privileges
            do shell script "rm /Applications/git-2.2.1-intel-universal-snow-leopard.pkg" with administrator privileges
            do shell script "rm /Applications/git-2.2.1-intel-universal-snow-leopard.dmg" with administrator privileges
            set fileAsPOSIX to (POSIX path of "/etc/paths")
            set theString to quoted form of "/usr/local/git/bin"
            set searchResult to do shell script "/usr/bin/grep -ic " & theString & space & quoted form of fileAsPOSIX
            if searchResult is equal to "1" then
                display dialog "Git crit patch successful!..." with title "Git Status"
                set x to do shell script "export PATH=/usr/local/git/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH; which git"
                display dialog x with title "Git Status"
                
            end if
        end try
        do shell script "killall gitfix"
        
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_

end script