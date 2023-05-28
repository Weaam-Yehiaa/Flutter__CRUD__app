import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rise_up_task/cubit/list_of_users_states.dart';
import 'package:rise_up_task/helper/api.dart';
import 'package:rise_up_task/models/user_model.dart';
import 'package:rise_up_task/shared/components.dart';

class ListOfUsersCubit extends Cubit<ListOfUsersStates>{
  ListOfUsersCubit():super(ListOfUsersInitialState());

  List<UserModel>usersList=[];

  static ListOfUsersCubit get(context)=> BlocProvider.of(context);

  Future<void>deleteUser(int id,context )async{

    int code=await Api().delete(id);
    String e="";
    if(code==204)
    {
      final newList=usersList.where((element) => element.id!=id).toList();

        usersList=newList;
        emit(DeletedSuccessfullyState());
      showSnakeBar(context, 'Successfully Deleted ');
    }
    else {
      if(code==404)
        {
          e="The requested resource does not exist.";
        }
      else if(code==415)
        {
          e=": Unsupported media type. The requested content type or version number is invalid.";
        }
      else if(code==500)
        {
          e="Internal server error.";
        }

      showSnakeBar(context, 'Something is error, status code is  ${e} ');
      emit(DeletedFailedState('this is a problem in status code ${code} -> Delete'));
      throw Exception(
          'this is a problem in status code ${code} -> Delete'
      );
    }

  }

  Future<List<UserModel>>getAllUsers() async {
    emit(ListOfUsersLoadingState());
    List<dynamic>data= await Api().get('gorest.co.in', '/public/v2/users');

    for(int i=0;i<data.length;++i)
    {
      usersList.add(
          UserModel.fromJson(data[i])
      );
      print(usersList[i].name);
    }
    emit(ListOfUsersSuccessState());
    return usersList;

  }

}