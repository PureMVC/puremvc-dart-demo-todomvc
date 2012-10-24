class TodoCommand extends mvc.SimpleCommand
{
  void execute( mvc.INotification note )
  {
    TodoProxy proxy = facade.retrieveProxy( TodoProxy.NAME );

    switch( note.getName() )
    {
      case AppConstants.ADD_TODO:
        proxy.addTodo( new TodoVO.fromString( note.getBody() ) );
        break;

      case AppConstants.DELETE_TODO:
        proxy.deleteTodo( note.getBody() as String );
        break;

      case AppConstants.UPDATE_TODO:
        proxy.updateTodo( note.getBody() as TodoVO );
        break;

      case AppConstants.TOGGLE_TODO_STATUS:
        proxy.toggleCompleteStatus( note.getBody() as bool );
        break;

      case AppConstants.REMOVE_TODOS_COMPLETED:
        proxy.removeTodosCompleted();
        break;

      case AppConstants.FILTER_TODOS:
        proxy.filterTodos( note.getBody() as String );
        break;

    }
  }
}
