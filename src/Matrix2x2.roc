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
identity = fromDiagonal (diagonal ones)

zeros : Matrix2x2
zeros = @Matrix2x2 (0, 0, 0, 0)

ones : Matrix2x2
ones = @Matrix2x2 (1, 1, 1, 1)

fromDiagonal : Vector2.Vector2 -> Matrix2x2
fromDiagonal = \(x1, x2) ->
    @Matrix2x2 (x1, 0, 0, x2)

transpose : Matrix2x2 -> Matrix2x2
transpose = \@Matrix2x2 (x1ˏ1, x2ˏ1, x1ˏ2, x2ˏ2) ->
    @Matrix2x2 (x1ˏ1, x1ˏ2, x2ˏ1, x2ˏ2)

diagonal : Matrix2x2 -> Vector2.Vector2
diagonal = \@Matrix2x2 (x1ˏ1, _x2ˏ1, _x1ˏ2, x2ˏ2) ->
    (x1ˏ1, x2ˏ2)

expect
    out = diagonal (@Matrix2x2 (1, 0, 0, 4))
    out |> Vector2.isApproxEq ((1, 4)) {}

determinant : Matrix2x2 -> F64
determinant = \@Matrix2x2 (x1ˏ1, x2ˏ1, x1ˏ2, x2ˏ2) ->
    x1ˏ1 * x2ˏ2 - x1ˏ2 * x2ˏ1

expect
    out = determinant (@Matrix2x2 (1, 0, 0, 4))
    out |> Num.isApproxEq 4.0 {}

invert : Matrix2x2 -> Result Matrix2x2 [NonInvertible]
invert = \@Matrix2x2 (x1ˏ1, x2ˏ1, x1ˏ2, x2ˏ2) ->
    det = determinant (@Matrix2x2 (x1ˏ1, x2ˏ1, x1ˏ2, x2ˏ2))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok (@Matrix2x2 (x2ˏ2 / det, (-x2ˏ1) / det, (-x1ˏ2) / det, x1ˏ1 / det))

expect
    outResult = invert (@Matrix2x2 (1, 0, 0, 4))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix2x2 (1.0, 0.0, 0.0, 0.25)) {}
        Err NonInvertible -> Bool.false

add : Matrix2x2, Matrix2x2 -> Matrix2x2
add = \@Matrix2x2 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2), @Matrix2x2 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2) ->
    @Matrix2x2 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2)

sub : Matrix2x2, Matrix2x2 -> Matrix2x2
sub = \@Matrix2x2 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2), @Matrix2x2 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2) ->
    @Matrix2x2 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2)

elementwiseMul : Matrix2x2, Matrix2x2 -> Matrix2x2
elementwiseMul = \@Matrix2x2 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2), @Matrix2x2 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2) ->
    @Matrix2x2 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2)

div : Matrix2x2, Matrix2x2 -> Matrix2x2
div = \@Matrix2x2 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2), @Matrix2x2 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2) ->
    @Matrix2x2 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2)

isApproxEq : Matrix2x2, Matrix2x2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x2 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2), @Matrix2x2 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol }
