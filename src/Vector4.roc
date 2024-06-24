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
        [a, b, c, d] -> Ok (a, b, c, d)
        _ -> Err InvalidSize

toList : Vector4 -> List F64
toList = \(a, b, c, d) -> [a, b, c, d]

display : Vector4 -> Str
display = \(a, b, c, d) ->
    Str.joinWith ["[", Num.toStr a, ", ", Num.toStr b, ", ", Num.toStr c, ", ", Num.toStr d, "]"] ""

add : Vector4, Vector4 -> Vector4
add = \(aA, aB, aC, aD), (bA, bB, bC, bD) ->
    (aA + bA, aB + bB, aC + bC, aD + bD)

sub : Vector4, Vector4 -> Vector4
sub = \(aA, aB, aC, aD), (bA, bB, bC, bD) ->
    (aA - bA, aB - bB, aC - bC, aD - bD)

elementwiseMul : Vector4, Vector4 -> Vector4
elementwiseMul = \(aA, aB, aC, aD), (bA, bB, bC, bD) ->
    (aA * bA, aB * bB, aC * bC, aD * bD)

div : Vector4, Vector4 -> Vector4
div = \(aA, aB, aC, aD), (bA, bB, bC, bD) ->
    (aA / bA, aB / bB, aC / bC, aD / bD)

dot : Vector4, Vector4 -> F64
dot = \(aA, aB, aC, aD), (bA, bB, bC, bD) -> aA * bA + aB * bB + aC * bC + aD * bD

isApproxEq : Vector4, Vector4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \(aA, aB, aC, aD), (bA, bB, bC, bD), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol }

