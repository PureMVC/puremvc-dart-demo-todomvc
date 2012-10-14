class PrepareModelCommand extends mvc.SimpleCommand
{
  void execute( mvc.INotification note )
  {
    facade.registerProxy( new TodoProxy() );
  }
}
