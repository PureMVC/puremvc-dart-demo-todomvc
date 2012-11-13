part of todomvc;

class StatsVO extends JsonObject {

  // Instance members
  int totalTodo;
  int todoLeft;
  int todoCompleted;

  // need a default, private constructor
  StatsVO() {
    this.totalTodo = 0;
    this.todoLeft = 0;
    this.todoCompleted = 0;
  }

  factory StatsVO.fromString( String jsonString ) {
    return new JsonObject.fromJsonString( jsonString, new StatsVO() ) ;
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