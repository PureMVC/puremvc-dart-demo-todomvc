part of todomvc;
class TodoProxy extends mvc.Proxy
{
  static const String NAME            = "TodoProxy";
  static const String TODOS_FILTERED  = "/todos/filtered";
  static const String LOCAL_STORAGE   = "/todos-puremvc-dart";

  // Accessors that cast the data object to the correct types
  CompoundVO get compoundVO { return getData( ); }
  void set compoundVO( CompoundVO vo ) { setData( vo ); }

  // Todos
  List<TodoVO> get todos { return compoundVO.todos; }
  void set todos( List<TodoVO> list ) { compoundVO.todos = list; }

  // Stats
  StatsVO get stats { return compoundVO.stats; }
  void set stats( StatsVO vo ) { compoundVO.stats = vo; }

  // Filter
  String get filter { return compoundVO.filter; }
  void set filter( String setting ) { compoundVO.filter = setting; }

  // Constructor
  TodoProxy():super( NAME, new CompoundVO() ){}

  // Run when the Proxy is registered with the Model
  void onRegister() {
    loadData();
  }

  // Load data from local storage
  void loadData() {
    if ( window.localStorage.containsValue( LOCAL_STORAGE ) == false) {
      saveData();
    }
    String serializedStorageObject = window.localStorage[ LOCAL_STORAGE ];
    CompoundVO storageObject = new CompoundVO.fromString( serializedStorageObject );
    setData( storageObject );
    computeStats();
  }

  // Save data to local storage
  void saveData() {
    CompoundVO storageObject = new CompoundVO.assemble( todos, stats, filter );
    String serializedStorageObject = storageObject.toJson();
    window.localStorage[ LOCAL_STORAGE ] = serializedStorageObject;
  }

  // Compute the stats
  void computeStats() {
    stats.totalTodo        = todos.length;
    stats.todoCompleted    = getCompletedCount();
    stats.todoLeft         = stats.totalTodo - stats.todoCompleted;
  }

  // Filter the todo list
  void filterTodos( String setting ) {
    filter = setting;
    saveData();

    int i = todos.length;
    List<TodoVO> filtered = [];

    while ( i > 0 ) {
      i--;
      if ( identical(filter, TodoVO.FILTER_ALL) ) {
        filtered.add( todos[ i ] );
      } else if ( identical(todos[i].completed, true) && identical(filter, TodoVO.FILTER_COMPLETED) ) {
        filtered.add( todos[ i ] );
      } else if ( identical(todos[i].completed, false) && identical(filter, TodoVO.FILTER_ACTIVE) ) {
        filtered.add( todos[ i ] );
      }
    }

    // Notify the view with the filtered todo list
    CompoundVO compoundVO = new CompoundVO.assemble( filtered, stats, filter );
    sendNotification( TODOS_FILTERED, compoundVO );
  }

  // Called whenever the todo list is modified
  void todosModified() {
    computeStats();
    filterTodos( filter );
  }

  // Remove all the completed todos
  void removeTodosCompleted() {
    int i = todos.length-1;
    while ( i >= 0 ) {
      if ( todos[ i ].completed == true ) {
        todos.removeRange(i, 1);
      }
      i--;
    }
    todosModified();
  }

  // Delete a todo from the list
  void deleteTodo( String id ) {
    int i = todos.length-1;
    while ( i >= 0 ) {
      if ( this.todos[i].id == id ) {
        todos.removeRange(i, 1);
        break;
      }
      i--;
    }
    todosModified();
  }

  // Toggle the completed status of all the todos
  void toggleCompleteStatus( bool status ) {
    int i = todos.length-1;
    while ( i >= 0 ) {
      todos[ i ].completed = status;
      i--;
    }
  }

  // Update a todo in the list
  void updateTodo( TodoVO todo ) {
    int i = todos.length-1;
    while ( i >= 0 ) {
      if ( this.todos[ i ].id == todo.id ) {
        todos[ i ].title = todo.title;
        todos[ i ].completed = todo.completed;
      }
      i--;
    }
    todosModified();
  }

  // Add a todo to the list
  void addTodo( TodoVO newTodo ) {
    String id = getUuid();
    newTodo.id = id;
    todos.add( newTodo );
    todosModified();
  }

  // Get the count of completed todos
  int getCompletedCount() {
    int i = todos.length-1;
    int completed = 0;

    while ( i >= 0 ) {
      if ( this.todos[ i ].completed ) completed++;
      i--;
    }
    return completed;
  }

  // Get a unique id for a todo
  String getUuid() {
    int i, random;
    Date date = new Date.now();
    String uuid = "Todo-${date.millisecondsSinceEpoch.toString()}";
    return uuid;
  }

}
