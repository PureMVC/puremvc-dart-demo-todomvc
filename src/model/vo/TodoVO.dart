part of todomvc;

class TodoVO extends JsonObject {
  // Instance members
  String id = '';
  String title = '';
  bool completed = false;

  // Filter settings
  static const String FILTER_ALL              = "filter/setting/all";
  static const String FILTER_ACTIVE           = "filter/setting/active";
  static const String FILTER_COMPLETED        = "filter/setting/completed";

  // need a default, private constructor
  TodoVO();

  factory TodoVO.fromString( String jsonString ) {
    return new JsonObject.fromJsonString( jsonString, new TodoVO() );
  }

  // Serialize this object to JSON
  String toJson() {

    StringBuffer buffer = new StringBuffer();
    buffer.add('{');
    buffer.add('"id":"');
    buffer.add( id );
    buffer.add('", ');

    buffer.add('"title":"');
    buffer.add( title );
    buffer.add('", ');

    buffer.add('"completed":');
    buffer.add( completed.toString() );
    buffer.add('}');

    return buffer.toString();
  }
}