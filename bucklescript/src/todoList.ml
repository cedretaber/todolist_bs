open BSReact

module Todo = struct
  type t = {
    desc: string;
    state: bool
  }

  let toggle ({state} as todo) =
    { todo with state= not state }

  let component = RR.statelessComponent "Todo"

  let make ~idx ~dispatcher ~todo:{desc; state} _children = {
    component with
    render= fun _self ->
      let desc =
        if state then
          del [ s desc ]
        else
          s desc in
      let visible_index = idx + 1 in
      tr [
        td [ s {j|#$(visible_index)|j} ];
        td [
          div ~onClick:(dispatcher#todoToggle idx) [
            desc
          ]
        ];
        td [
          button ~className:"button" ~onClick:(dispatcher#todoDelete idx) [
            s "x"
          ]
        ]
      ]
  }

  let c ~idx ~dispatcher ~todo children =
    RR.element @@ make ~idx ~dispatcher ~todo children
end

let component = RR.statelessComponent "Todo"

let make ~dispatcher ~todos _children = {
  component with
  render= fun _self ->
    let todos =
      todos
      |> Array.mapi (fun idx todo -> 
        Todo.c ~idx ~dispatcher ~todo [])
      |> Array.to_list in
    div ~className:"todo-list" [
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

let c ~dispatcher ~todos children =
  RR.element @@ make ~dispatcher ~todos children