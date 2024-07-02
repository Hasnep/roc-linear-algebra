module [
    Matrix1x2,
    zeros,
    ones,
    fromVector,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector2

Matrix1x2 := (F64, F64)

zeros : Matrix1x2
zeros = @Matrix1x2 (0, 0)

ones : Matrix1x2
ones = @Matrix1x2 (1, 1)

fromVector : Vector2.Vector2 -> Matrix1x2
fromVector = \(x1, x2) ->
    @Matrix1x2 (x1, x2)

add : Matrix1x2, Matrix1x2 -> Matrix1x2
add = \@Matrix1x2 (a1ˏ1, a1ˏ2), @Matrix1x2 (b1ˏ1, b1ˏ2) ->
    @Matrix1x2 (a1ˏ1 + b1ˏ1, a1ˏ2 + b1ˏ2)

sub : Matrix1x2, Matrix1x2 -> Matrix1x2
sub = \@Matrix1x2 (a1ˏ1, a1ˏ2), @Matrix1x2 (b1ˏ1, b1ˏ2) ->
    @Matrix1x2 (a1ˏ1 - b1ˏ1, a1ˏ2 - b1ˏ2)

elementwiseMul : Matrix1x2, Matrix1x2 -> Matrix1x2
elementwiseMul = \@Matrix1x2 (a1ˏ1, a1ˏ2), @Matrix1x2 (b1ˏ1, b1ˏ2) ->
    @Matrix1x2 (a1ˏ1 * b1ˏ1, a1ˏ2 * b1ˏ2)

div : Matrix1x2, Matrix1x2 -> Matrix1x2
div = \@Matrix1x2 (a1ˏ1, a1ˏ2), @Matrix1x2 (b1ˏ1, b1ˏ2) ->
    @Matrix1x2 (a1ˏ1 / b1ˏ1, a1ˏ2 / b1ˏ2)

isApproxEq : Matrix1x2, Matrix1x2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x2 (a1ˏ1, a1ˏ2), @Matrix1x2 (b1ˏ1, b1ˏ2), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol }
