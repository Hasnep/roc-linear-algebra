module [
    Matrix1x3,
    zeros,
    ones,
    fromVector,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector3

Matrix1x3 := (F64, F64, F64)

zeros : Matrix1x3
zeros = @Matrix1x3 (0, 0, 0)

ones : Matrix1x3
ones = @Matrix1x3 (1, 1, 1)

fromVector : Vector3.Vector3 -> Matrix1x3
fromVector = \(a, b, c) ->
    @Matrix1x3 (a, b, c)

add : Matrix1x3, Matrix1x3 -> Matrix1x3
add = \@Matrix1x3 (aA, aB, aC), @Matrix1x3 (bA, bB, bC) ->
    @Matrix1x3 (aA + bA, aB + bB, aC + bC)

sub : Matrix1x3, Matrix1x3 -> Matrix1x3
sub = \@Matrix1x3 (aA, aB, aC), @Matrix1x3 (bA, bB, bC) ->
    @Matrix1x3 (aA - bA, aB - bB, aC - bC)

elementwiseMul : Matrix1x3, Matrix1x3 -> Matrix1x3
elementwiseMul = \@Matrix1x3 (aA, aB, aC), @Matrix1x3 (bA, bB, bC) ->
    @Matrix1x3 (aA * bA, aB * bB, aC * bC)

div : Matrix1x3, Matrix1x3 -> Matrix1x3
div = \@Matrix1x3 (aA, aB, aC), @Matrix1x3 (bA, bB, bC) ->
    @Matrix1x3 (aA / bA, aB / bB, aC / bC)

isApproxEq : Matrix1x3, Matrix1x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x3 (aA, aB, aC), @Matrix1x3 (bA, bB, bC), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol }

