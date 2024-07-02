module [
    Vector3,
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
    cross,
    isApproxEq,
]

Vector3 : (F64, F64, F64)

zeros : Vector3
zeros = (0, 0, 0)

ones : Vector3
ones = (1, 1, 1)

fromList : List F64 -> Result Vector3 [InvalidSize]
fromList = \list ->
    when list is
        [v1, v2, v3] -> Ok (v1, v2, v3)
        _ -> Err InvalidSize

toList : Vector3 -> List F64
toList = \(v1, v2, v3) ->
    [v1, v2, v3]

display : Vector3 -> Str
display = \(v1, v2, v3) ->
    Str.joinWith ["[", Num.toStr v1, ", ", Num.toStr v2, ", ", Num.toStr v3, "]"] ""

add : Vector3, Vector3 -> Vector3
add = \(a1, a2, a3), (b1, b2, b3) ->
    (a1 + b1, a2 + b2, a3 + b3)

sub : Vector3, Vector3 -> Vector3
sub = \(a1, a2, a3), (b1, b2, b3) ->
    (a1 - b1, a2 - b2, a3 - b3)

elementwiseMul : Vector3, Vector3 -> Vector3
elementwiseMul = \(a1, a2, a3), (b1, b2, b3) ->
    (a1 * b1, a2 * b2, a3 * b3)

div : Vector3, Vector3 -> Vector3
div = \(a1, a2, a3), (b1, b2, b3) ->
    (a1 / b1, a2 / b2, a3 / b3)

dot : Vector3, Vector3 -> F64
dot = \(a1, a2, a3), (b1, b2, b3) ->
    a1 * b1 + a2 * b2 + a3 * b3

cross : Vector3, Vector3 -> Vector3
cross = \(a1, a2, a3), (b1, b2, b3) ->
    (a2 * b3 - a3 * b2, -a1 * b3 + a3 * b1, a1 * b2 - a2 * b1)

isApproxEq : Vector3, Vector3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \(a1, a2, a3), (b1, b2, b3), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1 b1 { rtol, atol } && Num.isApproxEq a2 b2 { rtol, atol } && Num.isApproxEq a3 b3 { rtol, atol }
