# CalculatorLoggerChallenge

## Overview
This is the challenge project to create a mobile app (iOS) which logs calculations as they happen and shares those calculations with everyone connected to the app.  I chose to use Swift for the source code and Firebase for backend authentication and services.

## Steps to Build and Run
1. Clone this repository onto your local machine
2. Ensure you have at least XCode 11.7 and an iOS device running iOS 13.7 (due to an XCode bug in XCode 12, you may have to unpair your device and then repair it again).
3. In order to connect to the Firebase authentication and database services you will to request my GoogleService-Info.plist file or create your own instance of that project in the Firebase console.
4. cd into the project directory and run `pod install`
5. When you open the project in XCode be sure to open the .xcworkspace file
6. You will have to adjust your Team / Provisioning Profile to values that work for you developer profile.
7. At this point, you should be free to build and run the application on your device or simulator.
