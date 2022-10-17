import 'package:flutter/material.dart';

class UserModel
{
  final String ? name;
  final int ? id;
  final String  ? phone;
  UserModel({
    @required this.id,
    @required this.name,
    @required this.phone
  });

}