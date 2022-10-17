

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';


import 'package:path/path.dart';
import 'package:todoapp/shared/todocubit/states.dart';

import '../../modules/Todo_App/Tasks/currentTasks.dart';
import '../../modules/Todo_App/archievdTasks/archievdTasks.dart';
import '../../modules/Todo_App/doneTasks/doneTasks.dart';
import '../network/local/Cash_helper.dart';

class AppCubit extends Cubit<AppState>
{
  AppCubit(): super(IntialAppState());
  static AppCubit get(context)
  {
    return BlocProvider.of(context);
  }


  var index1 =0;
  List<Widget> screen= [
    CurrentTasks(),
    DoneTasks()  ,
    ArchievdTasks(),

  ];
  List<String>title =[
    "Tasks",
    "Done Tasks",
    "Archieved Tasks",
  ];
  void changeBottomNavBar(index)
  {
    index1=index;
    emit(ChangeBottomNavBarState());
  }



  Database ?db ;

  List<Map>?newtasks=[];
  List<Map>?donetasks=[];
  List<Map>?archievdtasks=[];
  Future<String>name() async
  {

    return "ahmed ali";
  }
  void createdatabase() async
  {
    String datapath= await getDatabasesPath();
    String path = join(datapath,"todo.db" );
    db =  await openDatabase(
        path,
        version: 1,
        onCreate: (  db , version)
        {
          print("database created");
          db.execute("CREATE TABLE Tasks (id INTEGER PRIMARY KEY ,title TEXT, date TEXT , time TEXT , status TEXT )").then((value) {
            print("table created");
          }).catchError((erorr)
          {
            print("erorr from create table ${erorr}");
          });
        },
        onOpen: (db){
          getdatabase(db);
            print("database opened");
            emit(AppCreateDtabaseState());



        }

    ) as Database?;
  }

   insertedatabase({
    @required String? title,
    @required String? date,
    @required String? time,
  }) async

  {
    await db?.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Tasks(title,date,time,status) VALUES("${title}","${date}", "${time}" , "NEW")');
      print('inserted1: $id1');
      emit(AppInsertDtabaseState());
      getdatabase(db);

    });


  }


  void getdatabase(db)
  {
    emit(AppGetDtabaseState());
    newtasks=[];
    donetasks=[];
    archievdtasks=[];
        db!.rawQuery('SELECT * FROM TASKS').then((value)  {
          value.forEach((element)
              {
                if(element['status']=='NEW')
                  newtasks?.add(element);
                else if(element['status']=='done')
                  donetasks?.add(element);
                else
                  archievdtasks?.add(element);
                emit(AppGetDtabaseState());
              });
          print(newtasks);
          print(donetasks);
          print(archievdtasks);

        });


  }



  bool floatingbutton = false;
  IconData fbicon = Icons.edit;
  void changeBottomIcon({
  @required bool ?isshow,
   @required  IconData ? icon
})
  {
    floatingbutton=isshow!;
    fbicon=icon!;
    emit(ChangeBottomIconBarState());
  }

  void updateDatabase({
  @required String? s,
  @required int ? i,
}){
     db!.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['${s}', i]).then((value){
       print('updated');
       getdatabase(db);
       emit(AppUpdateDtabaseState());
     });

  }
  void deleteDatabase({
  @required int ? id,
}) async
  {
     db!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
       getdatabase(db);
       emit(AppDeleteDtabaseState());
     });
  }
  bool isdark = false;
  void changedarkmode({bool ?fromshared})
  {
    if(fromshared!=null) {
      isdark = fromshared;
      emit(ChangeDarkness());
    }
    else
      {
    isdark=!isdark;
    CashHelper.putbool(key: 'isDark', value: isdark).then((value) {
      emit(ChangeDarkness());
    });

    }
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa${fromshared}');
  }
}