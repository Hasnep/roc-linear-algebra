module [
    Matrix3x2,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix3x2 := (F64, F64, F64, F64, F64, F64)

zeros : Matrix3x2
zeros = @Matrix3x2 (0, 0, 0, 0, 0, 0)

ones : Matrix3x2
ones = @Matrix3x2 (1, 1, 1, 1, 1, 1)

add : Matrix3x2, Matrix3x2 -> Matrix3x2
add = \@Matrix3x2 (aA, aB, aC, aD, aE, aF), @Matrix3x2 (bA, bB, bC, bD, bE, bF) ->
    @Matrix3x2 (aA + bA, aB + bB, aC + bC, aD + bD, aE + bE, aF + bF)

sub : Matrix3x2, Matrix3x2 -> Matrix3x2
sub = \@Matrix3x2 (aA, aB, aC, aD, aE, aF), @Matrix3x2 (bA, bB, bC, bD, bE, bF) ->
    @Matrix3x2 (aA - bA, aB - bB, aC - bC, aD - bD, aE - bE, aF - bF)

elementwiseMul : Matrix3x2, Matrix3x2 -> Matrix3x2
elementwiseMul = \@Matrix3x2 (aA, aB, aC, aD, aE, aF), @Matrix3x2 (bA, bB, bC, bD, bE, bF) ->
    @Matrix3x2 (aA * bA, aB * bB, aC * bC, aD * bD, aE * bE, aF * bF)

div : Matrix3x2, Matrix3x2 -> Matrix3x2
div = \@Matrix3x2 (aA, aB, aC, aD, aE, aF), @Matrix3x2 (bA, bB, bC, bD, bE, bF) ->
    @Matrix3x2 (aA / bA, aB / bB, aC / bC, aD / bD, aE / bE, aF / bF)

isApproxEq : Matrix3x2, Matrix3x2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix3x2 (aA, aB, aC, aD, aE, aF), @Matrix3x2 (bA, bB, bC, bD, bE, bF), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol } && Num.isApproxEq aE bE { rtol, atol } && Num.isApproxEq aF bF { rtol, atol }
