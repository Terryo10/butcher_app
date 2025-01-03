# Vintage Meats - Flutter App

## Overview

**Vintage Meats** is a mobile app designed to sell premium cuts of meat to customers. The app provides a seamless shopping experience where users can browse through various meat categories, place orders, and have them delivered right to their doorstep. It is built using **Flutter** for the mobile frontend and powered by **Laravel** on the backend.

## Features

- **Browse Meats**: Users can explore different categories of meat (e.g., Beef, Chicken, Pork, Lamb) with detailed descriptions and images.
- **Shopping Cart**: Users can add their selected items to the cart and proceed to checkout.
- **Secure Payment**: Integration with payment gateways for safe and secure transactions.
- **User Profile**: Users can create accounts, manage profiles, view past orders, and save delivery addresses.
- **Order Tracking**: Users can track the status of their orders in real time.
- **Notifications**: Receive push notifications for order updates, promotions, and new arrivals.
- **Admin Dashboard**: Admins can manage products, view orders, and update inventory through the Laravel backend.

## Tech Stack

- **Frontend**:  
  - Flutter (Dart)
  - Firebase (for push notifications)
  - Provider (for state management)

- **Backend**:  
  - Laravel (PHP)
  - MySQL (Database)
  - Laravel Sanctum (Authentication)
  - Laravel Passport (for OAuth and API security)

- **Payment Gateway**:  
  - Stripe or PayPal (for secure payments)

- **Hosting**:  
  - Backend hosted on shared or dedicated server (e.g., DigitalOcean, AWS, or any other provider)
  - Firebase for cloud-based push notifications

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- [Xcode](https://developer.apple.com/xcode/) (for iOS development) or Android Studio installed.
- [Composer](https://getcomposer.org/) (for Laravel backend dependencies).
- [PHP](https://www.php.net/) installed on your machine (minimum version 7.4).
- [MySQL](https://www.mysql.com/) installed for local development.

### Backend Setup

1. Clone the Laravel repository:
   ```bash
   git clone https://github.com/yourusername/vintage-meats-backend.git
   cd vintage-meats-backend
   ```

2. Install PHP dependencies:
   ```bash
   composer install
   ```

3. Set up your environment variables:
   - Copy `.env.example` to `.env`:
     ```bash
     cp .env.example .env
     ```

4. Set up the database:
   - Create a MySQL database and update the `.env` file with the correct database credentials.

5. Generate application key:
   ```bash
   php artisan key:generate
   ```

6. Run database migrations:
   ```bash
   php artisan migrate
   ```

7. Start the Laravel development server:
   ```bash
   php artisan serve
   ```

### Mobile App Setup

1. Clone the Flutter repository:
   ```bash
   git clone https://github.com/yourusername/vintage-meats-flutter.git
   cd vintage-meats-flutter
   ```

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Set up Firebase:
   - Go to the Firebase Console, create a project, and enable push notifications.
   - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place it in the respective project directories.

4. Update the API URL in the Flutter app:
   - Open `lib/constants.dart` and set the base API URL to your backend server:
     ```dart
     const String apiUrl = "http://your-backend-api-url";
     ```

5. Run the Flutter app:
   ```bash
   flutter run
   ```

### Production Deployment

For production, follow these steps:

- Ensure your backend server is properly configured and secured with HTTPS.
- Build the Flutter app for release:
  ```bash
  flutter build apk --release  # For Android
  flutter build ios --release  # For iOS
  ```
- Deploy your backend on a cloud provider like AWS, DigitalOcean, or Heroku.
- Upload the app to the respective app stores (Google Play Store, Apple App Store).

## Folder Structure

### Flutter App
```
vintage-meats-flutter/
├── android/               # Android-specific code
├── ios/                   # iOS-specific code
├── lib/                   # Dart code
│   ├── models/            # Data models
│   ├── providers/         # State management (Provider)
│   ├── screens/           # UI screens
│   ├── services/          # API and data services
│   ├── constants.dart     # Configuration and constants
├── pubspec.yaml           # Flutter project dependencies
```

### Laravel Backend
```
vintage-meats-backend/
├── app/                   # Application logic
│   ├── Models/            # Eloquent models
│   ├── Http/              # Controllers and middleware
├── database/              # Migrations and seeders
├── routes/                # API routes
├── .env                   # Environment settings
├── composer.json          # Backend dependencies
```

## Contributing

We welcome contributions! If you find a bug or want to add a feature, please fork the repository and create a pull request.

### Steps to contribute:
1. Fork the repository.
2. Create a new branch for your feature or fix:
   ```bash
   git checkout -b feature/new-feature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Added a new feature"
   ```
4. Push to your forked repository:
   ```bash
   git push origin feature/new-feature
   ```
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Vintage Meats** – Premium Meats, Delivered with Care.
