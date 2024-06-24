module [
    Matrix4x4,
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

import Vector4

Matrix4x4 := (F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64)

identity : Matrix4x4
identity = fromDiagonal (1, 1, 1, 1)

zeros : Matrix4x4
zeros = @Matrix4x4 (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix4x4
ones = @Matrix4x4 (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

fromDiagonal : Vector4.Vector4 -> Matrix4x4
fromDiagonal = \(a, f, k, p) ->
    @Matrix4x4 (a, 0, 0, 0, 0, f, 0, 0, 0, 0, k, 0, 0, 0, 0, p)

transpose : Matrix4x4 -> Matrix4x4
transpose = \@Matrix4x4 (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p) ->
    @Matrix4x4 (a, e, i, m, b, f, j, n, c, g, k, o, d, h, l, p)

diagonal : Matrix4x4 -> Vector4.Vector4
diagonal = \@Matrix4x4 (a, _b, _c, _d, _e, f, _g, _h, _i, _j, k, _l, _m, _n, _o, p) -> (a, f, k, p)

expect
    out = diagonal (@Matrix4x4 (1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 11, 0, 0, 0, 0, 16))
    out |> Vector4.isApproxEq ((1, 6, 11, 16)) {}

determinant : Matrix4x4 -> F64
determinant = \@Matrix4x4 (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p) ->
    a * (f * (k * p - o * l) - j * (g * p - o * h) + n * (g * l - k * h)) - e * (b * (k * p - o * l) - j * (c * p - o * d) + n * (c * l - k * d)) + i * (b * (g * p - o * h) - f * (c * p - o * d) + n * (c * h - g * d)) - m * (b * (g * l - k * h) - f * (c * l - k * d) + j * (c * h - g * d))

expect
    out = determinant (@Matrix4x4 (1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 11, 0, 0, 0, 0, 16))
    out |> Num.isApproxEq 1056.0 {}

invert : Matrix4x4 -> Result Matrix4x4 [NonInvertible]
invert = \@Matrix4x4 (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p) ->
    det = determinant (@Matrix4x4 (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok
            (
                @Matrix4x4 (
                    (f * (k * p - o * l) - j * (g * p - o * h) + n * (g * l - k * h)) / det,
                    (-b * (k * p - o * l) + j * (c * p - o * d) - n * (c * l - k * d)) / det,
                    (b * (g * p - o * h) - f * (c * p - o * d) + n * (c * h - g * d)) / det,
                    (-b * (g * l - k * h) + f * (c * l - k * d) - j * (c * h - g * d)) / det,
                    (-e * (k * p - o * l) + i * (g * p - o * h) - m * (g * l - k * h)) / det,
                    (a * (k * p - o * l) - i * (c * p - o * d) + m * (c * l - k * d)) / det,
                    (-a * (g * p - o * h) + e * (c * p - o * d) - m * (c * h - g * d)) / det,
                    (a * (g * l - k * h) - e * (c * l - k * d) + i * (c * h - g * d)) / det,
                    (e * (j * p - n * l) - i * (f * p - n * h) + m * (f * l - j * h)) / det,
                    (-a * (j * p - n * l) + i * (b * p - n * d) - m * (b * l - j * d)) / det,
                    (a * (f * p - n * h) - e * (b * p - n * d) + m * (b * h - f * d)) / det,
                    (-a * (f * l - j * h) + e * (b * l - j * d) - i * (b * h - f * d)) / det,
                    (-e * (j * o - n * k) + i * (f * o - n * g) - m * (f * k - j * g)) / det,
                    (a * (j * o - n * k) - i * (b * o - n * c) + m * (b * k - j * c)) / det,
                    (-a * (f * o - n * g) + e * (b * o - n * c) - m * (b * g - f * c)) / det,
                    (a * (f * k - j * g) - e * (b * k - j * c) + i * (b * g - f * c)) / det,
                )
            )

expect
    outResult = invert (@Matrix4x4 (1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 11, 0, 0, 0, 0, 16))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix4x4 (1.0, 0.0, 0.0, 0.0, 0.0, 0.16666666666666666, 0.0, 0.0, 0.0, 0.0, 0.09090909090909091, 0.0, 0.0, 0.0, 0.0, 0.0625)) {}
        Err NonInvertible -> Bool.false

add : Matrix4x4, Matrix4x4 -> Matrix4x4
add = \@Matrix4x4 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP), @Matrix4x4 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL, bM, bN, bO, bP) ->
    @Matrix4x4 (aA + bA, aB + bB, aC + bC, aD + bD, aE + bE, aF + bF, aG + bG, aH + bH, aI + bI, aJ + bJ, aK + bK, aL + bL, aM + bM, aN + bN, aO + bO, aP + bP)

sub : Matrix4x4, Matrix4x4 -> Matrix4x4
sub = \@Matrix4x4 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP), @Matrix4x4 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL, bM, bN, bO, bP) ->
    @Matrix4x4 (aA - bA, aB - bB, aC - bC, aD - bD, aE - bE, aF - bF, aG - bG, aH - bH, aI - bI, aJ - bJ, aK - bK, aL - bL, aM - bM, aN - bN, aO - bO, aP - bP)

elementwiseMul : Matrix4x4, Matrix4x4 -> Matrix4x4
elementwiseMul = \@Matrix4x4 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP), @Matrix4x4 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL, bM, bN, bO, bP) ->
    @Matrix4x4 (aA * bA, aB * bB, aC * bC, aD * bD, aE * bE, aF * bF, aG * bG, aH * bH, aI * bI, aJ * bJ, aK * bK, aL * bL, aM * bM, aN * bN, aO * bO, aP * bP)

div : Matrix4x4, Matrix4x4 -> Matrix4x4
div = \@Matrix4x4 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP), @Matrix4x4 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL, bM, bN, bO, bP) ->
    @Matrix4x4 (aA / bA, aB / bB, aC / bC, aD / bD, aE / bE, aF / bF, aG / bG, aH / bH, aI / bI, aJ / bJ, aK / bK, aL / bL, aM / bM, aN / bN, aO / bO, aP / bP)

isApproxEq : Matrix4x4, Matrix4x4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix4x4 (aA, aB, aC, aD, aE, aF, aG, aH, aI, aJ, aK, aL, aM, aN, aO, aP), @Matrix4x4 (bA, bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL, bM, bN, bO, bP), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol } && Num.isApproxEq aE bE { rtol, atol } && Num.isApproxEq aF bF { rtol, atol } && Num.isApproxEq aG bG { rtol, atol } && Num.isApproxEq aH bH { rtol, atol } && Num.isApproxEq aI bI { rtol, atol } && Num.isApproxEq aJ bJ { rtol, atol } && Num.isApproxEq aK bK { rtol, atol } && Num.isApproxEq aL bL { rtol, atol } && Num.isApproxEq aM bM { rtol, atol } && Num.isApproxEq aN bN { rtol, atol } && Num.isApproxEq aO bO { rtol, atol } && Num.isApproxEq aP bP { rtol, atol }

