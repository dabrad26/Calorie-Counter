#  Calorie Counter iOS Application

## Details

Final Project by David Bradshaw (@dabrad26) for iOS App Productions (CSE-41249) course for UC San Diego Extended Studies in Winter 2024

## Setup

Create a new file called secrets.plist (use the secrets-example.plist file for reference). You must paste your secret in this PLIST file. This file is not commited.  Be sure to go to Build Phases > Copy Bundle Resources and be sure this file shows in this list.  You can request an API key from https://fdc.nal.usda.gov/api-key-signup.html.

## Tech Stack

- Swift
- SwiftUI

## Navigation

### Today (Tab)
- HOME Page
- View the current day intake

### History (Tab)
- View infinite scroll list of days and food

### Create new entry (CTA)
- Pop up window to add a new item
- Fields: Search (API from USDA), or add text. Fill in items (Calories, servings, Fat...)
### My Foods
- Add custom foods that you use frequently (searches in the Create flow)
### Account
- Delete your account
- export your data

## API Source

https://fdc.nal.usda.gov/api-guide.html#bkmk-8

## Design Guide

### Colors (Light, Dark):
- Text:  System.Primary, System.Primary
- Primary:  #2FA0FC, #2FA0FC
- Secondary:  #F2FA25, #878c03
- Tertiary:  #FA2D25, #FA2D25
- Accent 1:  #A55350, #522928
- Accent 2:  #50677A, #28333d
- Accent 3:  #18F583, #5FC877

