open BSReact

type t = {
  desc: string;
  state: bool
}

let toggle ({state} as todo) =
  { todo with state= not state }

class virtual dispatcher = object
  method virtual todoToggle: int -> RE.Mouse.t -> unit
  method virtual todoDelete: int -> RE.Mouse.t -> unit
end

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
      td [ s @@ {j|#$(visible_index)|j} ];
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