module [
    Matrix4x3,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix4x3 := (F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64)

zeros : Matrix4x3
zeros = @Matrix4x3 (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix4x3
ones = @Matrix4x3 (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

add : Matrix4x3, Matrix4x3 -> Matrix4x3
add = \@Matrix4x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL), @Matrix4x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL) ->
    @Matrix4x3 (aA + bA, aB + bB, aC + bC, aD + bD, aE + bE, aF + bF, aG + bG, aH + bH, aI + bI, aJ + bJ, aK + bK, aL + bL)

sub : Matrix4x3, Matrix4x3 -> Matrix4x3
sub = \@Matrix4x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL), @Matrix4x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL) ->
    @Matrix4x3 (aA - bA, aB - bB, aC - bC, aD - bD, aE - bE, aF - bF, aG - bG, aH - bH, aI - bI, aJ - bJ, aK - bK, aL - bL)

elementwiseMul : Matrix4x3, Matrix4x3 -> Matrix4x3
elementwiseMul = \@Matrix4x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL), @Matrix4x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL) ->
    @Matrix4x3 (aA * bA, aB * bB, aC * bC, aD * bD, aE * bE, aF * bF, aG * bG, aH * bH, aI * bI, aJ * bJ, aK * bK, aL * bL)

div : Matrix4x3, Matrix4x3 -> Matrix4x3
div = \@Matrix4x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL), @Matrix4x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL) ->
    @Matrix4x3 (aA / bA, aB / bB, aC / bC, aD / bD, aE / bE, aF / bF, aG / bG, aH / bH, aI / bI, aJ / bJ, aK / bK, aL / bL)

isApproxEq : Matrix4x3, Matrix4x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix4x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL), @Matrix4x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol } && Num.isApproxEq aE bE { rtol, atol } && Num.isApproxEq aF bF { rtol, atol } && Num.isApproxEq aG bG { rtol, atol } && Num.isApproxEq aH bH { rtol, atol } && Num.isApproxEq aI bI { rtol, atol } && Num.isApproxEq aJ bJ { rtol, atol } && Num.isApproxEq aK bK { rtol, atol } && Num.isApproxEq aL bL { rtol, atol }
