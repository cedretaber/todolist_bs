open BSReact

module TodoInput = struct
  class virtual dispatcher = object
    method virtual todoInput: RE.Form.t -> unit
    method virtual todoAdd: RE.Mouse.t -> unit
  end

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
end

class virtual dispatcher = object
  method virtual todoInput: RE.Form.t -> unit
  method virtual todoAdd: RE.Mouse.t -> unit
  method virtual todoToggle: int -> RE.Mouse.t -> unit
  method virtual todoDelete: int -> RE.Mouse.t -> unit
end

let component = RR.statelessComponent "Todo"

let make ~dispatcher ~todo_input ~todos _children = {
  component with
  render= fun _self ->
    let todos =
      todos
      |> Array.mapi (fun idx todo -> 
        Todo.c ~idx ~dispatcher ~todo [])
      |> Array.to_list in
    div ~className:"todo-list" [
      TodoInput.c ~dispatcher ~todo_input [];
      table [
        thead [
          tr [
            th [];
            th [];
            th [];
          ]
        ];
        tbody todos
      ]
    ]
}

let c ~dispatcher ~todo_input ~todos children =
  RR.element @@ make ~dispatcher ~todo_input ~todos children