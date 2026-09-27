# ReachOut

Community help app built in Flutter for a hackathon. People post what they need help with, set a price, and others in the community can pick it up. Built-in video calls, a Gemini chatbot and live location make it easy to coordinate.

## Features

- **Help posts.** Create a post with what you need and a price. The feed updates live from Firestore.
- **Location.** Share your current position and open directions to a request in Google Maps.
- **Video calls.** Call the person you're helping without leaving the app (ZEGOCLOUD).
- **Gemini assistant.** Chatbot for quick questions, plus daily hygiene and wellbeing tips.
- **Accounts.** Email sign-up and login with Firebase Auth.

## Stack

Flutter, Dart, Firebase Auth, Cloud Firestore, Google Maps, Geolocator, flutter_gemini, ZEGOCLOUD call kit.

## Run it

```bash
flutter pub get
flutter run --dart-define=GEMINI_API_KEY=your_key
```

Point `lib/firebase_options.dart` at your own Firebase project (`flutterfire configure`).
