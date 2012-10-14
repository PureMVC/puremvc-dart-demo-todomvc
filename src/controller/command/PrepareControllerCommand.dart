class PrepareControllerCommand extends mvc.SimpleCommand
{
  void execute( mvc.INotification note )
  {
    facade.registerCommand( AppConstants.ADD_TODO,               () => new TodoCommand() );
    facade.registerCommand( AppConstants.DELETE_TODO,            () => new TodoCommand() );
    facade.registerCommand( AppConstants.UPDATE_TODO,            () => new TodoCommand() );
    facade.registerCommand( AppConstants.TOGGLE_TODO_STATUS,     () => new TodoCommand() );
    facade.registerCommand( AppConstants.FILTER_TODOS,           () => new TodoCommand() );
    facade.registerCommand( AppConstants.REMOVE_TODOS_COMPLETED, () => new TodoCommand() );
  }
}