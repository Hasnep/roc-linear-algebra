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
        [a] -> Ok (a)
        _ -> Err InvalidSize

toList : Vector1 -> List F64
toList = \a -> [a]

display : Vector1 -> Str
display = \a ->
    Str.joinWith ["[", Num.toStr a, "]"] ""

add : Vector1, Vector1 -> Vector1
add = \aA, bA ->
    (aA + bA)

sub : Vector1, Vector1 -> Vector1
sub = \aA, bA ->
    (aA - bA)

elementwiseMul : Vector1, Vector1 -> Vector1
elementwiseMul = \aA, bA ->
    (aA * bA)

div : Vector1, Vector1 -> Vector1
div = \aA, bA ->
    (aA / bA)

dot : Vector1, Vector1 -> F64
dot = \aA, bA -> aA * bA

isApproxEq : Vector1, Vector1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \aA, bA, { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol }

