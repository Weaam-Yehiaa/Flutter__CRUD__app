import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rise_up_task/cubit/list_of_users_cubit.dart';
import 'package:rise_up_task/cubit/list_of_users_states.dart';
import 'package:rise_up_task/helper/api.dart';
import 'package:rise_up_task/models/user_model.dart';
import 'package:rise_up_task/screens/add_user_screen.dart';
import 'package:rise_up_task/screens/display_screen.dart';
import 'package:rise_up_task/shared/components.dart';
import 'package:rise_up_task/shared/constants.dart';

class ListOfUsers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context){
          final cubit =ListOfUsersCubit();
          cubit.getAllUsers();
          return cubit;
        },
        child: BlocConsumer<ListOfUsersCubit,ListOfUsersStates>(
          builder:(context,state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: baseColor,
                title: Text(
                  'List of Users',
                ),
                actions: [
                  IconButton(
                    onPressed: (){
                      navigateTo(context, AddUserScreen());
                      ListOfUsersCubit.get(context).getAllUsers();
                    },
                    icon: Icon(
                        Icons.add
                    ),
                  ),
                ],
              ),
              body: ConditionalBuilder(
                condition: state is! ListOfUsersLoadingState,
                fallback:(context)=> Center(child: CircularProgressIndicator(color: baseColor,)),

                builder:(context)=>  ListView.separated(
                  itemBuilder: (context,item){
                    return buildUserItem(ListOfUsersCubit.get(context).usersList[item],item,context);
                  },
                  separatorBuilder: (context,item) =>Divider(),
                  itemCount: ListOfUsersCubit.get(context).usersList.length,
                ),
              ),
            );
          },
          listener: (context,state){},
        ),
    );
  }

  Widget buildUserItem(UserModel user,int i,BuildContext context)=>GestureDetector(
    onTap:()=>navigateTo(context, DisplayScreen(user: user,)),

    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.0,
              backgroundColor: baseColor,
              child: Text(
                '${i}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
          ),
          SizedBox(width: 10.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${user.name}'),
              Text('${user.email}'),
              Text('${user.gender}'),
              Text('${user.status}'),
            ],
          ),
          Spacer(),
          MaterialButton(
            color: baseColor,
            onPressed: (){
              navigateTo(context, AddUserScreen(userEdit: user,));
            },
            child: Text(
              'Update',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          SizedBox(width: 8.0,),
          MaterialButton(
           color: baseColor,
            onPressed: () {
              ListOfUsersCubit.get(context).deleteUser(user.id, context);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
