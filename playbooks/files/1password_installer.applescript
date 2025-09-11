tell application "Finder"
	open document file "1Password.zip" of folder "Downloads" of home
	repeat until (file "1Password Installer.app" of folder "Downloads" of home exists)
		delay 1
		end repeat
	open application file "1Password Installer.app" of folder "Downloads" of home
end tell
