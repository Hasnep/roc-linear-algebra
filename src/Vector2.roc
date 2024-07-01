module [
    Vector2,
    zeros,
    ones,
    fromList,
    toList,
    display,
    add,
    sub,
    elementwiseMul,
    div,
    dot,
    isApproxEq,
]

Vector2 : (F64, F64)

zeros : Vector2
zeros = (0, 0)

ones : Vector2
ones = (1, 1)

fromList : List F64 -> Result Vector2 [InvalidSize]
fromList = \list ->
    when list is
        [v1, v2] -> Ok (v1, v2)
        _ -> Err InvalidSize

toList : Vector2 -> List F64
toList = \(v1, v2) ->
    [v1, v2]

display : Vector2 -> Str
display = \(v1, v2) ->
    Str.joinWith ["[", Num.toStr v1, ", ", Num.toStr v2, "]"] ""

add : Vector2, Vector2 -> Vector2
add = \(a1, a2), (b1, b2) ->
    (a1 + b1, a2 + b2)

sub : Vector2, Vector2 -> Vector2
sub = \(a1, a2), (b1, b2) ->
    (a1 - b1, a2 - b2)

elementwiseMul : Vector2, Vector2 -> Vector2
elementwiseMul = \(a1, a2), (b1, b2) ->
    (a1 * b1, a2 * b2)

div : Vector2, Vector2 -> Vector2
div = \(a1, a2), (b1, b2) ->
    (a1 / b1, a2 / b2)

dot : Vector2, Vector2 -> F64
dot = \(a1, a2), (b1, b2) ->
    a1 * b1 + a2 * b2

isApproxEq : Vector2, Vector2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \(a1, a2), (b1, b2), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1 b1 { rtol, atol } && Num.isApproxEq a2 b2 { rtol, atol }
