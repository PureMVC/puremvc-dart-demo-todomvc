class PrepareModelCommand extends MVCSimpleCommand
{
  void execute( INotification note ) 
  {
    facade.registerProxy( new TodoProxy() );
  }
}
