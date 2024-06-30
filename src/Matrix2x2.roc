module [
    Matrix2x2,
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

import Vector2

Matrix2x2 := (F64, F64, F64, F64)

identity : Matrix2x2
identity = fromDiagonal (1, 1)

zeros : Matrix2x2
zeros = @Matrix2x2 (0, 0, 0, 0)

ones : Matrix2x2
ones = @Matrix2x2 (1, 1, 1, 1)

fromDiagonal : Vector2.Vector2 -> Matrix2x2
fromDiagonal = \(a, d) ->
    @Matrix2x2 (a, 0, 0, d)

transpose : Matrix2x2 -> Matrix2x2
transpose = \@Matrix2x2 (a, b, c, d) ->
    @Matrix2x2 (a, c, b, d)

diagonal : Matrix2x2 -> Vector2.Vector2
diagonal = \@Matrix2x2 (a, _b, _c, d) -> (a, d)

expect
    out = diagonal (@Matrix2x2 (1, 0, 0, 4))
    out |> Vector2.isApproxEq ((1, 4)) {}

determinant : Matrix2x2 -> F64
determinant = \@Matrix2x2 (a, b, c, d) ->
    a * d - c * b

expect
    out = determinant (@Matrix2x2 (1, 0, 0, 4))
    out |> Num.isApproxEq 4.0 {}

invert : Matrix2x2 -> Result Matrix2x2 [NonInvertible]
invert = \@Matrix2x2 (a, b, c, d) ->
    det = determinant (@Matrix2x2 (a, b, c, d))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok
            (
                @Matrix2x2 (
                    d / det,
                    (-b) / det,
                    (-c) / det,
                    a / det,
                )
            )

expect
    outResult = invert (@Matrix2x2 (1, 0, 0, 4))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix2x2 (1.0, 0.0, 0.0, 0.25)) {}
        Err NonInvertible -> Bool.false

add : Matrix2x2, Matrix2x2 -> Matrix2x2
add = \@Matrix2x2 (aA, aB, aC, aD), @Matrix2x2 (bA, bB, bC, bD) ->
    @Matrix2x2 (aA + bA, aB + bB, aC + bC, aD + bD)

sub : Matrix2x2, Matrix2x2 -> Matrix2x2
sub = \@Matrix2x2 (aA, aB, aC, aD), @Matrix2x2 (bA, bB, bC, bD) ->
    @Matrix2x2 (aA - bA, aB - bB, aC - bC, aD - bD)

elementwiseMul : Matrix2x2, Matrix2x2 -> Matrix2x2
elementwiseMul = \@Matrix2x2 (aA, aB, aC, aD), @Matrix2x2 (bA, bB, bC, bD) ->
    @Matrix2x2 (aA * bA, aB * bB, aC * bC, aD * bD)

div : Matrix2x2, Matrix2x2 -> Matrix2x2
div = \@Matrix2x2 (aA, aB, aC, aD), @Matrix2x2 (bA, bB, bC, bD) ->
    @Matrix2x2 (aA / bA, aB / bB, aC / bC, aD / bD)

isApproxEq : Matrix2x2, Matrix2x2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x2 (aA, aB, aC, aD), @Matrix2x2 (bA, bB, bC, bD), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol } && Num.isApproxEq aB bB { rtol, atol } && Num.isApproxEq aC bC { rtol, atol } && Num.isApproxEq aD bD { rtol, atol }
