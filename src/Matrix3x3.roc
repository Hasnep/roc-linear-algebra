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
identity = fromDiagonal (diagonal ones)

zeros : Matrix3x3
zeros = @Matrix3x3 (0, 0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix3x3
ones = @Matrix3x3 (1, 1, 1, 1, 1, 1, 1, 1, 1)

fromDiagonal : Vector3.Vector3 -> Matrix3x3
fromDiagonal = \(x1, x2, x3) ->
    @Matrix3x3 (x1, 0, 0, 0, x2, 0, 0, 0, x3)

transpose : Matrix3x3 -> Matrix3x3
transpose = \@Matrix3x3 (x1ˏ1, x2ˏ1, x3ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x1ˏ3, x2ˏ3, x3ˏ3) ->
    @Matrix3x3 (x1ˏ1, x1ˏ2, x1ˏ3, x2ˏ1, x2ˏ2, x2ˏ3, x3ˏ1, x3ˏ2, x3ˏ3)

diagonal : Matrix3x3 -> Vector3.Vector3
diagonal = \@Matrix3x3 (x1ˏ1, _x2ˏ1, _x3ˏ1, _x1ˏ2, x2ˏ2, _x3ˏ2, _x1ˏ3, _x2ˏ3, x3ˏ3) ->
    (x1ˏ1, x2ˏ2, x3ˏ3)

expect
    out = diagonal (@Matrix3x3 (1, 0, 0, 0, 5, 0, 0, 0, 9))
    out |> Vector3.isApproxEq ((1, 5, 9)) {}

determinant : Matrix3x3 -> F64
determinant = \@Matrix3x3 (x1ˏ1, x2ˏ1, x3ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x1ˏ3, x2ˏ3, x3ˏ3) ->
    x1ˏ1 * (x2ˏ2 * x3ˏ3 - x2ˏ3 * x3ˏ2) - x1ˏ2 * (x2ˏ1 * x3ˏ3 - x2ˏ3 * x3ˏ1) + x1ˏ3 * (x2ˏ1 * x3ˏ2 - x2ˏ2 * x3ˏ1)

expect
    out = determinant (@Matrix3x3 (1, 0, 0, 0, 5, 0, 0, 0, 9))
    out |> Num.isApproxEq 45.0 {}

invert : Matrix3x3 -> Result Matrix3x3 [NonInvertible]
invert = \@Matrix3x3 (x1ˏ1, x2ˏ1, x3ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x1ˏ3, x2ˏ3, x3ˏ3) ->
    det = determinant (@Matrix3x3 (x1ˏ1, x2ˏ1, x3ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x1ˏ3, x2ˏ3, x3ˏ3))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok (@Matrix3x3 ((x2ˏ2 * x3ˏ3 - x2ˏ3 * x3ˏ2) / det, (-x2ˏ1 * x3ˏ3 + x2ˏ3 * x3ˏ1) / det, (x2ˏ1 * x3ˏ2 - x2ˏ2 * x3ˏ1) / det, (-x1ˏ2 * x3ˏ3 + x1ˏ3 * x3ˏ2) / det, (x1ˏ1 * x3ˏ3 - x1ˏ3 * x3ˏ1) / det, (-x1ˏ1 * x3ˏ2 + x1ˏ2 * x3ˏ1) / det, (x1ˏ2 * x2ˏ3 - x1ˏ3 * x2ˏ2) / det, (-x1ˏ1 * x2ˏ3 + x1ˏ3 * x2ˏ1) / det, (x1ˏ1 * x2ˏ2 - x1ˏ2 * x2ˏ1) / det))

expect
    outResult = invert (@Matrix3x3 (1, 0, 0, 0, 5, 0, 0, 0, 9))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix3x3 (1.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.1111111111111111)) {}
        Err NonInvertible -> Bool.false

add : Matrix3x3, Matrix3x3 -> Matrix3x3
add = \@Matrix3x3 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3), @Matrix3x3 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3) ->
    @Matrix3x3 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a3ˏ1 + b3ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2, a3ˏ2 + b3ˏ2, a1ˏ3 + b1ˏ3, a2ˏ3 + b2ˏ3, a3ˏ3 + b3ˏ3)

sub : Matrix3x3, Matrix3x3 -> Matrix3x3
sub = \@Matrix3x3 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3), @Matrix3x3 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3) ->
    @Matrix3x3 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a3ˏ1 - b3ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2, a3ˏ2 - b3ˏ2, a1ˏ3 - b1ˏ3, a2ˏ3 - b2ˏ3, a3ˏ3 - b3ˏ3)

elementwiseMul : Matrix3x3, Matrix3x3 -> Matrix3x3
elementwiseMul = \@Matrix3x3 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3), @Matrix3x3 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3) ->
    @Matrix3x3 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a3ˏ1 * b3ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2, a3ˏ2 * b3ˏ2, a1ˏ3 * b1ˏ3, a2ˏ3 * b2ˏ3, a3ˏ3 * b3ˏ3)

div : Matrix3x3, Matrix3x3 -> Matrix3x3
div = \@Matrix3x3 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3), @Matrix3x3 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3) ->
    @Matrix3x3 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a3ˏ1 / b3ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2, a3ˏ2 / b3ˏ2, a1ˏ3 / b1ˏ3, a2ˏ3 / b2ˏ3, a3ˏ3 / b3ˏ3)

isApproxEq : Matrix3x3, Matrix3x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix3x3 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3), @Matrix3x3 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a3ˏ1 b3ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol } && Num.isApproxEq a3ˏ2 b3ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol } && Num.isApproxEq a2ˏ3 b2ˏ3 { rtol, atol } && Num.isApproxEq a3ˏ3 b3ˏ3 { rtol, atol }
