import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, this.email, this.name, this.avatarUrl});
  final String id;
  final String? email;
  final String? name;
  final String? avatarUrl;

  static const unauthUser = User(id: '');

  bool get isUnauth => this == User.unauthUser;
  bool get isAuth => this != User.unauthUser;

  @override
  List<Object?> get props => [id, email, name, avatarUrl];
}
