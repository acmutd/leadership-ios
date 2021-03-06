# Leadership Project App

iOS App designed to view the information available through the leadership project.

### How to use

 - Install XCode
 - Sign in with your ACM account to the [firebase console](https://console.firebase.google.com)
 - Open the `acm-core` project & open the project settings page
 - Scroll down to see the list of Apps & find the `Leadership iOS App`
 - Download the `GoogleService-Info.plist` file.
 - Open the project in XCode & move the `.plist` file to the root of the project.
 - Install the `firebase-ios-sdk` and `GoogleSignIn` packages with the Swift Package Manager. Note: This project does not use Cocoa Pods.
 - Follow the steps [here](https://developers.google.com/identity/sign-in/ios/start-integrating) to setup Google Sign In for your application. You'll find the correct OAuth Client ID to use in the `Cloudflare Access` project in the Google Cloud console. Note: Only the OAuth Client ID portion of this setup part does not use the `acm-core` project.
 - Open the `ContentView.swift` file in XCode & add the Client ID where it says `INSERT-TOKEN-HERE`. 
 - Run the project.

### Contributors

- [Harsha Srikara](https://harshasrikara.dev)

### Questions

Sometimes you may have additional questions. If the answer was not found in this readme please feel free to reach out to the [Director of Development](mailto:development@acmutd.co) for _ACM_

We request that you be as detailed as possible in your questions, doubts, or concerns to ensure that we can be of maximum assistance. Thank you!

![ACM Development](https://brand.acmutd.co/Development/Banners/light_dark_background.png)
