module [
    Vector4,
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

Vector4 : (F64, F64, F64, F64)

zeros : Vector4
zeros = (0, 0, 0, 0)

ones : Vector4
ones = (1, 1, 1, 1)

fromList : List F64 -> Result Vector4 [InvalidSize]
fromList = \list ->
    when list is
        [v1, v2, v3, v4] -> Ok (v1, v2, v3, v4)
        _ -> Err InvalidSize

toList : Vector4 -> List F64
toList = \(v1, v2, v3, v4) ->
    [v1, v2, v3, v4]

display : Vector4 -> Str
display = \(v1, v2, v3, v4) ->
    Str.joinWith ["[", Num.toStr v1, ", ", Num.toStr v2, ", ", Num.toStr v3, ", ", Num.toStr v4, "]"] ""

add : Vector4, Vector4 -> Vector4
add = \(a1, a2, a3, a4), (b1, b2, b3, b4) ->
    (a1 + b1, a2 + b2, a3 + b3, a4 + b4)

sub : Vector4, Vector4 -> Vector4
sub = \(a1, a2, a3, a4), (b1, b2, b3, b4) ->
    (a1 - b1, a2 - b2, a3 - b3, a4 - b4)

elementwiseMul : Vector4, Vector4 -> Vector4
elementwiseMul = \(a1, a2, a3, a4), (b1, b2, b3, b4) ->
    (a1 * b1, a2 * b2, a3 * b3, a4 * b4)

div : Vector4, Vector4 -> Vector4
div = \(a1, a2, a3, a4), (b1, b2, b3, b4) ->
    (a1 / b1, a2 / b2, a3 / b3, a4 / b4)

dot : Vector4, Vector4 -> F64
dot = \(a1, a2, a3, a4), (b1, b2, b3, b4) ->
    a1 * b1 + a2 * b2 + a3 * b3 + a4 * b4

isApproxEq : Vector4, Vector4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \(a1, a2, a3, a4), (b1, b2, b3, b4), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1 b1 { rtol, atol } && Num.isApproxEq a2 b2 { rtol, atol } && Num.isApproxEq a3 b3 { rtol, atol } && Num.isApproxEq a4 b4 { rtol, atol }
