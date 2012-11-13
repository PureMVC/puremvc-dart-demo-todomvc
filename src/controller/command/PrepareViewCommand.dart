part of todomvc;
class PrepareViewCommand extends mvc.SimpleCommand
{
  void execute( mvc.INotification note )
  {
    facade.registerMediator( new TodoFormMediator( new TodoForm() ) );
    facade.registerMediator( new RoutesMediator( new hr.HashRouter() ) );
  }
}
