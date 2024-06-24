module [
    Matrix2x4,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix2x4 := (F64, F64, F64, F64, F64, F64, F64, F64)

zeros : Matrix2x4
zeros = @Matrix2x4 (0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix2x4
ones = @Matrix2x4 (1, 1, 1, 1, 1, 1, 1, 1)

add : Matrix2x4, Matrix2x4 -> Matrix2x4
add = \@Matrix2x4 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix2x4 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix2x4 (aA + bA, aB + bB, aC + bC, aD + bD, aE + bE, aF + bF, aG + bG, aH + bH)

sub : Matrix2x4, Matrix2x4 -> Matrix2x4
sub = \@Matrix2x4 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix2x4 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix2x4 (aA - bA, aB - bB, aC - bC, aD - bD, aE - bE, aF - bF, aG - bG, aH - bH)

elementwiseMul : Matrix2x4, Matrix2x4 -> Matrix2x4
elementwiseMul = \@Matrix2x4 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix2x4 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix2x4 (aA * bA, aB * bB, aC * bC, aD * bD, aE * bE, aF * bF, aG * bG, aH * bH)

div : Matrix2x4, Matrix2x4 -> Matrix2x4
div = \@Matrix2x4 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix2x4 (bA, bB, bC, bD, bE, bF, bG, bH) ->
    @Matrix2x4 (aA / bA, aB / bB, aC / bC, aD / bD, aE / bE, aF / bF, aG / bG, aH / bH)

isApproxEq : Matrix2x4, Matrix2x4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x4 (aA, aB, aC, aD, aE, aF, aG, aH), @Matrix2x4 (bA, bB, bC, bD, bE, bF, bG, bH), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol } && Num.isApproxEq aE bE { rtol, atol } && Num.isApproxEq aF bF { rtol, atol } && Num.isApproxEq aG bG { rtol, atol } && Num.isApproxEq aH bH { rtol, atol }

