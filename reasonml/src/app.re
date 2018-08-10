module Todo = TodoList.Todo;

type state = {
  todo_input: string,
  todos: array(Todo.t),
};

type action =
  | ChangeInput(string)
  | AddTodo
  | ToggleTodo(int)
  | DeleteTodo(int);

let initialState = () => {todo_input: "", todos: [||]};

let reducer = (action, state) =>
  switch (action, state) {
  | (ChangeInput(todo_input), _) =>
    ReasonReact.Update({...state, todo_input})
  | (AddTodo, {todo_input, todos}) =>
    ReasonReact.Update({
      todo_input: "",
      todos: Array.append(todos, [|{desc: todo_input, state: false}|]),
    })
  | (ToggleTodo(idx), {todos}) =>
    let todos = Array.copy(todos);
    let todo = todos[idx];
    todos[idx] = Todo.toggle(todo);
    ReasonReact.Update({...state, todos});
  | (DeleteTodo(idx), {todos}) =>
    let todos =
      todos
      |> Array.mapi((i, todo) => (i, todo))
      |> Array.fold_left(
           (acc, (i, todo)) => i == idx ? acc : [todo, ...acc],
           [],
         )
      |> List.rev
      |> Array.of_list;
    ReasonReact.Update({...state, todos});
  };

class dispatcher (self) = {
  let send = self.ReasonReact.send;
  pub todoInput = event => {
    let todo_input = event->ReactEvent.Form.target##value;
    send(ChangeInput(todo_input));
  };
  pub todoAdd = event => {
    event->ReactEvent.Mouse.preventDefault;
    send(AddTodo);
  };
  pub todoToggle = (idx, event) => {
    event->ReactEvent.Mouse.preventDefault;
    send(ToggleTodo(idx));
  };
  pub todoDelete = (idx, event) => {
    event->ReactEvent.Mouse.preventDefault;
    send(DeleteTodo(idx));
  };
};

let component = ReasonReact.reducerComponent("App");

let make = _children => {
  ...component,
  initialState,
  reducer,
  render: self => {
    let {todo_input, todos} = self.state;
    let dispatcher = (new dispatcher)(self);
    <div className="todo-app">
      <h1> (ReasonReact.string("TODO LIST")) </h1>
      <TodoList dispatcher todo_input todos />
    </div>;
  },
};