module [
    Matrix1x4,
    zeros,
    ones,
    fromVector,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector4

Matrix1x4 := (F64, F64, F64, F64)

zeros : Matrix1x4
zeros = @Matrix1x4 (0, 0, 0, 0)

ones : Matrix1x4
ones = @Matrix1x4 (1, 1, 1, 1)

fromVector : Vector4.Vector4 -> Matrix1x4
fromVector = \(a, b, c, d) ->
    @Matrix1x4 (a, b, c, d)

add : Matrix1x4, Matrix1x4 -> Matrix1x4
add = \@Matrix1x4 (aA, aB, aC, aD), @Matrix1x4 (bA, bB, bC, bD) ->
    @Matrix1x4 (aA + bA, aB + bB, aC + bC, aD + bD)

sub : Matrix1x4, Matrix1x4 -> Matrix1x4
sub = \@Matrix1x4 (aA, aB, aC, aD), @Matrix1x4 (bA, bB, bC, bD) ->
    @Matrix1x4 (aA - bA, aB - bB, aC - bC, aD - bD)

elementwiseMul : Matrix1x4, Matrix1x4 -> Matrix1x4
elementwiseMul = \@Matrix1x4 (aA, aB, aC, aD), @Matrix1x4 (bA, bB, bC, bD) ->
    @Matrix1x4 (aA * bA, aB * bB, aC * bC, aD * bD)

div : Matrix1x4, Matrix1x4 -> Matrix1x4
div = \@Matrix1x4 (aA, aB, aC, aD), @Matrix1x4 (bA, bB, bC, bD) ->
    @Matrix1x4 (aA / bA, aB / bB, aC / bC, aD / bD)

isApproxEq : Matrix1x4, Matrix1x4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x4 (aA, aB, aC, aD), @Matrix1x4 (bA, bB, bC, bD), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol }
