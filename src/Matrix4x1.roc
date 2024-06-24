module [
    Matrix4x1,
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

Matrix4x1 := (F64, F64, F64, F64)

zeros : Matrix4x1
zeros = @Matrix4x1 (0, 0, 0, 0)

ones : Matrix4x1
ones = @Matrix4x1 (1, 1, 1, 1)

fromVector : Vector4.Vector4 -> Matrix4x1
fromVector = \(a, b, c, d) ->
    @Matrix4x1 (a, b, c, d)

add : Matrix4x1, Matrix4x1 -> Matrix4x1
add = \@Matrix4x1 (aA, aB, aC, aD), @Matrix4x1 (bA, bB, bC, bD) ->
    @Matrix4x1 (aA + bA, aB + bB, aC + bC, aD + bD)

sub : Matrix4x1, Matrix4x1 -> Matrix4x1
sub = \@Matrix4x1 (aA, aB, aC, aD), @Matrix4x1 (bA, bB, bC, bD) ->
    @Matrix4x1 (aA - bA, aB - bB, aC - bC, aD - bD)

elementwiseMul : Matrix4x1, Matrix4x1 -> Matrix4x1
elementwiseMul = \@Matrix4x1 (aA, aB, aC, aD), @Matrix4x1 (bA, bB, bC, bD) ->
    @Matrix4x1 (aA * bA, aB * bB, aC * bC, aD * bD)

div : Matrix4x1, Matrix4x1 -> Matrix4x1
div = \@Matrix4x1 (aA, aB, aC, aD), @Matrix4x1 (bA, bB, bC, bD) ->
    @Matrix4x1 (aA / bA, aB / bB, aC / bC, aD / bD)

isApproxEq : Matrix4x1, Matrix4x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix4x1 (aA, aB, aC, aD), @Matrix4x1 (bA, bB, bC, bD), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol }

