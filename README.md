# spendo

This is the Application That can basically manage and track the user monthly spending behavior, It give the good overview idea about the 
user monthly spending behavior using graphs and user friendly interface. 


## 🚀 Features  

- **User Authentication**  
  - Login & Registration system using **Firebase Authentication**.  

- **Dashboard**  
  - Overview of total income, expenses, and remaining budget.  

- **Add Transactions**  
  - Add income/expense transactions with amount, category, date, and description.  
- **Transaction History**  
  - View all transactions with filters by **date** and **category**.  
  - Display using **ListView** for better user experience.  

- **Budget Planning**  
  - Set **monthly budget goals**.  
  - Track progress with **progress indicators/graphs**.  

- **Reports & Insights**  
  - Visual analytics of monthly spending by category.  
  - Integrated **charts & graphs** using Flutter packages.  


## 🛠️ Tech Stack  

- **Framework:** Flutter (Dart)  
- **State Management:** Provider / Riverpod  
- **Database:** Firebase Firestore  
- **Authentication:** Firebase Auth  
- **UI:** Responsive, accessible, and optimized for Android & iOS  
- **Charts & Graphs:** Flutter charting packages


## 📂 Project Structure  
lib/
 ├── main.dart               # Entry point
 ├── firebase_options.dart  # firebase initiale Ids etc
 ├── core/                  # Bakend part
 |       --bloc             # BloC to manage user state and event
 |       --model            # Data models (User, Transaction)
 |       --repository       # layer for communicate with app and firebase
 ├── screen/                # frontedn part
 |       --common_component
 |       --..

## 🎯 Learning Outcomes  

- Deepened knowledge of **Flutter & Dart**.  
- Hands-on experience with **Firebase Authentication & Firestore**.  
- Implemented **responsive UI** for mobile platforms.  
- Practical understanding of **state management using BloC & Provider**.
 