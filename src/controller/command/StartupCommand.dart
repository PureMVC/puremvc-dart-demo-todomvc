class StartupCommand extends MVCMacroCommand 
{
  void initializeMacroCommand() 
  {
    // add the subcommands
    addSubCommand( () => new PrepareControllerCommand() );
    addSubCommand( () => new PrepareModelCommand() );
    addSubCommand( () => new PrepareViewCommand() );
  }  
}
