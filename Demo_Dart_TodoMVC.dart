// Currently required.
library todomvc;

// DART Libs
import 'dart:html';
import 'dart:json';
import 'dart:math';

// PureMVC Framework for Dart
import 'package:puremvc/puremvc.dart' as mvc;

// Hashroute utility  - Thanks, Andreas Krennmair. https://github.com/akrennmair.
import 'package:hashroute/hashroute.dart' as hr;

// JsonObject - Thanks, Chris Buckett. https://github.com/chrisbu
import 'package:json_object/json_object.dart';

// MODEL
part 'src/model/proxy/TodoProxy.dart';
part 'src/model/vo/TodoVO.dart';
part 'src/model/vo/StatsVO.dart';
part 'src/model/vo/CompoundVO.dart';

// VIEW
part 'src/view/event/AppEvents.dart';
part 'src/view/component/TodoForm.dart';
part 'src/view/mediator/RoutesMediator.dart';
part 'src/view/mediator/TodoFormMediator.dart';

// CONTROLLER
part 'src/controller/command/StartupCommand.dart';
part 'src/controller/command/PrepareControllerCommand.dart';
part 'src/controller/command/PrepareModelCommand.dart';
part 'src/controller/command/PrepareViewCommand.dart';
part 'src/controller/command/TodoCommand.dart';
part 'src/controller/constant/AppConstants.dart';

void main()
{
  // Get a unique multiton Facade instance for the application
  mvc.IFacade facade = mvc.Facade.getInstance( AppConstants.APP_NAME );

  // Startup the application's PureMVC core
  facade.registerCommand( AppConstants.STARTUP, () => new StartupCommand() );
  facade.sendNotification( AppConstants.STARTUP );

}