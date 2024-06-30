module [
    Matrix2x3,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix2x3 := (F64, F64, F64, F64, F64, F64)

zeros : Matrix2x3
zeros = @Matrix2x3 (0, 0, 0, 0, 0, 0)

ones : Matrix2x3
ones = @Matrix2x3 (1, 1, 1, 1, 1, 1)

add : Matrix2x3, Matrix2x3 -> Matrix2x3
add = \@Matrix2x3 (aA, aB, aC, aD, aE, aF), @Matrix2x3 (bA, bB, bC, bD, bE, bF) ->
    @Matrix2x3 (aA + bA, aB + bB, aC + bC, aD + bD, aE + bE, aF + bF)

sub : Matrix2x3, Matrix2x3 -> Matrix2x3
sub = \@Matrix2x3 (aA, aB, aC, aD, aE, aF), @Matrix2x3 (bA, bB, bC, bD, bE, bF) ->
    @Matrix2x3 (aA - bA, aB - bB, aC - bC, aD - bD, aE - bE, aF - bF)

elementwiseMul : Matrix2x3, Matrix2x3 -> Matrix2x3
elementwiseMul = \@Matrix2x3 (aA, aB, aC, aD, aE, aF), @Matrix2x3 (bA, bB, bC, bD, bE, bF) ->
    @Matrix2x3 (aA * bA, aB * bB, aC * bC, aD * bD, aE * bE, aF * bF)

div : Matrix2x3, Matrix2x3 -> Matrix2x3
div = \@Matrix2x3 (aA, aB, aC, aD, aE, aF), @Matrix2x3 (bA, bB, bC, bD, bE, bF) ->
    @Matrix2x3 (aA / bA, aB / bB, aC / bC, aD / bD, aE / bE, aF / bF)

isApproxEq : Matrix2x3, Matrix2x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x3 (aA, aB, aC, aD, aE, aF), @Matrix2x3 (bA, bB, bC, bD, bE, bF), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol } && Num.isApproxEq aE bE { rtol, atol } && Num.isApproxEq aF bF { rtol, atol }
