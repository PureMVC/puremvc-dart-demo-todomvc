class TodoFormMediator extends MVCMediator
{
  // Name Mediator will be registered as 
  static const String NAME = "TodoFormMediator";
  
  // Constructor
  TodoFormMediator( TodoForm viewComponent ):super( NAME, viewComponent ){}  

  // Accessors to cast viewComponent to the correct type for this Mediator
  TodoForm get todoForm() { return viewComponent; }
  void set todoForm( TodoForm component ) { viewComponent = component; }
  
  // Called when Mediator is registered
  void onRegister()
  {
    // set listeners on text component
    todoForm.addEventListener( AppEvents.TOGGLE_COMPLETE,     handleEvent );
    todoForm.addEventListener( AppEvents.TOGGLE_COMPLETE_ALL, handleEvent );
    todoForm.addEventListener( AppEvents.UPDATE_ITEM,         handleEvent );
    todoForm.addEventListener( AppEvents.DELETE_ITEM,         handleEvent );
    todoForm.addEventListener( AppEvents.ADD_ITEM,            handleEvent );
    todoForm.addEventListener( AppEvents.CLEAR_COMPLETED,     handleEvent );
      }
  
  // Also called when Mediator is registered 
  List<String> listNotificationInterests()
  {
    return [ TodoProxy.TODOS_FILTERED ];    
  }
  
  // Handle events from the view component
  void handleEvent( CustomEvent event )
  {
    switch ( event.type )
    {
      case AppEvents.TOGGLE_COMPLETE_ALL:
        sendNotification( AppConstants.TOGGLE_TODO_STATUS, event.detail );
        break;
        
      case AppEvents.DELETE_ITEM:
        sendNotification( AppConstants.DELETE_TODO, event.detail );
        break;
        
      case AppEvents.ADD_ITEM:
        sendNotification( AppConstants.ADD_TODO, event.detail );
        break;
        
      case AppEvents.CLEAR_COMPLETED:
        sendNotification( AppConstants.REMOVE_TODOS_COMPLETED );
        break;
        
      case AppEvents.TOGGLE_COMPLETE:
      case AppEvents.UPDATE_ITEM:
        sendNotification( AppConstants.UPDATE_TODO, event.detail );
        break;
    }
  }
  
  // Called when a notification this Mediator is interested in is sent
  void handleNotification( INotification note ) 
  {
    switch (note.name) 
    {
      case TodoProxy.TODOS_FILTERED:
        todoForm.setData( note.body );
        break;
    }  
  }  
}
