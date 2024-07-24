#!/bin/bash
 adb kill-server

adb connect 192.0.0.8
    
# Check phone status using adb
PHONE_STATUS=$(adb shell dumpsys power | grep 'mHoldingDisplaySuspendBlocker')

# Check if the phone status was retrieved successfully
if [ -z "$PHONE_STATUS" ]; then
    echo "Failed to retrieve phone status. Make sure the device is connected and adb is authorized."
    exit 1
fi

# Check if the phone is on or off
if [[ "$PHONE_STATUS" == *"mHoldingDisplaySuspendBlocker=false"* ]]; then
    echo "Phone is off or in sleep mode."

    # Perform actions when phone is off
    # For example, you can turn on the phone
    echo "Waking up the phone..."
   
    # Simulate pressing the power button
    adb shell input keyevent 26

    # Start scrcpy with the screen turned off in the background
    scrcpy --turn-screen-off &

    # Wait for 10 seconds
    sleep 3

    # Simulate a swipe gesture
    adb shell input swipe 100 2000 100 60 500

    # Wait for 1 second
    sleep 1

    # Input text and simulate pressing enter
    adb  shell input text 12345678
else
    echo "Phone is on."
    scrcpy  --turn-screen-off
    
fi
