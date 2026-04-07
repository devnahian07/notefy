# Notefy 📝

A cross-platform note-taking application built with Flutter and Firebase. Create, edit, and share your notes seamlessly across devices with real-time cloud synchronization.

## Features

- **User Authentication** – Secure email/password authentication with Firebase Auth
- **Email Verification** – Account verification via email for added security
- **Password Recovery** – Forgot password functionality with email reset
- **Real-time Cloud Sync** – Notes automatically sync to Firebase Firestore
- **Create & Edit Notes** – Intuitive note creation and editing experience
- **Delete Notes** – Swipe-to-delete functionality for easy note management
- **Share Notes** – Share your notes with others using the native share dialog
- **Offline Support** – Local SQLite database for offline access
- **Cross-platform** – Runs on Android, iOS, Web, Windows, macOS, and Linux

## Screenshots

<!-- Add screenshots here -->
<!-- ![Home Screen](screenshots/home.png) -->
<!-- ![Note Editor](screenshots/editor.png) -->

## Tech Stack

- **Framework**: Flutter 3.10+
- **State Management**: BLoC (flutter_bloc)
- **Backend**: Firebase (Auth, Firestore, Analytics)
- **Local Database**: SQLite (sqflite)
- **Architecture**: Clean Architecture with BLoC pattern

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management |
| `firebase_core` | Firebase initialization |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Cloud database |
| `firebase_analytics` | Analytics tracking |
| `sqflite` | Local SQLite database |
| `share_plus` | Native share functionality |
| `equatable` | Value equality for BLoC states |

## Getting Started

### Prerequisites

- Flutter SDK (^3.10.7)
- Dart SDK (^3.10.7)
- Firebase project configured
- Android Studio / Xcode (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/notefy.git
   cd notefy
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable **Authentication** (Email/Password)
   - Enable **Cloud Firestore**
   - Download and add your Firebase configuration files:
     - `google-services.json` for Android (`android/app/`)
     - `GoogleService-Info.plist` for iOS (`ios/Runner/`)
   - Update `lib/firebase_options.dart` with your project configuration

4. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── constants/          # App constants and route definitions
├── enums/              # Enum definitions
├── extensions/         # Dart extensions
├── helpers/            # Helper classes (loading screens, etc.)
├── services/
│   ├── auth/           # Authentication service & BLoC
│   │   └── bloc/       # Auth BLoC (events, states, bloc)
│   ├── cloud/          # Firebase Cloud Firestore service
│   └── crud/           # Local SQLite CRUD operations
├── utilities/          # Dialogs and generic utilities
├── views/
│   ├── notes/          # Note-related views
│   ├── login_view.dart
│   ├── register_view.dart
│   ├── verify_email_view.dart
│   └── forgot_password_view.dart
└── main.dart           # App entry point
```

## Firebase Firestore Structure

```
notes (collection)
├── {documentId}
│   ├── owner_user_id: string
│   └── text: string
```

## Building for Production

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Running Tests

```bash
flutter test
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Firebase](https://firebase.google.com/) - Backend services
- [BLoC Pattern](https://bloclibrary.dev/) - State management

---

Made with ❤️ using Flutter
