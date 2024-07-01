module [
    Matrix3x1,
    zeros,
    ones,
    fromVector,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector3

Matrix3x1 := (F64, F64, F64)

zeros : Matrix3x1
zeros = @Matrix3x1 (0, 0, 0)

ones : Matrix3x1
ones = @Matrix3x1 (1, 1, 1)

fromVector : Vector3.Vector3 -> Matrix3x1
fromVector = \(x1, x2, x3) ->
    @Matrix3x1 (x1, x2, x3)

add : Matrix3x1, Matrix3x1 -> Matrix3x1
add = \@Matrix3x1 (a1ˏ1, a2ˏ1, a3ˏ1), @Matrix3x1 (b1ˏ1, b2ˏ1, b3ˏ1) ->
    @Matrix3x1 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a3ˏ1 + b3ˏ1)

sub : Matrix3x1, Matrix3x1 -> Matrix3x1
sub = \@Matrix3x1 (a1ˏ1, a2ˏ1, a3ˏ1), @Matrix3x1 (b1ˏ1, b2ˏ1, b3ˏ1) ->
    @Matrix3x1 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a3ˏ1 - b3ˏ1)

elementwiseMul : Matrix3x1, Matrix3x1 -> Matrix3x1
elementwiseMul = \@Matrix3x1 (a1ˏ1, a2ˏ1, a3ˏ1), @Matrix3x1 (b1ˏ1, b2ˏ1, b3ˏ1) ->
    @Matrix3x1 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a3ˏ1 * b3ˏ1)

div : Matrix3x1, Matrix3x1 -> Matrix3x1
div = \@Matrix3x1 (a1ˏ1, a2ˏ1, a3ˏ1), @Matrix3x1 (b1ˏ1, b2ˏ1, b3ˏ1) ->
    @Matrix3x1 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a3ˏ1 / b3ˏ1)

isApproxEq : Matrix3x1, Matrix3x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix3x1 (a1ˏ1, a2ˏ1, a3ˏ1), @Matrix3x1 (b1ˏ1, b2ˏ1, b3ˏ1), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a3ˏ1 b3ˏ1 { rtol, atol }
