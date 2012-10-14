class RoutesMediator extends mvc.Mediator
{
  // Name Mediator will be registered as
  static const String NAME = 'RoutesMediator';

  // Routes
  static const String ROUTE_ALL = '/';
  static const String ROUTE_ACTIVE = '/active';
  static const String ROUTE_COMPLETED = "/completed";

  // Constructor
  RoutesMediator( hr.HashRouter viewComponent ):super( NAME, viewComponent ){}

  // Accessors to cast viewComponent to the correct type for this Mediator
  hr.HashRouter get router() { return viewComponent; }
  void set router( hr.HashRouter component ) { viewComponent = component; }

  // Called when Mediator is registered
  void onRegister()
  {
    // Get the default route from the TodoProxy (may come from local storage)
    TodoProxy todoProxy = facade.retrieveProxy( TodoProxy.NAME ) as TodoProxy;
    String currentFilter = todoProxy.filter;

    // Add route handlers
    router.addHandlerFunc( ROUTE_ALL, handleRouteChange );
    router.addHandlerFunc( ROUTE_ACTIVE, handleRouteChange );
    router.addHandlerFunc( ROUTE_COMPLETED, handleRouteChange );

    // Go to the default route
    router.goTo( getRouteForFilter( currentFilter ) );
  }

  // Look up Route for Filter
  String getRouteForFilter( String filter ) {
    String route;
    switch ( filter ) {
      case TodoVO.FILTER_ACTIVE:
        route = ROUTE_ACTIVE;
        break;

      case TodoVO.FILTER_COMPLETED:
        route = ROUTE_COMPLETED;
        break;

      case TodoVO.FILTER_ALL:
      default:
        route = ROUTE_ALL;
        break;
    }
    return route;
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
