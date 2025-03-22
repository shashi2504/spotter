# Spotter 🚗⚡  
**An EV Charging Station Finder App**  

Spotter is a mobile application built using Flutter that allows electric vehicle (EV) users to find, navigate to, and interact with nearby charging stations. With real-time location tracking, payment integration, and seamless user experience, Spotter makes EV charging more accessible and convenient.  

---

## 📌 Overview  
With the rise of electric vehicles, finding an available charging station can sometimes be a challenge. **Spotter** aims to solve this problem by providing an intuitive and efficient way for EV owners to locate and navigate to charging stations.  

### 🔥 Key Highlights:  
- 🚀 **Real-time** tracking of charging stations  
- 🗺 **Google Maps Integration** for navigation  
- 🔧 **Blynk Cloud** for storing and retrieving hardware details  
- 💰 **Razorpay Integration** for seamless payments  
- 🔥 **Firebase** for user authentication and data storage  

---

## 🛠 Tech Stack  

| Technology | Purpose |
|------------|---------|
| **Flutter** | Used to build the cross-platform mobile application |
| **Dart** | The primary programming language used for development |
| **Firebase** | Backend services for authentication and data storage |
| **Blynk Cloud** | Manages and stores hardware-related details |
| **Google Maps API** | Provides map-based navigation features |
| **Razorpay** | Enables secure payment transactions |

---

## 🎯 Features  

### 🔍 Locate Nearby Charging Stations  
Spotter allows users to easily find EV charging stations based on their current location. The app fetches real-time data from **Firebase** and **Blynk Cloud**, displaying available stations on an interactive map.  

### 🗺 Interactive Google Maps Integration  
With **Google Maps API**, users can view charging stations, get directions, and estimate the distance and time required to reach them.  

### 🔋 View Charging Station Details  
Each charging station entry includes important details such as:  
- 📍 Location  
- ⏳ Availability  
- ⚡ Charging Capacity  
- 🛠 Station Type (Fast Charging / Normal Charging)  

### 💰 Secure Payments with Razorpay  
To ensure a smooth charging experience, users can pay for their sessions securely via **Razorpay**, providing a hassle-free way to access charging stations.  

### 🔐 User Authentication with Firebase  
Users can log in and manage their profiles securely with **Firebase Authentication**. This allows for:  
- 📌 Saving favorite charging stations  
- 📊 Tracking previous charging history  

---

## 📸 Screenshots  

_(Add some images of the app's UI here, like the home screen, map view, and payment screen.)_  

---

## 🚀 Getting Started  

Follow these steps to set up and run the **Spotter** app on your local machine.  

### ✅ Prerequisites  
- Install **Flutter**: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)  
- Install **Dart SDK** (included with Flutter)  
- Set up an **Android Emulator** or use a **physical device**  
- Configure your **Google Maps API key**  

### 🛠 Installation Steps  

1️⃣ **Clone the repository:**  
```sh
git clone https://github.com/your-username/spotter.git
```
2️⃣ **Navigate to the project directory:**
```sh
cd spotter
```
3️⃣ **Install dependencies:**
```sh
flutter pub get
```
4️⃣ **Run the app:**
```sh
flutter run
```

### 🔗 API Integrations

📍 Google Maps API
To use Google Maps API, generate an API key from Google Cloud Console and add it to your project.

🔧 Blynk Cloud
The app connects to Blynk Cloud to retrieve real-time charging station data from IoT devices.

🔥 Firebase
- Authentication: Enables secure login and user management
- Firestore: Stores charging station details and user history

💰 Razorpay
For payment processing, Razorpay API is used to securely handle transactions.
