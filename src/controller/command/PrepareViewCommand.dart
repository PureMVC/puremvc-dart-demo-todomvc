class PrepareViewCommand extends MVCSimpleCommand
{
  void execute( INotification note ) 
  {
    facade.registerMediator( new TodoFormMediator( new TodoForm() ) );
    facade.registerMediator( new RoutesMediator( new HashRouter() ) );
  }
}
