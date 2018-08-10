open BSReact

let component = RR.statelessComponent "TodoInput"

let make ~dispatcher ~todo_input _children = {
  component with
  render= fun _self ->
    div ~className:"todo-input row" [
      div ~className:"column" [
        input ~type_:"text" ~onChange:dispatcher#todoInput ~value:todo_input [];
      ];
      div ~className:"column" [
        button ~onClick:dispatcher#todoAdd [
          s {j|追加|j}
        ]
      ]
    ]
}

let c ~dispatcher ~todo_input children =
  RR.element @@ make ~dispatcher ~todo_input children