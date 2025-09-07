import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:spendo/core/model/user.dart';
import 'package:spendo/core/repository/firebase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseRepository firebaseRepository;
  UserBloc(this.firebaseRepository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUsers) {
        emit(UserLoading());
        //print("Loading user with ID: ${event.userId}");
        await firebaseRepository
            .getUserByID(event.userId)
            .then((value) {
              if (value != null) {
                print("User loaded: ${value.name}");
                emit(UserLoaded(user: value));
              } else {
                emit(UserError(message: 'User not found'));
              }
            })
            .catchError((error) {
              emit(UserError(message: error.toString()));
            });
        //print("Loaded user: ${user?.name}");
      } else if (event is AddUser) {
        emit(UserLoading());
        AppUser newUser = AppUser(
          id: event.userId,
          name: event.name,
          email: event.email,
          monthlyBudget: 0,
          monthlyExpectedIncome: 0,
          monthlyExpectedOutcome: 0,
          categories: [],
          transactions: [],
          isEnable: true,
        );
        firebaseRepository
            .addUser(newUser)
            .then((_) {
              emit(UserAdded(message: 'User added successfully'));
            })
            .catchError((error) {
              emit(UserError(message: error.toString()));
            });
      } else if (event is DeleteUser) {
        emit(UserLoading());
        firebaseRepository
            .deleteUser(event.userId)
            .then((_) {
              emit(UserDeleted(message: 'User deleted successfully'));
            })
            .catchError((error) {
              emit(UserError(message: error.toString()));
            });
      }
    });
  }
}
