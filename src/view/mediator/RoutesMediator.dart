class RoutesMediator extends MVCMediator
{
  // Name Mediator will be registered as 
  static const String NAME = 'RoutesMediator';
  
  // Routes
  static const String ROUTE_ALL = '/';
  static const String ROUTE_ACTIVE = '/active';
  static const String ROUTE_COMPLETED = "/completed";
  
  // Constructor
  RoutesMediator( HashRouter viewComponent ):super( NAME, viewComponent ){}  

  // Accessors to cast viewComponent to the correct type for this Mediator
  HashRouter get router() { return viewComponent; }
  void set router( HashRouter component ) { viewComponent = component; }

  // Called when Mediator is registered
  void onRegister()
  {
    // Get the default route from the TodoProxy (may come from local storage)
    TodoProxy todoProxy = facade.retrieveProxy( TodoProxy.NAME );
    String defaultRoute = todoProxy.filter;
    
    // Add route handlers
    router.addHandlerFunc( ROUTE_ALL, handleRouteChange );
    router.addHandlerFunc( ROUTE_ACTIVE, handleRouteChange );
    router.addHandlerFunc( ROUTE_COMPLETED, handleRouteChange );

    // Go to the default route
    router.goTo( defaultRoute );
  }
    
  // Handle route changes
  void handleRouteChange( String path, Map<String,String> values ) {
    String filter;
    switch ( path ) {
      case ROUTE_ACTIVE:
        filter = TodoVO.FILTER_ACTIVE;
        break;
        
      case ROUTE_COMPLETED:
        filter = TodoVO.FILTER_COMPLETED;
        break;
        
      case ROUTE_ALL:
      default:
        filter = TodoVO.FILTER_ALL;
        break;
        
    }
    facade.sendNotification( AppConstants.FILTER_TODOS, filter );
  }
  
}
