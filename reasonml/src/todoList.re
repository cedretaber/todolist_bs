module TodoInput {
  type dispatcher = {.
    todoInput: ReactEvent.Form.t => unit,
    todoAdd: ReactEvent.Mouse.t => unit
  };

  let component = ReasonReact.statelessComponent("TodoInput");

  let make = (~dispatcher, ~todo_input, _children) => {
    ...component,
    render: _self =>
      <div className="todo-input row">
        <div className="column">
          <input type_="text" onChange={dispatcher#todoInput} value={todo_input} />
        </div>
        <div className="column">
          <button onClick={dispatcher#todoAdd}>
            {ReasonReact.string({j|追加|j})}
          </button>
        </div>
      </div>
  }
};

type dispatcher = {.
  todoInput: ReactEvent.Form.t => unit,
  todoAdd: ReactEvent.Mouse.t => unit,
  todoToggle: int => ReactEvent.Mouse.t => unit,
  todoDelete: int => ReactEvent.Mouse.t => unit
};

let component = ReasonReact.statelessComponent("Todo");

let make = (~dispatcher, ~todo_input, ~todos, _children) => {
  ...component,
  render: _self => {
    let todos =
      Array.mapi ((idx, todo) => <Todo idx dispatcher todo />, todos);
    <div className="todo-list">
      <TodoInput dispatcher todo_input />
      <table>
        <thead>
          <tr>
            <th />
            <th />
            <th />
          </tr>
        </thead>
        <tbody>
          ...todos
        </tbody>
      </table>
    </div>
  }
};