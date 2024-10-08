#!/bin/bash
adb connect 192.168.0.124
kdialog --passivepopup "adb successfully connected" 3
# Check phone status using adb
PHONE_STATUS=$(adb shell dumpsys power | grep 'mHoldingDisplaySuspendBlocker')

if [ -z "$PHONE_STATUS" ]; then
  echo "Failed to retrieve phone status. Make sure the device is connected and adb is authorized."
  kdialog --passivepopup "Failed to retrieve phone status. Make sure the device is connected and adb is authorized." 3
  exit 1
fi

# Check if the phone is on or off
if [[ "$PHONE_STATUS" == *"mHoldingDisplaySuspendBlocker=false"* ]]; then

  # pressing the power button
  adb shell input keyevent 26
  scrcpy --turn-screen-off &
  sleep 3
  kdialog --passivepopup "scrcpy connected successfully" 2

  sleep 1

  phonePassword=$(kdialog --password "Phone Password")
  adb shell input swipe 100 2000 100 60 500
  #🙂🙂🙂
  if [[ "$phonePassword"=="a" ]]; then
    adb shell input text YourPassword
  else
    adb shell input text $phonePassword
  fi
  kdialog --passivepopup "DONE!" 2
else
  kdialog --passivepopup "DONE!" 2
  scrcpy --turn-screen-off

fi
