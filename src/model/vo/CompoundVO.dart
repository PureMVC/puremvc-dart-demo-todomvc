part of todomvc;

class CompoundVO extends JsonObject {

  // Instance members
  List<TodoVO> todos;
  StatsVO stats;
  String filter;

  // need a default, private constructor
  CompoundVO() {
    this.todos = [];
    this.stats = new StatsVO();
    this.filter = TodoVO.FILTER_ALL;
  }

  // The fromString factory method
  factory CompoundVO.fromString( String jsonString ) {
    return new JsonObject.fromJsonString( jsonString, new CompoundVO() );
  }

  // The assemble factory method
  factory CompoundVO.assemble( List<TodoVO> todos, StatsVO stats, String filter ) {
    CompoundVO compoundVO = new CompoundVO();
    compoundVO.stats = stats;
    compoundVO.filter = filter;
    compoundVO.todos = todos;
    return compoundVO;
  }

  // Serialize this object to JSON
  String toJson(){
    StringBuffer buffer = new StringBuffer();
    buffer.add( '{ ' );
    buffer.add( '"todos":' );
    buffer.add( JSON.stringify(todos) );
    buffer.add( ', ' );
    buffer.add( '"stats":' );
    buffer.add( JSON.stringify(stats) );
    buffer.add( ', ' );
    buffer.add('"filter":"');
    buffer.add( filter );
    buffer.add( '" }');
    return buffer.toString();
  }
}