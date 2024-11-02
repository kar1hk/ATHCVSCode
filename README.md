# CVSFicklr

## Overview
I have made this CVSFicklr as a SwiftUI application that showcases Flickr photos with the option to integrate both CVS and Aetna branding themes as whitelabel app. 

## Built with
Xcode 16.0 

## Key-Highlights
1. The app is designed with reusable components for network management and UIKit - We can also move them to a package and integrate with SPM - I have not done this due to time constraints.
2. Meets Acceptance Criteria :
   - Search is enabled for each key stroke and API call is made to get list of streams.
   - Progress Indicator is show when API call is in the background for better UX.
   - Detail View with Title / Image / Description / Author and *formatted* Published On is available.
   - Unit test cases covering succeess scenario for photo stream.
3. Voice Over - Accessibility is added for Home screen with Search bar and Photo Cards.
4. Added Photo Stream Error Unit Test cases.
5. Supports landscape view.
6. Image Width and Height is parsed from description and shown in Detail view.

## Branding
You can also change the look of the app by changing the branding option in *'CVSFicklrApp.swift'* 

Change : Line 16 : `CVSUIKit.shared.brand = .Aetna` to `CVSUIKit.shared.brand = .CVS`

to view the changes in color themeing.

I enjoyed working on this project and looking forward meeting the team.

-------------
Karthik Sankar
