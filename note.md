# to generate an APK
  - flutter clean
  - flutter build apk --split-per-abi

# to generate appBundle
  - flutter clean
  - flutter build appbundle

# to rename app or change bundleId
  - rename: ^2.0.1
  - flutter pub global activate rename
  - pub global run rename --bundleId com.example
  - flutter pub global run rename --appname "My app name"


# to change native splash
  - flutter_native_splash:
  - flutter pub run flutter_native_splash:create

# to change icon app
  - flutter_launcher_icons: ^0.10.0
  - flutter pub run flutter_launcher_icons:main