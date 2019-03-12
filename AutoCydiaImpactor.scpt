#@matsuo3rd 2019
#inspired from AutoImpactor v2.0 / https://github.com/Shmadul/AutoImpactor

# Download ClicClick at https://github.com/BlueM/cliclick
# Download SleepDisplay at https://github.com/bigkm/SleepDisplay/zipball/master

set AppleUsername to "APPLE_ID_EMAIL"
set ApplePassword to "APPLE_ID_PASSWORD"
set IPAPath to POSIX path of "IPA_PATH"
set DeviceLabel to "DEVICE_LABEL"
set CliClickPath to "CLICLICK_PATH"
set SleepDisplayPath to "SLEEPDISPLAY_PATH"

set targetDevice to null

# Wakeup Screen - if Screen is Sleeping / cliclick (selecting target device) will not work
if SleepDisplayPath is not null then
	log "Wakeup Display"
	do shell script SleepDisplayPath & " -wake"
end if

log "Launching Impactor"
tell application "Impactor.app" to activate

# Search for TargetDevice in Devices Combo Box
log "Looking for Device " & DeviceLabel
tell application "System Events" to tell process "Impactor"
	click button 1 of combo box 2 of window "Cydia Impactor"
	delay 0.25
	set devices to (text fields of list 1 of scroll area 1 of combo box 2 of window "Cydia Impactor")
	set devicesCount to (count devices)
	
	if devicesCount ≥ 1 then
		repeat with device in devices
			set deviceName to value of device
			if deviceName = DeviceLabel then
				set targetDevice to device
				exit repeat
			end if
		end repeat
	end if
	
	# Get TargetDevice position in Combo Box
	log "Looking for Device's dropdown list x,y position"
	if targetDevice is not null then
		log "Device Found"
		tell targetDevice
			set {xPosition, yPosition} to position of targetDevice
			set {xSize, ySize} to size
		end tell
		set {realXPosition, realYPosition} to {(xPosition + (xSize div 2)) as string, (yPosition + (ySize div 2)) as string}
	else
		log "Device Not Found"
		display dialog "Could not find Target Device " & DeviceLabel
		error number -128
	end if
end tell

# Click Target Device
log "Clicking on Device at m:" & realXPosition & "," & realYPosition & " dc:" & realXPosition & "," & realYPosition
tell application "System Events" to tell process "Impactor"
	click button 1 of combo box 2 of window "Cydia Impactor"
end tell
do shell script CliClickPath & " m:" & realXPosition & "," & realYPosition & " dc:" & realXPosition & "," & realYPosition
delay 0.25

log "Launching Install Package... menu"
tell application "Impactor.app" to activate
tell application "System Events"
	tell process "Impactor"
		click menu item "Install Package..." of menu 1 of menu bar item "Device" of menu bar 1
	end tell
end tell
delay 0.25

# Select IPA file
log "Entering IPA file " & IPAPath
#tell application "System Events"
tell application "System Events" to tell process "Impactor"
	keystroke "G" using {shift down, command down}
	delay 0.25
	keystroke IPAPath
	delay 0.25
	keystroke return
	delay 0.25
end tell

# Open IPA file
log "Opening IPA file"
tell application "System Events"
	tell process "Impactor"
		click button "Open" of window "Open"
	end tell
end tell

delay 1

#"Apple ID Username"
log "Entering Apple ID Username " & AppleUsername
tell application "Impactor.app" to activate
tell application "System Events"
	tell process "Impactor"
		set value of text field 1 of window "Apple ID Username" to AppleUsername
		click button "OK" of window "Apple ID Username"
	end tell
end tell

delay 1

#"Apple ID Password"
log "Entering Apple ID Password"
tell application "System Events"
	tell process "Impactor"
		set value of text field 1 of window "Apple ID Password" to ApplePassword
		click button "OK" of window "Apple ID Password"
	end tell
end tell

# Wait for IPA sideload to complete and quit Cydia Impactor
log "Waiting before quitting Impactor"
delay 60
tell application "Impactor.app"
	quit
end tell


