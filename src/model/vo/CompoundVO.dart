interface CompoundVO default _CompoundVOImpl {
  
  // Instance members  
  List<TodoVO> todos;
  StatsVO stats;
  String filter;

  // Constructor: From JsonString
  CompoundVO.fromString( String jsonString );
  
  // Constructor: Assemble a CompoundVO
  CompoundVO.assemble( List<TodoVO> todos, StatsVO stats, String filter );

  // Constructor
  CompoundVO();
  
  // Serialize to JSON
  String toJson();
}

class _CompoundVOImpl extends JsonObject implements CompoundVO {
  
  // Instance members  
  List<TodoVO> todos;
  StatsVO stats;
  String filter;

  // need a default, private constructor
  _CompoundVOImpl() {
    this.todos = [];
    this.stats = new StatsVO();
    this.filter = TodoVO.FILTER_ALL;
  }

  // The fromString factory method
  factory _CompoundVOImpl.fromString( String jsonString ) {
    return new JsonObject.fromJsonString( jsonString, new _CompoundVOImpl() );
  }
  
  // The assemble factory method
  factory _CompoundVOImpl.assemble( List<TodoVO> todos, StatsVO stats, String filter ) {
    CompoundVO compoundVO = new _CompoundVOImpl();
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