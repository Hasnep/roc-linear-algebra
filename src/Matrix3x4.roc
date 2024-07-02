module [
    Matrix3x4,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix3x4 := (F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64)

zeros : Matrix3x4
zeros = @Matrix3x4 (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix3x4
ones = @Matrix3x4 (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

add : Matrix3x4, Matrix3x4 -> Matrix3x4
add = \@Matrix3x4 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a1ˏ4, a2ˏ4, a3ˏ4), @Matrix3x4 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b1ˏ4, b2ˏ4, b3ˏ4) ->
    @Matrix3x4 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a3ˏ1 + b3ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2, a3ˏ2 + b3ˏ2, a1ˏ3 + b1ˏ3, a2ˏ3 + b2ˏ3, a3ˏ3 + b3ˏ3, a1ˏ4 + b1ˏ4, a2ˏ4 + b2ˏ4, a3ˏ4 + b3ˏ4)

sub : Matrix3x4, Matrix3x4 -> Matrix3x4
sub = \@Matrix3x4 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a1ˏ4, a2ˏ4, a3ˏ4), @Matrix3x4 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b1ˏ4, b2ˏ4, b3ˏ4) ->
    @Matrix3x4 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a3ˏ1 - b3ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2, a3ˏ2 - b3ˏ2, a1ˏ3 - b1ˏ3, a2ˏ3 - b2ˏ3, a3ˏ3 - b3ˏ3, a1ˏ4 - b1ˏ4, a2ˏ4 - b2ˏ4, a3ˏ4 - b3ˏ4)

elementwiseMul : Matrix3x4, Matrix3x4 -> Matrix3x4
elementwiseMul = \@Matrix3x4 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a1ˏ4, a2ˏ4, a3ˏ4), @Matrix3x4 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b1ˏ4, b2ˏ4, b3ˏ4) ->
    @Matrix3x4 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a3ˏ1 * b3ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2, a3ˏ2 * b3ˏ2, a1ˏ3 * b1ˏ3, a2ˏ3 * b2ˏ3, a3ˏ3 * b3ˏ3, a1ˏ4 * b1ˏ4, a2ˏ4 * b2ˏ4, a3ˏ4 * b3ˏ4)

div : Matrix3x4, Matrix3x4 -> Matrix3x4
div = \@Matrix3x4 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a1ˏ4, a2ˏ4, a3ˏ4), @Matrix3x4 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b1ˏ4, b2ˏ4, b3ˏ4) ->
    @Matrix3x4 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a3ˏ1 / b3ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2, a3ˏ2 / b3ˏ2, a1ˏ3 / b1ˏ3, a2ˏ3 / b2ˏ3, a3ˏ3 / b3ˏ3, a1ˏ4 / b1ˏ4, a2ˏ4 / b2ˏ4, a3ˏ4 / b3ˏ4)

isApproxEq : Matrix3x4, Matrix3x4, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix3x4 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a1ˏ4, a2ˏ4, a3ˏ4), @Matrix3x4 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b1ˏ4, b2ˏ4, b3ˏ4), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a3ˏ1 b3ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol } && Num.isApproxEq a3ˏ2 b3ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol } && Num.isApproxEq a2ˏ3 b2ˏ3 { rtol, atol } && Num.isApproxEq a3ˏ3 b3ˏ3 { rtol, atol } && Num.isApproxEq a1ˏ4 b1ˏ4 { rtol, atol } && Num.isApproxEq a2ˏ4 b2ˏ4 { rtol, atol } && Num.isApproxEq a3ˏ4 b3ˏ4 { rtol, atol }
