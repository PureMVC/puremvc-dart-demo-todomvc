class TodoCommand extends MVCSimpleCommand
{
  void execute( INotification note ) 
  {
    TodoProxy proxy = facade.retrieveProxy( TodoProxy.NAME );
    switch( note.getName() ) 
    {
      case AppConstants.ADD_TODO:
        String jsonNewTodo =  note.getBody();
        TodoVO newTodo = new TodoVO.fromString( jsonNewTodo );
        proxy.addTodo( newTodo );
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
  }
}
