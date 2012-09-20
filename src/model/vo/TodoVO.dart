interface TodoVO default _TodoVOImpl {
  
  // Instance members
  String id;
  String title;
  bool completed;

  // Filter settings
  static const String FILTER_ALL              = "filter/setting/all";
  static const String FILTER_ACTIVE           = "filter/setting/active";
  static const String FILTER_COMPLETED        = "filter/setting/completed";

  // the from JsonString constructor
  TodoVO.fromString( String jsonString );

  // the default constructor
  TodoVO();

  // Serialize to JSON
  String toJson();
}

class _TodoVOImpl extends JsonObject implements TodoVO {
  // Instance members
  String id = '';
  String title = '';
  bool completed = false;

  // need a default, private constructor
  _TodoVOImpl();
    
  factory _TodoVOImpl.fromString( String jsonString ) {
    return new JsonObject.fromJsonString( jsonString, new _TodoVOImpl() );
  }
  
  // Serialize this object to JSON
  String toJson() {
    StringBuffer buffer = new StringBuffer();
    buffer.add('{');
    buffer.add('"id":"');
    buffer.add(id);
    buffer.add('", ');
    
    buffer.add('"title":"');
    buffer.add( title );
    buffer.add('", ');
    
    buffer.add('"completed":');
    buffer.add(completed.toString());
    buffer.add('}');
    
    return buffer.toString();
  }
}