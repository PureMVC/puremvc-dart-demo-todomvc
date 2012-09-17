class CompoundVO {
  
  // Instance members  
  List<TodoVO> todos = [];
  StatsVO stats = new StatsVO();
  String filter = TodoVO.FILTER_ALL;
 
  // Constructor
  CompoundVO( [ List<TodoVO> this.todos, StatsVO this.stats, String this.filter ] ){}
  
}