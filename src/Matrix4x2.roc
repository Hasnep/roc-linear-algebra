module [
    Matrix4x2,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix4x2 := (F64, F64, F64, F64, F64, F64, F64, F64)

zeros : Matrix4x2
zeros = @Matrix4x2 (0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix4x2
ones = @Matrix4x2 (1, 1, 1, 1, 1, 1, 1, 1)

add : Matrix4x2, Matrix4x2 -> Matrix4x2
add = \@Matrix4x2 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix4x2 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix4x2 (aA + bA, aB + bB, aC + bC, aD + bD, aE + bE, aF + bF, aG + bG, aH + bH)

sub : Matrix4x2, Matrix4x2 -> Matrix4x2
sub = \@Matrix4x2 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix4x2 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix4x2 (aA - bA, aB - bB, aC - bC, aD - bD, aE - bE, aF - bF, aG - bG, aH - bH)

elementwiseMul : Matrix4x2, Matrix4x2 -> Matrix4x2
elementwiseMul = \@Matrix4x2 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix4x2 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix4x2 (aA * bA, aB * bB, aC * bC, aD * bD, aE * bE, aF * bF, aG * bG, aH * bH)

div : Matrix4x2, Matrix4x2 -> Matrix4x2
div = \@Matrix4x2 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix4x2 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix4x2 (aA / bA, aB / bB, aC / bC, aD / bD, aE / bE, aF / bF, aG / bG, aH / bH)

isApproxEq : Matrix4x2, Matrix4x2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix4x2 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix4x2 (bA, bB, bC, bD, bE, bF, bG, bH), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol } && Num.isApproxEq aE bE { rtol, atol } && Num.isApproxEq aF bF { rtol, atol } && Num.isApproxEq aG bG { rtol, atol } && Num.isApproxEq aH bH { rtol, atol }

