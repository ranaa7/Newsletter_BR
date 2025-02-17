# 📩 Newsletter Application

## 📌 Project Overview
This is a Flutter-based Newsletter Application that allows users to:
1. **Sign up** with proper validation.
2. **Choose their interests** (e.g., Sports, Technology, Health, etc.).
3. **Receive a confirmation email** with a deep link.
4. **Be redirected** to a personalized newsletter screen based on their choices.

## 🎯 Features & Requirements
### 1️⃣ User Registration
- Users sign up using:
    - **Name** (Required)
    - **Email** (Valid format, Required)
    - **Password** (Min 6 characters, Required)
- Input validation is implemented.
- Firebase Authentication is used for user credential storage.

### 2️⃣ Interest Selection
- Users can select one or more newsletter categories.
- The selected interests are stored for later retrieval.

### 3️⃣ Email Confirmation & Deep Linking
- After sign-up, the user receives a **confirmation email** with a deep link.
- **Firebase Dynamic Links** is used to generate and handle deep links.
- The deep link redirects users to the newsletter screen.

### 4️⃣ Newsletter Screen
- Displays personalized content based on user-selected interests.

## ✅ Acceptance Criteria
✔ **Sign-up Page:** Users can register with valid credentials.
✔ **Input Validation:** Error messages appear for invalid inputs.
✔ **Interest Selection:** Users can choose at least one category.
✔ **Confirmation Email:** Email is sent with a deep link after successful registration.
✔ **Deep Linking:** Clicking the link redirects the user to the correct screen.
✔ **Newsletter Screen:** Displays relevant content based on the user's choices.
✔ **State Management:** Implemented using Provider, Riverpod, or Bloc.
✔ **Error Handling:** Proper handling of API failures, network issues, and authentication errors.

## 🛠 Tech Stack
- **Flutter** (Latest Stable Version)
- **Firebase Authentication** (for user sign-up)
- **Firebase Dynamic Links, go_router, or App Links** (for deep linking)
- **State Management:** Provider, Riverpod, or Bloc
- **Shared Preferences** (for local storage of user interests)

## 🚀 Getting Started
### Prerequisites
- Install Flutter: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Install Firebase CLI:
  ```sh
  npm install -g firebase-tools
  ```
- Enable Firebase Authentication & Dynamic Links on Firebase Console.

### 🔧 Setup Instructions
1. **Clone the Repository:**
   ```sh
   git clone https://github.com/your-username/newsletter-app.git
   cd newsletter-app
   ```

2. **Install Dependencies:**
   ```sh
   flutter pub get
   ```

3. **Configure Firebase:**
   ```sh
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

4. **Run the Application:**
   ```sh
   flutter run
   ```

## 🤝 Contributing
Feel free to fork the repository, create a feature branch, and submit a pull request!

## 📜 License
This project is licensed under the MIT License.

---
📩 Happy Coding!

