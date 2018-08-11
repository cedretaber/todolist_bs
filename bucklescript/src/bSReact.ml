
module RR = ReasonReact

module RD = ReactDOMRe

module RE = ReactEvent

external s : string -> RR.reactElement = "%identity"

let div ?className ?onClick children =
  let props = RD.props
    ?className
    ?onClick
    () in
  RD.createElementVariadic "div" ~props @@ Array.of_list children

let input ?type_ ?onChange ?value children =
  let props = RD.props
    ?type_
    ?onChange
    ?value
    () in
  RD.createElementVariadic "input" ~props @@ Array.of_list children

let button ?className ?onClick children =
  let props = RD.props
    ?className
    ?onClick
    () in
  RD.createElementVariadic "button" ~props @@ Array.of_list children

let h1 children =
  let props = RD.props
    () in
  RD.createElementVariadic "h1" ~props @@ Array.of_list children

let table children =
  let props = RD.props () in
  RD.createElementVariadic "table" ~props @@ Array.of_list children

let thead children =
  let props = RD.props () in
  RD.createElementVariadic "thead" ~props @@ Array.of_list children

let tbody children =
  let props = RD.props () in
  RD.createElementVariadic "tbody" ~props @@ Array.of_list children

let th children =
  let props = RD.props () in
  RD.createElementVariadic "th" ~props @@ Array.of_list children

let tr children =
  let props = RD.props () in
  RD.createElementVariadic "tr" ~props @@ Array.of_list children

let td children =
  let props = RD.props () in
  RD.createElementVariadic "td" ~props @@ Array.of_list children

let del children =
  let props = RD.props () in
  RD.createElementVariadic "del" ~props @@ Array.of_list children