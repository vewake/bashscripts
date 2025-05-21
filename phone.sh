#!/bin/bash
PHONE_IP=$(arp -a | grep '(' | awk -F '[()]' '{print $2}')
PHONE_SERIAL=$(adb devices | head -n 2 | tail -n 1 | awk '{print $1}')
if [ -n "$PHONE_SERIAL" ]; then
  echo "Phone is already connected no need to connect again"
else
  adb connect $PHONE_IP
fi
PHONE_SERIAL=$(adb devices | head -n 2 | tail -n 1 | awk '{print $1}')
echo "Phone serial: $PHONE_SERIAL"
kdialog --passivepopup "adb successfully connected" 3
PHONE_STATUS=$(adb -s $PHONE_SERIAL shell dumpsys power | grep 'mHoldingDisplaySuspendBlocker')
if [ -z "$PHONE_STATUS" ]; then
  echo "Failed to retrieve phone status. Make sure the device is connected and adb is authorized."
  kdialog --passivepopup "Failed to retrieve phone status. Make sure the device is connected and adb is authorized." 3
  exit 1
fi

# Check if the phone is on or off
if [[ "$PHONE_STATUS" == *"mHoldingDisplaySuspendBlocker=false"* ]]; then

  # pressing the power button
  adb -s $PHONE_SERIAL shell input keyevent 26
  scrcpy -s $PHONE_SERIAL --turn-screen-off &
  sleep 3
  kdialog --passivepopup "scrcpy connected successfully" 2
  sleep 1
  phonePassword=$(kdialog --password "Phone Password")
  adb -s $PHONE_SERIAL shell input swipe 100 2000 100 60 500
  sleep 1
  adb -s $PHONE_SERIAL shell input text $phonePassword
  kdialog --passivepopup "DONE!" 2
else
  kdialog --passivepopup "DONE!" 2
  scrcpy -s $PHONE_SERIAL --turn-screen-off

fi
