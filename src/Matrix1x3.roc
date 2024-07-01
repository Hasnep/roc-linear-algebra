module [
    Matrix1x3,
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

Matrix1x3 := (F64, F64, F64)

zeros : Matrix1x3
zeros = @Matrix1x3 (0, 0, 0)

ones : Matrix1x3
ones = @Matrix1x3 (1, 1, 1)

fromVector : Vector3.Vector3 -> Matrix1x3
fromVector = \(x1, x2, x3) ->
    @Matrix1x3 (x1, x2, x3)

add : Matrix1x3, Matrix1x3 -> Matrix1x3
add = \@Matrix1x3 (a1ˏ1, a1ˏ2, a1ˏ3), @Matrix1x3 (b1ˏ1, b1ˏ2, b1ˏ3) ->
    @Matrix1x3 (a1ˏ1 + b1ˏ1, a1ˏ2 + b1ˏ2, a1ˏ3 + b1ˏ3)

sub : Matrix1x3, Matrix1x3 -> Matrix1x3
sub = \@Matrix1x3 (a1ˏ1, a1ˏ2, a1ˏ3), @Matrix1x3 (b1ˏ1, b1ˏ2, b1ˏ3) ->
    @Matrix1x3 (a1ˏ1 - b1ˏ1, a1ˏ2 - b1ˏ2, a1ˏ3 - b1ˏ3)

elementwiseMul : Matrix1x3, Matrix1x3 -> Matrix1x3
elementwiseMul = \@Matrix1x3 (a1ˏ1, a1ˏ2, a1ˏ3), @Matrix1x3 (b1ˏ1, b1ˏ2, b1ˏ3) ->
    @Matrix1x3 (a1ˏ1 * b1ˏ1, a1ˏ2 * b1ˏ2, a1ˏ3 * b1ˏ3)

div : Matrix1x3, Matrix1x3 -> Matrix1x3
div = \@Matrix1x3 (a1ˏ1, a1ˏ2, a1ˏ3), @Matrix1x3 (b1ˏ1, b1ˏ2, b1ˏ3) ->
    @Matrix1x3 (a1ˏ1 / b1ˏ1, a1ˏ2 / b1ˏ2, a1ˏ3 / b1ˏ3)

isApproxEq : Matrix1x3, Matrix1x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x3 (a1ˏ1, a1ˏ2, a1ˏ3), @Matrix1x3 (b1ˏ1, b1ˏ2, b1ˏ3), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol }
