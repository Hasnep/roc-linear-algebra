module [
    Matrix3x1,
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

Matrix3x1 := (F64, F64, F64)

zeros : Matrix3x1
zeros = @Matrix3x1 (0, 0, 0)

ones : Matrix3x1
ones = @Matrix3x1 (1, 1, 1)

fromVector : Vector3.Vector3 -> Matrix3x1
fromVector = \(a, b, c) ->
    @Matrix3x1 (a, b, c)

add : Matrix3x1, Matrix3x1 -> Matrix3x1
add = \@Matrix3x1 (aA, aB, aC), @Matrix3x1 (bA, bB, bC) ->
    @Matrix3x1 (aA + bA, aB + bB, aC + bC)

sub : Matrix3x1, Matrix3x1 -> Matrix3x1
sub = \@Matrix3x1 (aA, aB, aC), @Matrix3x1 (bA, bB, bC) ->
    @Matrix3x1 (aA - bA, aB - bB, aC - bC)

elementwiseMul : Matrix3x1, Matrix3x1 -> Matrix3x1
elementwiseMul = \@Matrix3x1 (aA, aB, aC), @Matrix3x1 (bA, bB, bC) ->
    @Matrix3x1 (aA * bA, aB * bB, aC * bC)

div : Matrix3x1, Matrix3x1 -> Matrix3x1
div = \@Matrix3x1 (aA, aB, aC), @Matrix3x1 (bA, bB, bC) ->
    @Matrix3x1 (aA / bA, aB / bB, aC / bC)

isApproxEq : Matrix3x1, Matrix3x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix3x1 (aA, aB, aC), @Matrix3x1 (bA, bB, bC), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol }

