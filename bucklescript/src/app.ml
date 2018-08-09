open BSReact

type state = {
  todo_input: string;
  todos: Todo.t array
}

type action
  = ChangeInput of string
  | AddTodo
  | ToggleTodo of int
  | DeleteTodo of int

let initialState () = {
  todo_input= "";
  todos= [||]
}

let reducer action state = match action, state with
    ChangeInput todo_input, _ ->
    RR.Update { state with todo_input }
  | AddTodo, {todo_input; todos} ->
    RR.Update { todo_input= ""; todos= Array.append todos [|{ Todo.desc= todo_input; state= false }|] }
  | ToggleTodo idx, {todos} ->
    let todos = Array.copy todos in
    let todo = todos.(idx) in
    todos.(idx) <- Todo.toggle todo;
    RR.Update { state with todos }
  | DeleteTodo idx, {todos} ->
    let todos =
      todos
      |> Array.mapi (fun i todo -> i, todo)
      |> Array.fold_left
        (fun acc (i, todo) -> if i = idx then acc else todo :: acc)
        []
      |> List.rev
      |> Array.of_list in
    RR.Update { state with todos }

let component = RR.reducerComponent "App"

let make _children = {
  component with
  initialState;
  reducer;
  render= fun self ->
    let send = self.RR.send in
    let {todo_input; todos} = self.state in
    let dispatcher = object
      method todoInput event =
        let todo_input = (RE.Form.target event)##value in
        send (ChangeInput todo_input);
      method todoAdd event =
        RE.Mouse.preventDefault event;
        send AddTodo;
      method todoToggle idx event =
        RE.Mouse.preventDefault event;
        send (ToggleTodo idx);
      method todoDelete idx event =
        RE.Mouse.preventDefault event;
        send (DeleteTodo idx);
    end in
    div ~className:"todo-app" [
      h1 [ s "TODO LIST" ];
      TodoList.c ~dispatcher ~todo_input ~todos []
    ]
}

let c children =
  RR.element @@ make children