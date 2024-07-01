module [
    Matrix1x4,
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

Matrix1x4 := (F64, F64, F64, F64)

zeros : Matrix1x4
zeros = @Matrix1x4 (0, 0, 0, 0)

ones : Matrix1x4
ones = @Matrix1x4 (1, 1, 1, 1)

fromVector : Vector4.Vector4 -> Matrix1x4
fromVector = \(x1, x2, x3, x4) ->
    @Matrix1x4 (x1, x2, x3, x4)

add : Matrix1x4, Matrix1x4 -> Matrix1x4
add = \@Matrix1x4 (a1ˏ1, a1ˏ2, a1ˏ3, a1ˏ4), @Matrix1x4 (b1ˏ1, b1ˏ2, b1ˏ3, b1ˏ4) ->
    @Matrix1x4 (a1ˏ1 + b1ˏ1, a1ˏ2 + b1ˏ2, a1ˏ3 + b1ˏ3, a1ˏ4 + b1ˏ4)

sub : Matrix1x4, Matrix1x4 -> Matrix1x4
sub = \@Matrix1x4 (a1ˏ1, a1ˏ2, a1ˏ3, a1ˏ4), @Matrix1x4 (b1ˏ1, b1ˏ2, b1ˏ3, b1ˏ4) ->
    @Matrix1x4 (a1ˏ1 - b1ˏ1, a1ˏ2 - b1ˏ2, a1ˏ3 - b1ˏ3, a1ˏ4 - b1ˏ4)

elementwiseMul : Matrix1x4, Matrix1x4 -> Matrix1x4
elementwiseMul = \@Matrix1x4 (a1ˏ1, a1ˏ2, a1ˏ3, a1ˏ4), @Matrix1x4 (b1ˏ1, b1ˏ2, b1ˏ3, b1ˏ4) ->
    @Matrix1x4 (a1ˏ1 * b1ˏ1, a1ˏ2 * b1ˏ2, a1ˏ3 * b1ˏ3, a1ˏ4 * b1ˏ4)

div : Matrix1x4, Matrix1x4 -> Matrix1x4
div = \@Matrix1x4 (a1ˏ1, a1ˏ2, a1ˏ3, a1ˏ4), @Matrix1x4 (b1ˏ1, b1ˏ2, b1ˏ3, b1ˏ4) ->
    @Matrix1x4 (a1ˏ1 / b1ˏ1, a1ˏ2 / b1ˏ2, a1ˏ3 / b1ˏ3, a1ˏ4 / b1ˏ4)

isApproxEq : Matrix1x4, Matrix1x4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x4 (a1ˏ1, a1ˏ2, a1ˏ3, a1ˏ4), @Matrix1x4 (b1ˏ1, b1ˏ2, b1ˏ3, b1ˏ4), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol } && Num.isApproxEq a1ˏ4 b1ˏ4 { rtol, atol }
