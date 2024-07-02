module [
    Matrix2x1,
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

Matrix2x1 := (F64, F64)

zeros : Matrix2x1
zeros = @Matrix2x1 (0, 0)

ones : Matrix2x1
ones = @Matrix2x1 (1, 1)

fromVector : Vector2.Vector2 -> Matrix2x1
fromVector = \(x1, x2) ->
    @Matrix2x1 (x1, x2)

add : Matrix2x1, Matrix2x1 -> Matrix2x1
add = \@Matrix2x1 (a1ˏ1, a2ˏ1), @Matrix2x1 (b1ˏ1, b2ˏ1) ->
    @Matrix2x1 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1)

sub : Matrix2x1, Matrix2x1 -> Matrix2x1
sub = \@Matrix2x1 (a1ˏ1, a2ˏ1), @Matrix2x1 (b1ˏ1, b2ˏ1) ->
    @Matrix2x1 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1)

elementwiseMul : Matrix2x1, Matrix2x1 -> Matrix2x1
elementwiseMul = \@Matrix2x1 (a1ˏ1, a2ˏ1), @Matrix2x1 (b1ˏ1, b2ˏ1) ->
    @Matrix2x1 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1)

div : Matrix2x1, Matrix2x1 -> Matrix2x1
div = \@Matrix2x1 (a1ˏ1, a2ˏ1), @Matrix2x1 (b1ˏ1, b2ˏ1) ->
    @Matrix2x1 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1)

isApproxEq : Matrix2x1, Matrix2x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x1 (a1ˏ1, a2ˏ1), @Matrix2x1 (b1ˏ1, b2ˏ1), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol }
