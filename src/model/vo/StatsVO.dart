interface StatsVO default _StatsVOImpl {
  
  // Instance members
  int totalTodo;
  int todoLeft;
  int todoCompleted;

  // the from JsonString constructor
  StatsVO.fromString( String jsonString );

  // the default constructor
  StatsVO();
  
  // Serialize to JSON
  String toJson();
}

class _StatsVOImpl extends JsonObject implements StatsVO {
  
  // Instance members
  int totalTodo;
  int todoLeft;
  int todoCompleted;

  // need a default, private constructor
  _StatsVOImpl() {
    this.totalTodo = 0;
    this.todoLeft = 0;
    this.todoCompleted = 0;
  }
    
  factory _StatsVOImpl.fromString( String jsonString ) {
    return new JsonObject.fromJsonString( jsonString, new _StatsVOImpl() ) ;
  }

  // Serialize this object to JSON
  String toJson(){
    StringBuffer buffer = new StringBuffer();
    buffer.add( '{' );
    buffer.add( '"totalTodo":' );
    buffer.add( totalTodo.toString() );
    buffer.add( ', ' );
    buffer.add( '"todoLeft":' );
    buffer.add( todoLeft.toString() );
    buffer.add( ', ' );
    buffer.add('"todoCompleted":');
    buffer.add( todoCompleted.toString() );
    buffer.add( '}');
    return buffer.toString();
  }
}