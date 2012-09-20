class TodoForm
{

  // Fixed elements managed by this view component
  Element todoApp;
  Element main;
  InputElement newTodoField;
  InputElement toggleAllCheckbox;
  UListElement todoList;
  Element footer;
  Element todoCount;
  ButtonElement clearButton;
  Element filters;
  AnchorElement filterAll;
  AnchorElement filterActive;
  AnchorElement filterCompleted;
  
  // Data for display
  List<TodoVO> todos;
  StatsVO stats;
  String filter;
  
  // Keycode
  static const int ENTER_KEY = 13;
  
  // Constructor
  TodoForm() 
  {
    // Fixed DOM elements managed by this view component
    todoApp            = document.query( '#todoapp' );
    main               = todoApp.query( '#main' );
    toggleAllCheckbox  = todoApp.query( '#toggle-all' );
    newTodoField       = todoApp.query( '#new-todo' );
    todoList           = todoApp.query( '#todo-list' );
    footer             = todoApp.query( '#footer' );
    todoCount          = todoApp.query( '#todo-count' );
    clearButton        = todoApp.query( '#clear-completed' );
    filters            = todoApp.query( '#filters' );
    filterAll          = filters.query( '#filterAll' );
    filterActive       = filters.query( '#filterActive' );
    filterCompleted    = filters.query( '#filterCompleted' );
    
    // Add event listeners to fixed elements
    toggleAllCheckbox.$dom_addEventListener( 'change', dispatchToggleCompleteAll );
    clearButton.$dom_addEventListener( 'click', dispatchClearCompleted );
    newTodoField.$dom_addEventListener( 'keypress', dispatchAddTodo );
  }
    
  // Add EventListeners to this component. 
  // Used by TodoMediator, delegated to todoApp element.
  void addEventListener( String type, EventListener listener )
  {
    todoApp.$dom_addEventListener( type, listener );
  }
    
  // Dispatch a CustomEvent.
  void dispatchEvent( String eventName, [Object data = null] )
  {
    CustomEvent event = document.$dom_createEvent( 'CustomEvent' );
    event.initCustomEvent( eventName, true, true, data );
    todoApp.$dom_dispatchEvent( event );
  }

  void dispatchToggleComplete( Event event ) {
    InputElement element = event.srcElement;
    TodoVO todo = getTodoById( element.$dom_getAttribute( 'data-todo-id' ) );
    todo.completed = element.checked;   
    dispatchEvent( AppEvents.TOGGLE_COMPLETE, todo );                
  }       

  void dispatchToggleCompleteAll( Event event ) {
    InputElement element = event.srcElement;
    dispatchEvent( AppEvents.TOGGLE_COMPLETE_ALL, element.checked );
  }      
  
  void dispatchClearCompleted( Event event ) {
    dispatchEvent( AppEvents.CLEAR_COMPLETED );
  }
  
  void dispatchDeleteTodo( Event event ) {
    Element element = event.target;
    String id = element.$dom_getAttribute('data-todo-id');
    dispatchEvent( AppEvents.DELETE_ITEM, id );
  }
  
  void dispatchAddTodo( KeyboardEvent event ) {
    if ( event.keyCode != ENTER_KEY ) return;
    TodoVO todo = new TodoVO();
    todo.title = newTodoField.value.trim();
    if (todo.title != '') dispatchEvent( AppEvents.ADD_ITEM, todo.toJson() );
  }
  
  void handleEditTodo( KeyboardEvent event ) {
    if ( event.keyCode != ENTER_KEY ) return;
    dispatchUpdateTodo( event );
  }
  
  void dispatchUpdateTodo( Event event ) {
    InputElement element = event.srcElement;
    TodoVO todo = getTodoById( element.id.substring(6) );
    String title = element.value.trim();
    if ( title != todo.title) {
      todo.title = title;
      dispatchEvent( AppEvents.UPDATE_ITEM, todo );
    }
  }
  
  void focusForEdit( Event event ) {
    InputElement element = event.srcElement;
    String todoId = element.$dom_getAttribute('data-todo-id');
    Element div = document.$dom_getElementById('li_{todoId}');
    InputElement inputEditTodo = document.$dom_getElementById( todoId );
    div.classes.toggle( 'editing' );
    inputEditTodo.focus();
  }
  
  void setData( CompoundVO data ) {
    // Update instance data
    todos  = data.todos;
    stats  = data.stats;
    filter = data.filter;
    
    // Hide main section if no todos
    main.style.display = ( stats.totalTodo > 0 ) ? 'block' : 'none';

    // Refresh Todo Form
    todoList.innerHTML = '';
    newTodoField.value = '';     
    
    TodoVO todo;
    InputElement checkbox;
    LabelElement label;
    DivElement divDisplay;
    ButtonElement deleteLink;
    InputElement inputEditTodo;
    LIElement li;
 
    // Create the UI for each individual todo
    for ( int i=0; i < todos.length; i++ ) {
      
      todo = todos[ i ];
      
      // Create checkbox
      checkbox = document.$dom_createElement('input');
      checkbox.$dom_addEventListener('change', dispatchToggleComplete );
      checkbox.$dom_setAttribute( 'data-todo-id', todo.id );
      checkbox.classes.toggle('toggle');
      checkbox.type = 'checkbox';
      
      // Create div text
      label = document.$dom_createElement('label');
      label.$dom_appendChild( document.$dom_createTextNode( todo.title ) );
      label.$dom_setAttribute( 'data-todo-id', todo.id );
      
      // Create delete button
      deleteLink = document.$dom_createElement('button');
      deleteLink.$dom_addEventListener('click', dispatchDeleteTodo );
      deleteLink.$dom_setAttribute('data-todo-id', todo.id);
      deleteLink.classes.toggle('destroy');
      
      // Create divDisplay
      divDisplay = document.$dom_createElement('div');
      divDisplay.$dom_addEventListener('dblclick', focusForEdit );
      divDisplay.$dom_setAttribute('data-todo-id', todo.id );
      divDisplay.$dom_appendChild( checkbox );
      divDisplay.$dom_appendChild( label );
      divDisplay.$dom_appendChild( deleteLink );
      divDisplay.classes.toggle( 'view' );
      
      // Create todo input
      inputEditTodo = document.$dom_createElement('input');
      inputEditTodo.$dom_addEventListener('keypress', handleEditTodo );            
      inputEditTodo.$dom_addEventListener('blur', dispatchUpdateTodo );
      inputEditTodo.$dom_setAttribute( 'data-todo-completed', todo.completed.toString() );
      inputEditTodo.id = 'input_{todo.id}';
      inputEditTodo.value = todo.title;
      inputEditTodo.classes.toggle( 'edit' );
      
      // Create the todo list item and add to list
      li = document.$dom_createElement('li');
      li.id = 'li_{todo.id}';
      if ( todo.completed ) {
        li.classes.toggle( 'complete' );
        checkbox.checked = true;
      }            
      li.$dom_appendChild( divDisplay );
      li.$dom_appendChild( inputEditTodo );            
      todoList.$dom_appendChild(li);
    } 
    
    // Update Stats UI
    footer.style.display = ( stats.totalTodo > 0 ) ? 'block' : 'none';
    updateClearButton();
    updateTodoCount();
    updateFilter();
    
  }
  
  // Get a todo by id from the filtered list
  TodoVO getTodoById( String id ) {
    TodoVO todo;
    for ( int i = 0; i < todos.length; i++) {
      if (todos[i].id == id) {
        todo = todos[i];
        break;
      }
    } 
    return todo;
  }
  
  void updateFilter() {
    if ( filter == TodoVO.FILTER_ALL ) { filterAll.classes.add('selected'); } else { filterAll.classes.remove('selected'); }
    if ( filter == TodoVO.FILTER_ACTIVE ) { filterActive.classes.add('selected'); } else { filterActive.classes.remove('selected'); }
    if ( filter == TodoVO.FILTER_COMPLETED ) { filterCompleted.classes.add('selected'); } else { filterCompleted.classes.remove('selected'); }
  }
  
  void updateClearButton() {
    clearButton.style.display = ( stats.todoCompleted == 0 ) ? 'none' : 'block';
    clearButton.innerHTML = 'Clear completed ({stats.todoCompleted})';
  }
  
  void updateTodoCount() {
    Element countDisplay = document.$dom_createElement('strong');
    countDisplay.innerHTML = stats.todoLeft.toString();
    String desc = ( stats.todoLeft == 1) ? 'item' : 'items';
    String text = ' ${desc} left';            
    todoCount.innerHTML = '';
    todoCount.$dom_appendChild(countDisplay);
    todoCount.$dom_appendChild(document.$dom_createTextNode(text));
  }
}