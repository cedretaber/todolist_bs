module Todo = {
  type t = {
    desc: string,
    state: bool,
  };

  let toggle = ({state} as todo) => {...todo, state: !state};

  let component = ReasonReact.statelessComponent("Todo");

  let make = (~idx, ~dispatcher, ~todo as {desc, state}, _children) => {
    ...component,
    render: _self => {
      let desc =
        if (state) {
          <del> (ReasonReact.string(desc)) </del>;
        } else {
          ReasonReact.string(desc);
        };
      let visible_index = idx + 1;
      <tr>
        <td> (ReasonReact.string({j|#$(visible_index)|j})) </td>
        <td> <div onClick=(dispatcher#todoToggle(idx))> desc </div> </td>
        <td>
          <button className="button" onClick=(dispatcher#todoDelete(idx))>
            (ReasonReact.string("x"))
          </button>
        </td>
      </tr>;
    },
  };
};

let component = ReasonReact.statelessComponent("Todo");

let make = (~dispatcher, ~todo_input, ~todos, _children) => {
  ...component,
  render: _self => {
    let todos =
      Array.mapi((idx, todo) => <Todo idx dispatcher todo />, todos);
    <div className="todo-list">
      <TodoInput dispatcher todo_input />
      <table>
        <thead> <tr> <th /> <th /> <th /> </tr> </thead>
        <tbody> ...todos </tbody>
      </table>
    </div>;
  },
};