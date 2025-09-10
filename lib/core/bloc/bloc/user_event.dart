part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

// ignore: must_be_immutable
class LoadUsers extends UserEvent {
  String userId;
  LoadUsers({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// ignore: must_be_immutable
class AddUser extends UserEvent {
  String userId;
  String email;
  String name;
  AddUser({required this.userId, required this.email, required this.name});

  @override
  List<Object?> get props => [userId, email, name];
}

// ignore: must_be_immutable
class DeleteUser extends UserEvent {
  String userId;
  DeleteUser({required this.userId});

  @override
  List<Object?> get props => [userId];
}
