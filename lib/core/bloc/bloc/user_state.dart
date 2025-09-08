part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
final class UserLoaded extends UserState {
  final AppUser user;
  UserLoaded({required this.user});
  @override
  List<Object?> get props => [user];

  FirebaseRepository firebase = FirebaseRepository();

  List<UserTransaction> filterTransactionsByDate(Timestamp selectedDate) {
    final selected = selectedDate.toDate();
    return user.transactions!.where((transaction) {
      final txDate = transaction.date.toDate();
      return txDate.year == selected.year &&
          txDate.month == selected.month &&
          txDate.day == selected.day;
    }).toList();
  }

  double totalIncomeByDay(Timestamp selectedDate) {
    double total = 0;
    List<UserTransaction> dailyTransactions = filterTransactionsByDate(
      selectedDate,
    );
    for (var transaction in dailyTransactions) {
      if (!transaction.isExpense) {
        total += transaction.amount;
      }
    }
    return total;
  }

  double totalExpenseByDay(Timestamp selectedDate) {
    double total = 0;
    List<UserTransaction> dailyTransactions = filterTransactionsByDate(
      selectedDate,
    );
    for (var transaction in dailyTransactions) {
      if (transaction.isExpense) {
        total += transaction.amount;
      }
    }
    return total;
  }

  void deleteTransaction(BuildContext context, String transactionId) {
    firebase.deleteTransaction(context, user, transactionId);
  }

  void addTransaction(BuildContext context, UserTransaction transaction) {
    firebase.addTransaction(context, user, transaction);
  }

  void changeUserData(BuildContext context, String variableName, var value) {
    firebase.changeUserData(context, variableName, value, user);
  }

  void deleteCategory(BuildContext context, String category) {
    firebase.deleteACategorie(context, category, user);
  }

  void addCategory(BuildContext context, String category) {
    firebase.addACategorie(context, category, user);
  }
}

final class UserError extends UserState {
  final String message;
  UserError({required this.message});
  @override
  List<Object?> get props => [message];
}

final class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserAdded extends UserState {
  final String message;
  UserAdded({required this.message});
  @override
  List<Object?> get props => [message];
}

final class UserUpdated extends UserState {
  final String message;
  UserUpdated({required this.message});
  @override
  List<Object?> get props => [message];
}

final class UserDeleted extends UserState {
  final String message;
  UserDeleted({required this.message});
  @override
  List<Object?> get props => [message];
}

final class TransactionFiltered extends UserState {
  final AppUser user;
  final List<UserTransaction> filteredTransactions;
  TransactionFiltered({required this.user, required this.filteredTransactions});
  @override
  List<Object?> get props => [];
}
