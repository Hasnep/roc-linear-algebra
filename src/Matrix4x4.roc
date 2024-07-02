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
identity = fromDiagonal (diagonal ones)

zeros : Matrix4x4
zeros = @Matrix4x4 (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix4x4
ones = @Matrix4x4 (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

fromDiagonal : Vector4.Vector4 -> Matrix4x4
fromDiagonal = \(x1, x2, x3, x4) ->
    @Matrix4x4 (x1, 0, 0, 0, 0, x2, 0, 0, 0, 0, x3, 0, 0, 0, 0, x4)

transpose : Matrix4x4 -> Matrix4x4
transpose = \@Matrix4x4 (x1ˏ1, x2ˏ1, x3ˏ1, x4ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x4ˏ2, x1ˏ3, x2ˏ3, x3ˏ3, x4ˏ3, x1ˏ4, x2ˏ4, x3ˏ4, x4ˏ4) ->
    @Matrix4x4 (x1ˏ1, x1ˏ2, x1ˏ3, x1ˏ4, x2ˏ1, x2ˏ2, x2ˏ3, x2ˏ4, x3ˏ1, x3ˏ2, x3ˏ3, x3ˏ4, x4ˏ1, x4ˏ2, x4ˏ3, x4ˏ4)

diagonal : Matrix4x4 -> Vector4.Vector4
diagonal = \@Matrix4x4 (x1ˏ1, _x2ˏ1, _x3ˏ1, _x4ˏ1, _x1ˏ2, x2ˏ2, _x3ˏ2, _x4ˏ2, _x1ˏ3, _x2ˏ3, x3ˏ3, _x4ˏ3, _x1ˏ4, _x2ˏ4, _x3ˏ4, x4ˏ4) ->
    (x1ˏ1, x2ˏ2, x3ˏ3, x4ˏ4)

expect
    out = diagonal (@Matrix4x4 (1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 11, 0, 0, 0, 0, 16))
    out |> Vector4.isApproxEq ((1, 6, 11, 16)) {}

determinant : Matrix4x4 -> F64
determinant = \@Matrix4x4 (x1ˏ1, x2ˏ1, x3ˏ1, x4ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x4ˏ2, x1ˏ3, x2ˏ3, x3ˏ3, x4ˏ3, x1ˏ4, x2ˏ4, x3ˏ4, x4ˏ4) ->
    x1ˏ1 * (x2ˏ2 * (x3ˏ3 * x4ˏ4 - x3ˏ4 * x4ˏ3) - x2ˏ3 * (x3ˏ2 * x4ˏ4 - x3ˏ4 * x4ˏ2) + x2ˏ4 * (x3ˏ2 * x4ˏ3 - x3ˏ3 * x4ˏ2)) - x1ˏ2 * (x2ˏ1 * (x3ˏ3 * x4ˏ4 - x3ˏ4 * x4ˏ3) - x2ˏ3 * (x3ˏ1 * x4ˏ4 - x3ˏ4 * x4ˏ1) + x2ˏ4 * (x3ˏ1 * x4ˏ3 - x3ˏ3 * x4ˏ1)) + x1ˏ3 * (x2ˏ1 * (x3ˏ2 * x4ˏ4 - x3ˏ4 * x4ˏ2) - x2ˏ2 * (x3ˏ1 * x4ˏ4 - x3ˏ4 * x4ˏ1) + x2ˏ4 * (x3ˏ1 * x4ˏ2 - x3ˏ2 * x4ˏ1)) - x1ˏ4 * (x2ˏ1 * (x3ˏ2 * x4ˏ3 - x3ˏ3 * x4ˏ2) - x2ˏ2 * (x3ˏ1 * x4ˏ3 - x3ˏ3 * x4ˏ1) + x2ˏ3 * (x3ˏ1 * x4ˏ2 - x3ˏ2 * x4ˏ1))

expect
    out = determinant (@Matrix4x4 (1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 11, 0, 0, 0, 0, 16))
    out |> Num.isApproxEq 1056.0 {}

invert : Matrix4x4 -> Result Matrix4x4 [NonInvertible]
invert = \@Matrix4x4 (x1ˏ1, x2ˏ1, x3ˏ1, x4ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x4ˏ2, x1ˏ3, x2ˏ3, x3ˏ3, x4ˏ3, x1ˏ4, x2ˏ4, x3ˏ4, x4ˏ4) ->
    det = determinant (@Matrix4x4 (x1ˏ1, x2ˏ1, x3ˏ1, x4ˏ1, x1ˏ2, x2ˏ2, x3ˏ2, x4ˏ2, x1ˏ3, x2ˏ3, x3ˏ3, x4ˏ3, x1ˏ4, x2ˏ4, x3ˏ4, x4ˏ4))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok (@Matrix4x4 ((x2ˏ2 * (x3ˏ3 * x4ˏ4 - x3ˏ4 * x4ˏ3) - x2ˏ3 * (x3ˏ2 * x4ˏ4 - x3ˏ4 * x4ˏ2) + x2ˏ4 * (x3ˏ2 * x4ˏ3 - x3ˏ3 * x4ˏ2)) / det, (-x2ˏ1 * (x3ˏ3 * x4ˏ4 - x3ˏ4 * x4ˏ3) + x2ˏ3 * (x3ˏ1 * x4ˏ4 - x3ˏ4 * x4ˏ1) - x2ˏ4 * (x3ˏ1 * x4ˏ3 - x3ˏ3 * x4ˏ1)) / det, (x2ˏ1 * (x3ˏ2 * x4ˏ4 - x3ˏ4 * x4ˏ2) - x2ˏ2 * (x3ˏ1 * x4ˏ4 - x3ˏ4 * x4ˏ1) + x2ˏ4 * (x3ˏ1 * x4ˏ2 - x3ˏ2 * x4ˏ1)) / det, (-x2ˏ1 * (x3ˏ2 * x4ˏ3 - x3ˏ3 * x4ˏ2) + x2ˏ2 * (x3ˏ1 * x4ˏ3 - x3ˏ3 * x4ˏ1) - x2ˏ3 * (x3ˏ1 * x4ˏ2 - x3ˏ2 * x4ˏ1)) / det, (-x1ˏ2 * (x3ˏ3 * x4ˏ4 - x3ˏ4 * x4ˏ3) + x1ˏ3 * (x3ˏ2 * x4ˏ4 - x3ˏ4 * x4ˏ2) - x1ˏ4 * (x3ˏ2 * x4ˏ3 - x3ˏ3 * x4ˏ2)) / det, (x1ˏ1 * (x3ˏ3 * x4ˏ4 - x3ˏ4 * x4ˏ3) - x1ˏ3 * (x3ˏ1 * x4ˏ4 - x3ˏ4 * x4ˏ1) + x1ˏ4 * (x3ˏ1 * x4ˏ3 - x3ˏ3 * x4ˏ1)) / det, (-x1ˏ1 * (x3ˏ2 * x4ˏ4 - x3ˏ4 * x4ˏ2) + x1ˏ2 * (x3ˏ1 * x4ˏ4 - x3ˏ4 * x4ˏ1) - x1ˏ4 * (x3ˏ1 * x4ˏ2 - x3ˏ2 * x4ˏ1)) / det, (x1ˏ1 * (x3ˏ2 * x4ˏ3 - x3ˏ3 * x4ˏ2) - x1ˏ2 * (x3ˏ1 * x4ˏ3 - x3ˏ3 * x4ˏ1) + x1ˏ3 * (x3ˏ1 * x4ˏ2 - x3ˏ2 * x4ˏ1)) / det, (x1ˏ2 * (x2ˏ3 * x4ˏ4 - x2ˏ4 * x4ˏ3) - x1ˏ3 * (x2ˏ2 * x4ˏ4 - x2ˏ4 * x4ˏ2) + x1ˏ4 * (x2ˏ2 * x4ˏ3 - x2ˏ3 * x4ˏ2)) / det, (-x1ˏ1 * (x2ˏ3 * x4ˏ4 - x2ˏ4 * x4ˏ3) + x1ˏ3 * (x2ˏ1 * x4ˏ4 - x2ˏ4 * x4ˏ1) - x1ˏ4 * (x2ˏ1 * x4ˏ3 - x2ˏ3 * x4ˏ1)) / det, (x1ˏ1 * (x2ˏ2 * x4ˏ4 - x2ˏ4 * x4ˏ2) - x1ˏ2 * (x2ˏ1 * x4ˏ4 - x2ˏ4 * x4ˏ1) + x1ˏ4 * (x2ˏ1 * x4ˏ2 - x2ˏ2 * x4ˏ1)) / det, (-x1ˏ1 * (x2ˏ2 * x4ˏ3 - x2ˏ3 * x4ˏ2) + x1ˏ2 * (x2ˏ1 * x4ˏ3 - x2ˏ3 * x4ˏ1) - x1ˏ3 * (x2ˏ1 * x4ˏ2 - x2ˏ2 * x4ˏ1)) / det, (-x1ˏ2 * (x2ˏ3 * x3ˏ4 - x2ˏ4 * x3ˏ3) + x1ˏ3 * (x2ˏ2 * x3ˏ4 - x2ˏ4 * x3ˏ2) - x1ˏ4 * (x2ˏ2 * x3ˏ3 - x2ˏ3 * x3ˏ2)) / det, (x1ˏ1 * (x2ˏ3 * x3ˏ4 - x2ˏ4 * x3ˏ3) - x1ˏ3 * (x2ˏ1 * x3ˏ4 - x2ˏ4 * x3ˏ1) + x1ˏ4 * (x2ˏ1 * x3ˏ3 - x2ˏ3 * x3ˏ1)) / det, (-x1ˏ1 * (x2ˏ2 * x3ˏ4 - x2ˏ4 * x3ˏ2) + x1ˏ2 * (x2ˏ1 * x3ˏ4 - x2ˏ4 * x3ˏ1) - x1ˏ4 * (x2ˏ1 * x3ˏ2 - x2ˏ2 * x3ˏ1)) / det, (x1ˏ1 * (x2ˏ2 * x3ˏ3 - x2ˏ3 * x3ˏ2) - x1ˏ2 * (x2ˏ1 * x3ˏ3 - x2ˏ3 * x3ˏ1) + x1ˏ3 * (x2ˏ1 * x3ˏ2 - x2ˏ2 * x3ˏ1)) / det))

expect
    outResult = invert (@Matrix4x4 (1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 11, 0, 0, 0, 0, 16))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix4x4 (1.0, 0.0, 0.0, 0.0, 0.0, 0.16666666666666666, 0.0, 0.0, 0.0, 0.0, 0.09090909090909091, 0.0, 0.0, 0.0, 0.0, 0.0625)) {}
        Err NonInvertible -> Bool.false

add : Matrix4x4, Matrix4x4 -> Matrix4x4
add = \@Matrix4x4 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3, a1ˏ4, a2ˏ4, a3ˏ4, a4ˏ4), @Matrix4x4 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3, b1ˏ4, b2ˏ4, b3ˏ4, b4ˏ4) ->
    @Matrix4x4 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a3ˏ1 + b3ˏ1, a4ˏ1 + b4ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2, a3ˏ2 + b3ˏ2, a4ˏ2 + b4ˏ2, a1ˏ3 + b1ˏ3, a2ˏ3 + b2ˏ3, a3ˏ3 + b3ˏ3, a4ˏ3 + b4ˏ3, a1ˏ4 + b1ˏ4, a2ˏ4 + b2ˏ4, a3ˏ4 + b3ˏ4, a4ˏ4 + b4ˏ4)

sub : Matrix4x4, Matrix4x4 -> Matrix4x4
sub = \@Matrix4x4 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3, a1ˏ4, a2ˏ4, a3ˏ4, a4ˏ4), @Matrix4x4 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3, b1ˏ4, b2ˏ4, b3ˏ4, b4ˏ4) ->
    @Matrix4x4 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a3ˏ1 - b3ˏ1, a4ˏ1 - b4ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2, a3ˏ2 - b3ˏ2, a4ˏ2 - b4ˏ2, a1ˏ3 - b1ˏ3, a2ˏ3 - b2ˏ3, a3ˏ3 - b3ˏ3, a4ˏ3 - b4ˏ3, a1ˏ4 - b1ˏ4, a2ˏ4 - b2ˏ4, a3ˏ4 - b3ˏ4, a4ˏ4 - b4ˏ4)

elementwiseMul : Matrix4x4, Matrix4x4 -> Matrix4x4
elementwiseMul = \@Matrix4x4 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3, a1ˏ4, a2ˏ4, a3ˏ4, a4ˏ4), @Matrix4x4 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3, b1ˏ4, b2ˏ4, b3ˏ4, b4ˏ4) ->
    @Matrix4x4 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a3ˏ1 * b3ˏ1, a4ˏ1 * b4ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2, a3ˏ2 * b3ˏ2, a4ˏ2 * b4ˏ2, a1ˏ3 * b1ˏ3, a2ˏ3 * b2ˏ3, a3ˏ3 * b3ˏ3, a4ˏ3 * b4ˏ3, a1ˏ4 * b1ˏ4, a2ˏ4 * b2ˏ4, a3ˏ4 * b3ˏ4, a4ˏ4 * b4ˏ4)

div : Matrix4x4, Matrix4x4 -> Matrix4x4
div = \@Matrix4x4 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3, a1ˏ4, a2ˏ4, a3ˏ4, a4ˏ4), @Matrix4x4 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3, b1ˏ4, b2ˏ4, b3ˏ4, b4ˏ4) ->
    @Matrix4x4 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a3ˏ1 / b3ˏ1, a4ˏ1 / b4ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2, a3ˏ2 / b3ˏ2, a4ˏ2 / b4ˏ2, a1ˏ3 / b1ˏ3, a2ˏ3 / b2ˏ3, a3ˏ3 / b3ˏ3, a4ˏ3 / b4ˏ3, a1ˏ4 / b1ˏ4, a2ˏ4 / b2ˏ4, a3ˏ4 / b3ˏ4, a4ˏ4 / b4ˏ4)

isApproxEq : Matrix4x4, Matrix4x4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix4x4 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3, a1ˏ4, a2ˏ4, a3ˏ4, a4ˏ4), @Matrix4x4 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3, b1ˏ4, b2ˏ4, b3ˏ4, b4ˏ4), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a3ˏ1 b3ˏ1 { rtol, atol } && Num.isApproxEq a4ˏ1 b4ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol } && Num.isApproxEq a3ˏ2 b3ˏ2 { rtol, atol } && Num.isApproxEq a4ˏ2 b4ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol } && Num.isApproxEq a2ˏ3 b2ˏ3 { rtol, atol } && Num.isApproxEq a3ˏ3 b3ˏ3 { rtol, atol } && Num.isApproxEq a4ˏ3 b4ˏ3 { rtol, atol } && Num.isApproxEq a1ˏ4 b1ˏ4 { rtol, atol } && Num.isApproxEq a2ˏ4 b2ˏ4 { rtol, atol } && Num.isApproxEq a3ˏ4 b3ˏ4 { rtol, atol } && Num.isApproxEq a4ˏ4 b4ˏ4 { rtol, atol }
