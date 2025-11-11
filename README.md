# Quivor - Modern Video Player

A feature-rich, modern video player built with Flutter, designed for an enhanced series watching experience.

## ✨ Features

### 🎬 Smart Auto-Play System
- **Early Transition Mode**: "Next Episode" button appears 15 seconds before episode ends
- **Auto Mode**: Automatically plays next episode when current one finishes
- **Manual Mode**: Traditional manual control
- User preferences cached for seamless experience

### 🌐 OpenSubtitles Integration
- One-click subtitle search and download
- Automatic subtitle matching via file hash
- Multiple language support
- Secure API token management
- Settings UI for easy configuration

### 🎨 Modern UI/UX
- Beautiful gradient backgrounds
- Modern card-based design
- Smooth animations and transitions
- Dark theme optimized
- Responsive layout (desktop & mobile)

### 📊 Playlist Management
- Auto-create playlists from folders
- Watch history tracking
- "Continue Watching" feature
- Progress tracking for each video
- Easy playlist navigation

### 🔧 Technical Features
- Cross-platform (Windows, macOS, Linux, Android, iOS)
- Comprehensive logging system
- Error handling with user-friendly messages
- Secure credential storage
- Environment-based configuration

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.4.1)
- Dart SDK
- OpenSubtitles API key (optional, for subtitle features)

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/quivor.git
cd quivor
```

2. Install dependencies
```bash
flutter pub get
```

3. Run build runner (for generated code)
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Create `.env` file (optional, for OpenSubtitles)
```bash
cp .env.example .env
# Edit .env and add your OpenSubtitles API key
```

5. Run the app
```bash
flutter run
```

## 🔑 OpenSubtitles Setup

1. Get your API key from [OpenSubtitles.com](https://www.opensubtitles.com/en/consumers)
2. Add it to `.env` file or configure through Settings UI
3. Login through the app or manually enter your authentication token

## 🏗️ Architecture

- **State Management**: BLoC pattern with Freezed
- **Database**: Drift (SQLite)
- **Dependency Injection**: GetIt
- **Code Generation**: Freezed, Drift, Build Runner
- **Video Player**: media_kit
- **Secure Storage**: flutter_secure_storage

## 📦 Key Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.0
  freezed_annotation: ^2.4.1
  drift: 2.14.1
  media_kit: ^1.1.11
  flutter_secure_storage: ^9.2.2
  flutter_dotenv: ^5.1.0
  get_it: ^8.0.0
  
dev_dependencies:
  freezed: ^2.4.5
  build_runner: ^2.4.11
  drift_dev: 2.14.1
```

## 🎯 Roadmap

- [ ] Android & iOS support
- [ ] Subtitle synchronization controls
- [ ] Multiple audio track support
- [ ] Chromecast support
- [ ] Cloud sync for watch history
- [ ] Keyboard shortcuts customization

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [OpenSubtitles](https://www.opensubtitles.com/) for subtitle API
- [media_kit](https://pub.dev/packages/media_kit) for video playback
- Flutter community for amazing packages

## 📧 Contact

For questions or feedback, please open an issue on GitHub.

---

Made with ❤️ using Flutter
