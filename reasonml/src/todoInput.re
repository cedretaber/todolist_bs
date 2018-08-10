let component = ReasonReact.statelessComponent("TodoInput");

let make = (~dispatcher, ~todo_input, _children) => {
  ...component,
  render: _self =>
    <div className="todo-input row">
      <div className="column">
        <input type_="text" onChange=dispatcher#todoInput value=todo_input />
      </div>
      <div className="column">
        <button onClick=dispatcher#todoAdd>
          (ReasonReact.string({j|追加|j}))
        </button>
      </div>
    </div>,
};