import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/component/componanets.dart';
import '../../../shared/todocubit/cubit.dart';
import '../../../shared/todocubit/states.dart';



class DoneTasks extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        var tasks=AppCubit.get(context).donetasks;
        return ListView.separated(
            itemBuilder:(context,index)
            {
              return buildTaskItem(tasks![index],context);
            },
            separatorBuilder: (context , index)
            {
              return Container(
                width: double.infinity,
                color: Colors.grey,
                height: 1,
              );
            },
            itemCount: tasks!.length
        );
      },


    );
  }
}
