# SoccerFixtureApp

This project is a football-related iOS application that displays fixtures and competitions using the **MVVM** architecture and the **Combine** framework. It provides an intuitive UI with multiple tabs and segmented navigation.

## Features

### **Main Tabs**
- **Fixtures Tab**: Displays today's football fixtures.
- **Competitions Tab**: Lists all available competitions.

### **Competition Details**
When a competition is selected, the app navigates to a new view with a **segmented UI** that allows switching between:
1. **Table**: Displays the current standings of the competition.
2. **Fixtures**: Shows upcoming and past matches in the competition.
3. **Teams**: Lists all participating teams along with their crests.

## **Architecture & Technologies**
- **MVVM (Model-View-ViewModel)**: Ensures a clean separation of concerns.
- **Combine Framework**: Handles asynchronous data flow and binding.
- **Kingfisher**: Efficient image loading and caching.
- **Realm Database**: Provides local storage for offline access.

## **Installation**
1. Clone the repository:
   ```sh
   git clone https://github.com/Korede612/SoccerFixtureApp.git
   cd SoccerFixtureApp
   ```
2. Install dependencies using Swift Package Manager.
3. Open the file in Xcode.
4. Run the project on a simulator or device.

## **License**
This project is for demonstration purposes only.

---

Let me know if you need any modifications! 🚀
