tell application "Finder"
	open document file "Docker.dmg" of folder "Downloads" of home
	repeat until (exists window "Docker")
		delay 1
	end repeat
	if not (exists file "Docker.app" of folder "Applications" of startup disk) then
		display alert "Docker installation will require administrator privileges." message "You will be prompted to enter your administrative credentials. Installation will then continue in the background and may take a few minutes to complete."
		do shell script "cp -R /Volumes/Docker/Docker.app /Applications/Docker.app" with administrator privileges
	end if
	if (exists window "Docker")
		close window "Docker"
	end
	eject disk "Docker"
end tell
