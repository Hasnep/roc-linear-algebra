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
        [a, b, c] -> Ok (a, b, c)
        _ -> Err InvalidSize

toList : Vector3 -> List F64
toList = \(a, b, c) -> [a, b, c]

display : Vector3 -> Str
display = \(a, b, c) ->
    Str.joinWith ["[", Num.toStr a, ", ", Num.toStr b, ", ", Num.toStr c, "]"] ""

add : Vector3, Vector3 -> Vector3
add = \(aA, aB, aC), (bA, bB, bC) ->
    (aA + bA, aB + bB, aC + bC)

sub : Vector3, Vector3 -> Vector3
sub = \(aA, aB, aC), (bA, bB, bC) ->
    (aA - bA, aB - bB, aC - bC)

elementwiseMul : Vector3, Vector3 -> Vector3
elementwiseMul = \(aA, aB, aC), (bA, bB, bC) ->
    (aA * bA, aB * bB, aC * bC)

div : Vector3, Vector3 -> Vector3
div = \(aA, aB, aC), (bA, bB, bC) ->
    (aA / bA, aB / bB, aC / bC)

dot : Vector3, Vector3 -> F64
dot = \(aA, aB, aC), (bA, bB, bC) -> aA * bA + aB * bB + aC * bC

cross : Vector3, Vector3 -> Vector3
cross = \(aA, aB, aC), (bA, bB, bC) ->
    (aB * bC - aC * bB, -aA * bC + aC * bA, aA * bB - aB * bA)

isApproxEq : Vector3, Vector3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \(aA, aB, aC), (bA, bB, bC), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol }

