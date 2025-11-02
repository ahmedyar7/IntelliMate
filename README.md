<p align="center">
  <img src="./assets/screenshots/IntelliMate.png" alt="IntelliMate Logo"  />
</p>

A smart and interactive _AI chatbot app_ built using **Flutter**, powered by the **Google Gemini API**. Designed for Computer Science students and enthusiasts, this app lets you ask questions and get intelligent responses from an AI model in real-time.

<div align="center">
<img alt="Dart" src="https://img.shields.io/badge/language-Dart-0175C2?style=flat&logo=dart&logoColor=white" />
<img alt="GPLv3" src="https://img.shields.io/badge/license-GPLv3-4F772D?style=flat&logo=gnu&logoColor=white" />
<img alt="GPLv2" src="https://img.shields.io/badge/license-GPLv2-4F772D?style=flat&logo=gnu&logoColor=white" />
<img alt="Gemini" src="https://img.shields.io/badge/protocol-Gemini-7A6EE6?style=flat&logo=gemini&logoColor=white" />
</div>


This project was inspiried by the below Figma UI Kit
**[Figma-Design](https://www.figma.com/design/oyB9cM60RpiRMn3RfkLxH0/AI-Assistant-Mobile--Community-?node-id=208-3931&p=f&t=bUFGjh5vquhLwgNe-0)**

---

## 📝 Description

**IntelliMate** is a modern Flutter-based chat application that integrates with Google's Gemini AI to provide users with instant, conversational responses. The app features:

- ✅ Real-time typing effect using `AnimatedTextKit
- ✅ Dark blueish UI theme
- ✅ Predefined question suggestions based on user category (e.g., Computer Science)

This project is ideal for developers looking to integrate AI models like Gemini into their apps or build educational tools powered by LLMs.

---

## 📸 UI Preview

To help users and contributors understand how **IntelliMate** looks and feels, you can add screenshots of the app in action.

<p align="center">
  <img src="./assets/screenshots/design.png" alt="IntelliMate Logo"  />
</p>

---

## Video Demostration
https://github.com/user-attachments/assets/bc28d93a-84df-4bf7-81d9-c49e6e2c5a03

---

## 🧰 Technologies Used

| Tool           | Purpose                                  |
| -------------- | ---------------------------------------- |
| Flutter        | Cross-platform UI framework              |
| Dart           | Programming language                     |
| Provider       | State management                         |
| flutter_dotenv | Securely load API keys                   |
| http           | Optional future support for backend APIs |

---

## 🧪 Features

### 💬 Chat Interface

- Ask any question to Gemini AI
- Get live streaming response (like ChatGPT)
- Send message via keyboard or tap

### 🤖 Gemini AI Integration

- Powered by `gemini-1.5-flash` and `gemini-1.5-pro` models
- Supports text and image input (vision mode)

**Available models**:

- `gemini-1.5-flash`
- `gemini-1.5-pro`
- `gemini-pro` _(older)_

### 📚 Quick Questions

- Preloaded set of CS-related prompts grouped by topic:
  - Most Popular
  - Trending
  - Interview Prep
- Tap to send directly to Gemini

### 🎨 UI/UX

- Dark purple-themed UI
- Consistent styling across screens
- Typing animation for assistant replies
- Copy-to-clipboard feature

---

## 📁 Folder Structure

```
lib/
├── main.dart
├── data/remote/
│   ├── api_helper.dart
│   └── urls.dart
|
├── model/
│   ├── gemini_response_model.dart
│   └── message_model.dart
|
├── provider/
│   └── msg_provider.dart
|
├── screen/
│   ├── chat_screen.dart
│   ├── dashboard_screen.dart
│   ├── signup_screen.dart
│   └── splash_screen.dart
|
└── utils/
    ├── app_constant.dart
    └── colors.dart

```

---

## 🛠️ Setup Instructions

### 1. Clone the Project

```bash
git https://github.com/ahmedyar7/IntelliMate.git
cd IntelliMate
```

### 2. Install Dependencies

```bash
flutter pub get
```

> **📌 NOTE:**  
> Make sure you're using the Flutter stable channel:
>
> ```bash
> flutter channel stable
> flutter upgrade
> ```

### 3. Set Up Your Gemini API Key

Create a `.env` file at the root of your project:

```
GEMINI_API_KEY=your_api_key_here
```

Then run:

```bash
flutter pub add flutter_dotenv
flutter pub run dotenv:main
```

Make sure to call `await dotenv.load(fileName: ".env")` in `main.dart`.

### 4. Run the App

```bash
flutter run
```

---

## 🤝 Contributions

We welcome contributions from the community! Whether you're fixing a bug, improving documentation, or adding new features, your help is greatly appreciated.

### ✅ How to Contribute

1. **Fork** the repository
2. **Create a new branch**: `git checkout -b feature/your-feature-name`
3. **Make your changes**
4. **Commit and push** your changes
5. **Open a Pull Request** with a clear description of what you did

# LICENSE

[General-Public-License](./LICENSE)
