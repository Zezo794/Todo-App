import 'package:flutter/material.dart';

import '../../models/usermodel/usermodel.dart';


class User extends StatelessWidget {
  List<UserModel> user=[
    UserModel(id: 1, name: "zezo hossam ", phone: "+20 01153338016"),
    UserModel(id: 2, name: "ahmed hossam ", phone: "+20 01435338647"),
    UserModel(id: 3, name: "mohamed hossam ", phone: "+20 01158478444"),
    UserModel(id: 1, name: "zezo hossam ", phone: "+20 01153338016"),
    UserModel(id: 2, name: "ahmed hossam ", phone: "+20 01435338647"),
    UserModel(id: 3, name: "mohamed hossam ", phone: "+20 01158478444"),
  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User" , style:
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ,),
      ),
      body: ListView.separated(
          itemBuilder: (context, index)
          {
            return design(user[index]);
          },
          separatorBuilder: (context, index)
          {
            return Container(
              color: Colors.grey,
              width: double.infinity,
              height: 1,
            );
          },
          itemCount: user.length
      ),

    );

  }
  Widget design(UserModel m)
  {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(

        children: [
          CircleAvatar(
            backgroundColor: Colors.cyan,
            radius: 25,
            child: Text('${m.id}', style:
            TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),

          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${m.name}" , style:
              TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
              SizedBox(
                height: 5,
              ),
              Text("${m.phone}" , style:
              TextStyle(fontSize: 20,),),
            ],
          ),
        ],
      ),
    );
  }
}
