module [
    Matrix3x3,
    identity,
    zeros,
    ones,
    fromDiagonal,
    transpose,
    diagonal,
    determinant,
    invert,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector3

Matrix3x3 := (F64, F64, F64, F64, F64, F64, F64, F64, F64)

identity : Matrix3x3
identity = fromDiagonal (1, 1, 1)

zeros : Matrix3x3
zeros = @Matrix3x3 (0, 0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix3x3
ones = @Matrix3x3 (1, 1, 1, 1, 1, 1, 1, 1, 1)

fromDiagonal : Vector3.Vector3 -> Matrix3x3
fromDiagonal = \(a, e, i) ->
    @Matrix3x3 (a, 0, 0, 0, e, 0, 0, 0, i)

transpose : Matrix3x3 -> Matrix3x3
transpose = \@Matrix3x3 (a, b, c, d, e, f, g, h, i) ->
    @Matrix3x3 (a, d, g, b, e, h, c, f, i)

diagonal : Matrix3x3 -> Vector3.Vector3
diagonal = \@Matrix3x3 (a, _b, _c, _d, e, _f, _g, _h, i) -> (a, e, i)

expect
    out = diagonal (@Matrix3x3 (1, 0, 0, 0, 5, 0, 0, 0, 9))
    out |> Vector3.isApproxEq ((1, 5, 9)) {}

determinant : Matrix3x3 -> F64
determinant = \@Matrix3x3 (a, b, c, d, e, f, g, h, i) ->
    a * (e * i - h * f) - d * (b * i - h * c) + g * (b * f - e * c)

expect
    out = determinant (@Matrix3x3 (1, 0, 0, 0, 5, 0, 0, 0, 9))
    out |> Num.isApproxEq 45.0 {}

invert : Matrix3x3 -> Result Matrix3x3 [NonInvertible]
invert = \@Matrix3x3 (a, b, c, d, e, f, g, h, i) ->
    det = determinant (@Matrix3x3 (a, b, c, d, e, f, g, h, i))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok
            (
                @Matrix3x3 (
                    (e * i - h * f) / det,
                    (-b * i + h * c) / det,
                    (b * f - e * c) / det,
                    (-d * i + g * f) / det,
                    (a * i - g * c) / det,
                    (-a * f + d * c) / det,
                    (d * h - g * e) / det,
                    (-a * h + g * b) / det,
                    (a * e - d * b) / det,
                )
            )

expect
    outResult = invert (@Matrix3x3 (1, 0, 0, 0, 5, 0, 0, 0, 9))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix3x3 (1.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.1111111111111111)) {}
        Err NonInvertible -> Bool.false

add : Matrix3x3, Matrix3x3 -> Matrix3x3
add = \@Matrix3x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI), @Matrix3x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI) ->
    @Matrix3x3 (aA + bA, aB + bB, aC + bC, aD + bD, aE + bE, aF + bF, aG + bG, aH + bH, aI + bI)

sub : Matrix3x3, Matrix3x3 -> Matrix3x3
sub = \@Matrix3x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI), @Matrix3x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI) ->
    @Matrix3x3 (aA - bA, aB - bB, aC - bC, aD - bD, aE - bE, aF - bF, aG - bG, aH - bH, aI - bI)

elementwiseMul : Matrix3x3, Matrix3x3 -> Matrix3x3
elementwiseMul = \@Matrix3x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI), @Matrix3x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI) ->
    @Matrix3x3 (aA * bA, aB * bB, aC * bC, aD * bD, aE * bE, aF * bF, aG * bG, aH * bH, aI * bI)

div : Matrix3x3, Matrix3x3 -> Matrix3x3
div = \@Matrix3x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI), @Matrix3x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI) ->
    @Matrix3x3 (aA / bA, aB / bB, aC / bC, aD / bD, aE / bE, aF / bF, aG / bG, aH / bH, aI / bI)

isApproxEq : Matrix3x3, Matrix3x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix3x3 (aA, aB, aC, aD, aE, aF, aG, aH, aI), @Matrix3x3 (bA, bB, bC, bD, bE, bF, bG, bH, bI), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol } && Num.isApproxEq aE bE { rtol, atol } && Num.isApproxEq aF bF { rtol, atol } && Num.isApproxEq aG bG { rtol, atol } && Num.isApproxEq aH bH { rtol, atol } && Num.isApproxEq aI bI { rtol, atol }

