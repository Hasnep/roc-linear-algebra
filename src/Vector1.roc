module [
    Vector1,
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

Vector1 : F64

zeros : Vector1
zeros = 0

ones : Vector1
ones = 1

fromList : List F64 -> Result Vector1 [InvalidSize]
fromList = \list ->
    when list is
        [v1] -> Ok (v1)
        _ -> Err InvalidSize

toList : Vector1 -> List F64
toList = \v1 ->
    [v1]

display : Vector1 -> Str
display = \v1 ->
    Str.joinWith ["[", Num.toStr v1, "]"] ""

add : Vector1, Vector1 -> Vector1
add = \a1, b1 ->
    (a1 + b1)

sub : Vector1, Vector1 -> Vector1
sub = \a1, b1 ->
    (a1 - b1)

elementwiseMul : Vector1, Vector1 -> Vector1
elementwiseMul = \a1, b1 ->
    (a1 * b1)

div : Vector1, Vector1 -> Vector1
div = \a1, b1 ->
    (a1 / b1)

dot : Vector1, Vector1 -> F64
dot = \a1, b1 ->
    a1 * b1

isApproxEq : Vector1, Vector1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \a1, b1, { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1 b1 { rtol, atol }
