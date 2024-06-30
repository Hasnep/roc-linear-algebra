module [
    Matrix1x2,
    zeros,
    ones,
    fromVector,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector2

Matrix1x2 := (F64, F64)

zeros : Matrix1x2
zeros = @Matrix1x2 (0, 0)

ones : Matrix1x2
ones = @Matrix1x2 (1, 1)

fromVector : Vector2.Vector2 -> Matrix1x2
fromVector = \(a, b) ->
    @Matrix1x2 (a, b)

add : Matrix1x2, Matrix1x2 -> Matrix1x2
add = \@Matrix1x2 (aA, aB), @Matrix1x2 (bA, bB) ->
    @Matrix1x2 (aA + bA, aB + bB)

sub : Matrix1x2, Matrix1x2 -> Matrix1x2
sub = \@Matrix1x2 (aA, aB), @Matrix1x2 (bA, bB) ->
    @Matrix1x2 (aA - bA, aB - bB)

elementwiseMul : Matrix1x2, Matrix1x2 -> Matrix1x2
elementwiseMul = \@Matrix1x2 (aA, aB), @Matrix1x2 (bA, bB) ->
    @Matrix1x2 (aA * bA, aB * bB)

div : Matrix1x2, Matrix1x2 -> Matrix1x2
div = \@Matrix1x2 (aA, aB), @Matrix1x2 (bA, bB) ->
    @Matrix1x2 (aA / bA, aB / bB)

isApproxEq : Matrix1x2, Matrix1x2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x2 (aA, aB), @Matrix1x2 (bA, bB), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol }
