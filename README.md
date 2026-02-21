# 🎬 WatchTube

A clean and minimal YouTube player app built with Flutter.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

## ✨ Features

- 🎥 **YouTube Player** — Full playback with progress bar and fullscreen support
- 📋 **Playlist** — Browse and switch between videos with one tap
- 🔇 **Mute / Unmute** — Toggle audio instantly
- ⚡ **Playback Speed** — Choose from 0.25x to 2.0x
- 🔍 **Search** — Filter videos by title or channel name
- 🗂️ **Categories** — Filter by Music, Tech, Viral, and more
- 🖼️ **Auto Thumbnails** — Thumbnails load automatically from YouTube — no API needed
- 🔗 **Flexible Video IDs** — Paste a full YouTube URL or just the video ID

---

## 📸 Screenshots

![Watch Tube](assets/watch_tube.png)
---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>= 3.0.0`
- Android SDK with a physical device or emulator

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/taha2901/watch_tube.git
cd watch_it

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run --no-enable-impeller
```

> ⚠️ Use `--no-enable-impeller` to avoid rendering issues with WebView on some devices.

---

## 📦 Dependencies

```yaml
dependencies:
  youtube_player_flutter: ^9.1.1
```

---

## ➕ Adding Your Own Videos

Open `lib/models/vedio_items_model.dart` and add to the `kVideos` list.

You can use a **full YouTube URL** or just the **video ID**:

```dart
// ✅ Full URL
VideoItem(
  id: 'https://www.youtube.com/watch?v=qKS4ZfKENew',
  title: 'My Video Title',
  channel: 'Channel Name',
  duration: '10:30',
  category: 'Education',
),

// ✅ Video ID only
VideoItem(
  id: 'qKS4ZfKENew',
  title: 'My Video Title',
  channel: 'Channel Name',
  duration: '10:30',
  category: 'Tech',
),
```

**How to get a Video ID from YouTube:**
```
https://youtube.com/watch?v=dQw4w9WgXcQ
                             ^^^^^^^^^^^
                             This is the ID
```

---

## 🗂️ Project Structure

```
lib/
├── main.dart
├── models/
│   └── vedio_items_model.dart   # VideoItem model + kVideos list
├── home_screen.dart             # Home screen with categories & search
├── player_screen.dart           # YouTube player + playlist
├── vedio_list_title.dart        # Video list tile widget
├── search_sheet.dart            # Search bottom sheet
└── control_btn.dart             # Mute & speed control buttons
```

---

## ⚙️ Android Setup

In `android/app/src/main/AndroidManifest.xml`, make sure you have:

```xml
<application
    android:hardwareAccelerated="true"
    android:usesCleartextTraffic="true"
    ...>

    <!-- Disable Impeller to fix WebView rendering issues -->
    <meta-data
        android:name="io.flutter.embedding.android.EnableImpeller"
        android:value="false" />
```

---


<p align="center">Made with Taha Hamada using Flutter</p>


