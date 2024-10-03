#!/bin/bash
phonePassword=$(kdialog --password "Phone Password")
adb shell input text $phonePassword
