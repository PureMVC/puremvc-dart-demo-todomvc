class TodoCommand extends MVCSimpleCommand
{
  void execute( INotification note ) 
  {
    var proxy = facade.retrieveProxy( TodoProxy.NAME );
    /*
    switch( note.getName() ) 
    {
      case AppConstants.ADD_TODO:
        proxy.addTodo( note.getBody() );
        break;
        
      case AppConstants.DELETE_TODO:
        proxy.deleteTodo( note.getBody() );
        break;
        
      case AppConstants.UPDATE_TODO:
        proxy.updateTodo( note.getBody() );
        break;
        
      case AppConstants.TOGGLE_TODO_STATUS:
        proxy.toggleCompleteStatus( note.getBody() );
        break;
        
      case AppConstants.REMOVE_TODOS_COMPLETED:
        proxy.removeTodosCompleted();
        break;
        
      case AppConstants.FILTER_TODOS:
        proxy.filterTodos( note.getBody() );
        break;
        
    }
    */
  }
}
