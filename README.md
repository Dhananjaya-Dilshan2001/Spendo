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

---

## ⚙️ Installation & Usage  

1. **Register** with an email and password (demo email).  
2. **Log in** using the same credentials.  
3. Enter your **name**.  
4. On the first view, you will see blank pages with no data.  
5. Go to the **Plan tab** and add values for:  
   - Monthly budget (current balance you have)  
   - Expected income  
   - Expected outcome  
6. Add **categories** before adding transactions.  
7. Add transactions using the **“+” button** on the dashboard.  
8. Delete a transaction by **long pressing** on a transaction card.  
9. View **today’s transactions** on the dashboard.  
10. To view past transactions, go to the **History tab** and filter by date.  
    - Sorting by type and categories is **not implemented yet**.  
11. Use the **Plan tab** to input the user’s expected monthly parameters.  
12. In the **Overview tab**, compare your **expected vs. actual spending behavior** across categories.  
13. Currently, the app only manages **one month at a time**. Viewing and managing multiple months is **not implemented yet**.  
 
---