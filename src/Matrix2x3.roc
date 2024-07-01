module [
    Matrix2x3,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix2x3 := (F64, F64, F64, F64, F64, F64)

zeros : Matrix2x3
zeros = @Matrix2x3 (0, 0, 0, 0, 0, 0)

ones : Matrix2x3
ones = @Matrix2x3 (1, 1, 1, 1, 1, 1)

add : Matrix2x3, Matrix2x3 -> Matrix2x3
add = \@Matrix2x3 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3), @Matrix2x3 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3) ->
    @Matrix2x3 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2, a1ˏ3 + b1ˏ3, a2ˏ3 + b2ˏ3)

sub : Matrix2x3, Matrix2x3 -> Matrix2x3
sub = \@Matrix2x3 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3), @Matrix2x3 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3) ->
    @Matrix2x3 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2, a1ˏ3 - b1ˏ3, a2ˏ3 - b2ˏ3)

elementwiseMul : Matrix2x3, Matrix2x3 -> Matrix2x3
elementwiseMul = \@Matrix2x3 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3), @Matrix2x3 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3) ->
    @Matrix2x3 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2, a1ˏ3 * b1ˏ3, a2ˏ3 * b2ˏ3)

div : Matrix2x3, Matrix2x3 -> Matrix2x3
div = \@Matrix2x3 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3), @Matrix2x3 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3) ->
    @Matrix2x3 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2, a1ˏ3 / b1ˏ3, a2ˏ3 / b2ˏ3)

isApproxEq : Matrix2x3, Matrix2x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x3 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3), @Matrix2x3 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol } && Num.isApproxEq a2ˏ3 b2ˏ3 { rtol, atol }
