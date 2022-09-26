<a name="readme-top"></a>

<p align="center">
  <img width="100" height="100" src="https://raw.githubusercontent.com/OpenCodeyard/ocyclient/dev/assets/images/ocy_logo.png">
</p>

<br>

# OCY Client

This repo contains source code for the official Flutter Client of Open CodeYard

A higly configurable community website template built using Flutter

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <br>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#screenshots">Screenshots</a></li>
        <li><a href="#doc">Documentation</a></li>
        <li><a href="#features">Features</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#project-setup">Project Setup</a></li>
        <li><a href="#how-to-contribute">How to contribute</a></li>
      </ul>
    </li>
    <!-- <li><a href="#roadmap">Roadmap</a></li> -->
    <li><a href="#contact-us">Contact</a></li>
    <!-- <li><a href="#acknowledgments">Acknowledgments</a></li> -->
  </ol>
</details>

<br><br>

## About the project

 &emsp; :construction:**Actively under development**:construction:
 
- ### Built With

  [![Flutter][flutter-image]][flutter-url] &emsp; [![Firebase][firebase-image]][firebase-url]

- ### We are participating in Hacktoberfest 2022
   * Check [Contributing.md](https://github.com/OpenCodeyard/ocyclient/blob/dev/CONTRIBUTING.md) for guidelines on contributing to this repo.
   * Get 4 pr merged and win goodies from Hacktobefest team
   
<p align="center">
<br>
  <a href="https://hacktoberfest.com/"><img width="600" height="300" src="https://camo.githubusercontent.com/adfb41a5209d18a5549b6bdb2c0fce42abc22e1956d75c75dcf3e9f667401173/68747470733a2f2f692e696d6775722e636f6d2f65633538634b492e6a7067"></a>
  <br>
</p>
 
- <details>
  <summary id="screenshots"><b>Screenshots :iphone: </b></summary>
  <br>
  
  Coming Soon
 
</details>

- #### <p id = "doc"> Documentation :notebook: </p>

  * This project uses [Effective Dart Principles]() for documentation
  * Run `dart doc .` from root of project directory to generate documentation webpage.

- #### Features

  * Self Hosted using Firebase
  * FCM for notification (Coming soon)
  * Built using [Provider Architecture](https://pub.dev/packages/provider) for clean state management
  * Google and GitHub login support for User Authentication
  * Custom user management logic using Firestore
  * Data caching for optimised network calls
  * Profile Screen
  * Fluid animations
  * Modern, Material UI (we all love this!)
  * Heavyily documented code (who doesn't like clean code)
 
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

- This project depends heavily on firebase. A few resources to get you started if this is your first Firebase project:

  * [Lab: Firebase for Flutter](https://firebase.google.com/codelabs/firebase-get-to-know-flutter#0)
  * [FlutterFire Plugins](https://firebase.flutter.dev/)

- A few resources to get you started if this is your first Flutter project:

  * [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
  * [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

&emsp; For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- #### Project Setup

  * Flutter App:
    * [Install Flutter](https://docs.flutter.dev/get-started/install)
    * [Setting up your ide](https://flutter.io/ide-setup/)
    * Fork and clone this repository.
    * cd into `ocyclient` directory.
    * Run `flutter clean` command.
    * Run `flutter pub get` command.
    * Run `flutter run` command.
  
  * Firebase:
    * Create a firebase project
    * Add android app with your package name in firebase console.
    * Enable Google Auth from `Authentication` menu in Firebase.
    * Generate `SHA-1 key hash` for your debug keystore from your pc. This needs to be added to `SHA certificate fingerprints` section under your android app in `Firebase project settings`. Without this step **Google login** won't work.
    * Enable ***Cloud Firestore***
      * Recommended rules for Firestore 

          ```JS
            rules_version = '2';
            service cloud.firestore {
              match /databases/{database}/documents {
                match /{document=**} {
                  allow read, write: if
                      request.auth != null;
                }
              }
            }
         ```
    * Enable ***Cloud Storage***
    * Download `google_services.json` from `Console` -> `Project Settings`. File is present in app section. SDK instructions found in the same page
    * (Optional) Enable ***Cloud Messaging*** from Firebase Console if you wan't notifications to work in your app
    * (Optional) If released to play store get `SHA-1 key hash` from playstore and upload them to firebase, otherwise google sign in won't work in play store app.

* #### How to Contribute?
  
    Check [Contributing.md](https://github.com/OpenCodeyard/ocyclient/blob/dev/CONTRIBUTING.md) for guidelines on contributing to this repo.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact Us

&emsp; If you have a question, please feel free to contact us through [email](mailto:support@opencodeyard.tech) or our [telegram community channel](https://telegram.me/Open_Codeyard).

<br><br><br><br>

<p align="center">
  Made with ❤️ by Open Codeyard
  <br><br>
  <a href="https://opensource.org/licenses/MIT"> <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=plastic" /> </a>
</p>






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[flutter-image]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=plastic&logo=Flutter&logoColor=5cc8f8
[flutter-url]: https://flutter.dev
[firebase-image]: https://img.shields.io/badge/firebase-%23039BE5.svg?style=plastic&logo=firebase
[firebase-url]: https://firebase.com/
