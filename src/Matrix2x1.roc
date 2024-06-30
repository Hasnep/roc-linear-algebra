module [
    Matrix2x1,
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

Matrix2x1 := (F64, F64)

zeros : Matrix2x1
zeros = @Matrix2x1 (0, 0)

ones : Matrix2x1
ones = @Matrix2x1 (1, 1)

fromVector : Vector2.Vector2 -> Matrix2x1
fromVector = \(a, b) ->
    @Matrix2x1 (a, b)

add : Matrix2x1, Matrix2x1 -> Matrix2x1
add = \@Matrix2x1 (aA, aB), @Matrix2x1 (bA, bB) ->
    @Matrix2x1 (aA + bA, aB + bB)

sub : Matrix2x1, Matrix2x1 -> Matrix2x1
sub = \@Matrix2x1 (aA, aB), @Matrix2x1 (bA, bB) ->
    @Matrix2x1 (aA - bA, aB - bB)

elementwiseMul : Matrix2x1, Matrix2x1 -> Matrix2x1
elementwiseMul = \@Matrix2x1 (aA, aB), @Matrix2x1 (bA, bB) ->
    @Matrix2x1 (aA * bA, aB * bB)

div : Matrix2x1, Matrix2x1 -> Matrix2x1
div = \@Matrix2x1 (aA, aB), @Matrix2x1 (bA, bB) ->
    @Matrix2x1 (aA / bA, aB / bB)

isApproxEq : Matrix2x1, Matrix2x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x1 (aA, aB), @Matrix2x1 (bA, bB), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol }
