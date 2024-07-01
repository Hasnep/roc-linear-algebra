module [
    Matrix2x4,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix2x4 := (F64, F64, F64, F64, F64, F64, F64, F64)

zeros : Matrix2x4
zeros = @Matrix2x4 (0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix2x4
ones = @Matrix2x4 (1, 1, 1, 1, 1, 1, 1, 1)

add : Matrix2x4, Matrix2x4 -> Matrix2x4
add = \@Matrix2x4 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3, a1ˏ4, a2ˏ4), @Matrix2x4 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3, b1ˏ4, b2ˏ4) ->
    @Matrix2x4 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2, a1ˏ3 + b1ˏ3, a2ˏ3 + b2ˏ3, a1ˏ4 + b1ˏ4, a2ˏ4 + b2ˏ4)

sub : Matrix2x4, Matrix2x4 -> Matrix2x4
sub = \@Matrix2x4 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3, a1ˏ4, a2ˏ4), @Matrix2x4 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3, b1ˏ4, b2ˏ4) ->
    @Matrix2x4 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2, a1ˏ3 - b1ˏ3, a2ˏ3 - b2ˏ3, a1ˏ4 - b1ˏ4, a2ˏ4 - b2ˏ4)

elementwiseMul : Matrix2x4, Matrix2x4 -> Matrix2x4
elementwiseMul = \@Matrix2x4 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3, a1ˏ4, a2ˏ4), @Matrix2x4 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3, b1ˏ4, b2ˏ4) ->
    @Matrix2x4 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2, a1ˏ3 * b1ˏ3, a2ˏ3 * b2ˏ3, a1ˏ4 * b1ˏ4, a2ˏ4 * b2ˏ4)

div : Matrix2x4, Matrix2x4 -> Matrix2x4
div = \@Matrix2x4 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3, a1ˏ4, a2ˏ4), @Matrix2x4 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3, b1ˏ4, b2ˏ4) ->
    @Matrix2x4 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2, a1ˏ3 / b1ˏ3, a2ˏ3 / b2ˏ3, a1ˏ4 / b1ˏ4, a2ˏ4 / b2ˏ4)

isApproxEq : Matrix2x4, Matrix2x4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix2x4 (a1ˏ1, a2ˏ1, a1ˏ2, a2ˏ2, a1ˏ3, a2ˏ3, a1ˏ4, a2ˏ4), @Matrix2x4 (b1ˏ1, b2ˏ1, b1ˏ2, b2ˏ2, b1ˏ3, b2ˏ3, b1ˏ4, b2ˏ4), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol } && Num.isApproxEq a2ˏ3 b2ˏ3 { rtol, atol } && Num.isApproxEq a1ˏ4 b1ˏ4 { rtol, atol } && Num.isApproxEq a2ˏ4 b2ˏ4 { rtol, atol }
