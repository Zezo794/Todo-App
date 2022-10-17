import 'dart:ffi';


import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../shared/component/componanets.dart';
import '../../shared/component/constans.dart';
import '../../shared/todocubit/cubit.dart';
import '../../shared/todocubit/states.dart';

class TodoApp extends StatelessWidget {



  Database ?db ;



  var titleeditcontroler = TextEditingController();
  var timeeditcontroler = TextEditingController();
  var dateeditcontroler = TextEditingController();
  var sckafoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) {
        return AppCubit()..createdatabase();
      },
      child: BlocConsumer<AppCubit,AppState>(
        listener: (BuildContext context, Object? state) {
          if(state is AppInsertDtabaseState )
            Navigator.pop(context);
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            key: sckafoldkey,
            appBar: AppBar(
                title: Text(AppCubit.get(context).title[AppCubit.get(context).index1])
            ),
            floatingActionButton: FloatingActionButton(

              onPressed: ()  {
                if(AppCubit.get(context).floatingbutton) {
                  if(formkey.currentState!.validate())
                  {
                    AppCubit.get(context).insertedatabase(
                      title:titleeditcontroler.text ,
                      date: dateeditcontroler.text,
                      time: timeeditcontroler.text,
                    ).then((value) {

                      AppCubit.get(context).changeBottomIcon(isshow: false, icon: Icons.edit);

                    });

                  };

                }
                else{
                  AppCubit.get(context).changeBottomIcon(isshow: true, icon: Icons.add);
                  sckafoldkey.currentState?.showBottomSheet((context) {
                    return Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextForm(
                                textEditingController: titleeditcontroler,
                                type: TextInputType.text,
                                onsubmit: (value){},
                                text: "title",
                                prefix: Icons.title_outlined,
                                validate: (String? value){
                                  if(value!.isEmpty)
                                    return "the title shouldnt be empty";
                                  else
                                    return null;
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultTextForm(
                                textEditingController: timeeditcontroler,
                                type: TextInputType.datetime,
                                onsubmit: (value){},
                                ontap: (){
                                  showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                    timeeditcontroler.text=value!.format(context).toString();
                                    print(value.format(context).toString());
                                  });
                                },
                                text: "time",
                                prefix: Icons.watch_later_outlined,
                                validate: (String? value){
                                  if(value!.isEmpty)
                                    return "the time shouldnt be empty";
                                  else
                                    return null;
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultTextForm(
                                textEditingController: dateeditcontroler,
                                type: TextInputType.datetime,
                                onsubmit: (value){},
                                text: "Task date",
                                ontap: (){
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse("2022-12-20"),
                                  ).then((value) {
                                    print(DateFormat.yMMMd().format(value!));
                                    dateeditcontroler.text=DateFormat.yMMMd().format(value).toString();
                                  });
                                },
                                prefix: Icons.calendar_today_outlined,
                                validate: (String? value){
                                  if(value!.isEmpty)
                                    return "the title shouldnt be empty";
                                  else
                                    return null;
                                }
                            ),

                          ],
                        ),
                      ),
                    );


                  }).closed.then((value) {
                    AppCubit.get(context).changeBottomIcon(isshow: false, icon: Icons.edit);
                  });
                }


              },
              child: Icon(AppCubit.get(context).fbicon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed ,
              currentIndex:AppCubit.get(context).index1 ,
              onTap: (index)
              {
                AppCubit.get(context).changeBottomNavBar(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu) , label: "Tasks"),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline),label: "Done"),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined) ,label: "archeived"),
              ],
            ),
            body: AppCubit.get(context).screen[AppCubit.get(context).index1],


          );
        },

      ),
    );



  }

}





