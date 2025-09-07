part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserLoaded extends UserState {
  final AppUser user;
  UserLoaded({required this.user});
  @override
  List<Object?> get props => [user];
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
