abstract class ListOfUsersStates{}
class ListOfUsersInitialState extends ListOfUsersStates{}
class ListOfUsersLoadingState extends ListOfUsersStates{}
class ListOfUsersSuccessState extends ListOfUsersStates{
}
class ListOfUsersFailedState extends ListOfUsersStates{
  final String error;

  ListOfUsersFailedState(this.error);
}
class DeletedSuccessfullyState extends ListOfUsersStates{
}
class DeletedFailedState extends ListOfUsersStates{
  final String error;

  DeletedFailedState(this.error);
}