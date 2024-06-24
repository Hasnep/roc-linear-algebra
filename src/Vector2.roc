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
        [a, b] -> Ok (a, b)
        _ -> Err InvalidSize

toList : Vector2 -> List F64
toList = \(a, b) -> [a, b]

display : Vector2 -> Str
display = \(a, b) ->
    Str.joinWith ["[", Num.toStr a, ", ", Num.toStr b, "]"] ""

add : Vector2, Vector2 -> Vector2
add = \(aA, aB), (bA, bB) ->
    (aA + bA, aB + bB)

sub : Vector2, Vector2 -> Vector2
sub = \(aA, aB), (bA, bB) ->
    (aA - bA, aB - bB)

elementwiseMul : Vector2, Vector2 -> Vector2
elementwiseMul = \(aA, aB), (bA, bB) ->
    (aA * bA, aB * bB)

div : Vector2, Vector2 -> Vector2
div = \(aA, aB), (bA, bB) ->
    (aA / bA, aB / bB)

dot : Vector2, Vector2 -> F64
dot = \(aA, aB), (bA, bB) -> aA * bA + aB * bB

isApproxEq : Vector2, Vector2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \(aA, aB), (bA, bB), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol }

