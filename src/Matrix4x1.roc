module [
    Matrix4x1,
    zeros,
    ones,
    fromVector,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector4

Matrix4x1 := (F64, F64, F64, F64)

zeros : Matrix4x1
zeros = @Matrix4x1 (0, 0, 0, 0)

ones : Matrix4x1
ones = @Matrix4x1 (1, 1, 1, 1)

fromVector : Vector4.Vector4 -> Matrix4x1
fromVector = \(x1, x2, x3, x4) ->
    @Matrix4x1 (x1, x2, x3, x4)

add : Matrix4x1, Matrix4x1 -> Matrix4x1
add = \@Matrix4x1 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1), @Matrix4x1 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1) ->
    @Matrix4x1 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a3ˏ1 + b3ˏ1, a4ˏ1 + b4ˏ1)

sub : Matrix4x1, Matrix4x1 -> Matrix4x1
sub = \@Matrix4x1 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1), @Matrix4x1 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1) ->
    @Matrix4x1 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a3ˏ1 - b3ˏ1, a4ˏ1 - b4ˏ1)

elementwiseMul : Matrix4x1, Matrix4x1 -> Matrix4x1
elementwiseMul = \@Matrix4x1 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1), @Matrix4x1 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1) ->
    @Matrix4x1 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a3ˏ1 * b3ˏ1, a4ˏ1 * b4ˏ1)

div : Matrix4x1, Matrix4x1 -> Matrix4x1
div = \@Matrix4x1 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1), @Matrix4x1 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1) ->
    @Matrix4x1 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a3ˏ1 / b3ˏ1, a4ˏ1 / b4ˏ1)

isApproxEq : Matrix4x1, Matrix4x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix4x1 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1), @Matrix4x1 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a3ˏ1 b3ˏ1 { rtol, atol } && Num.isApproxEq a4ˏ1 b4ˏ1 { rtol, atol }
