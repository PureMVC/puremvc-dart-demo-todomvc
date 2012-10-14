// DART Libs
#import('dart:html');
#import('dart:json');
#import('dart:math');

// PureMVC Framework for Dart
#import('package:puremvc/puremvc.dart', prefix:'mvc');

// Hashroute utility  - Thanks, Andreas Krennmair. https://github.com/akrennmair.
#import('package:hashroute/hashroute.dart', prefix:'hr');

// JsonObject - Thanks, Chris Buckett. https://github.com/chrisbu
#import('package:JsonObject/JsonObject.dart');

// MODEL
#source('src/model/proxy/TodoProxy.dart');
#source('src/model/vo/TodoVO.dart');
#source('src/model/vo/StatsVO.dart');
#source('src/model/vo/CompoundVO.dart');

// VIEW
#source('src/view/event/AppEvents.dart');
#source('src/view/component/TodoForm.dart');
#source('src/view/mediator/RoutesMediator.dart');
#source('src/view/mediator/TodoFormMediator.dart');

// CONTROLLER
#source('src/controller/command/StartupCommand.dart');
#source('src/controller/command/PrepareControllerCommand.dart');
#source('src/controller/command/PrepareModelCommand.dart');
#source('src/controller/command/PrepareViewCommand.dart');
#source('src/controller/command/TodoCommand.dart');
#source('src/controller/constant/AppConstants.dart');

void main()
{
  // Get a unique multiton Facade instance for the application
  mvc.IFacade facade = mvc.Facade.getInstance( AppConstants.APP_NAME );

  // Startup the application's PureMVC core
  facade.registerCommand( AppConstants.STARTUP, () => new StartupCommand() );
  facade.sendNotification( AppConstants.STARTUP );

}