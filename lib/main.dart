
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/BlocObserver.dart';
import 'package:todoapp/shared/component/constans.dart';
import 'package:todoapp/shared/network/local/Cash_helper.dart';
import 'package:todoapp/shared/network/remote/dio_helper.dart';
import 'package:todoapp/shared/style/Thems.dart';
import 'package:todoapp/shared/todocubit/cubit.dart';
import 'package:todoapp/shared/todocubit/states.dart';

import 'layout/todoapp/todoapp.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
;
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await CashHelper.init();
  bool? isshared=   CashHelper.getbool(key: 'isDark');
  bool? onboarding=   CashHelper.getbool(key: 'onboarding');
  token=   CashHelper.getdata(key: 'token');
  UId=   CashHelper.getdata(key: 'UId');
  Widget ? widget;


  runApp(  myApp(isshared ));
  print(isshared);
}

class myApp extends StatelessWidget
{
  final bool ? isshared;
  myApp(this.isshared);


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)
            {
              return AppCubit()..changedarkmode(
                  fromshared: isshared
              );
            }
        ),

      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp( home:TodoApp(),
            theme: ligtthem,
            darkTheme: darkthem,
            themeMode: ThemeMode.light, // AppCubit.get(context).isdark ? ThemeMode.dark :
          );
        },

      ),
    );
  }

}