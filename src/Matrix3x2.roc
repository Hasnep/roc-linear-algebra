module [
    Matrix3x2,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix3x2 := (F64, F64, F64, F64, F64, F64)

zeros : Matrix3x2
zeros = @Matrix3x2 (0, 0, 0, 0, 0, 0)

ones : Matrix3x2
ones = @Matrix3x2 (1, 1, 1, 1, 1, 1)

add : Matrix3x2, Matrix3x2 -> Matrix3x2
add = \@Matrix3x2 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2), @Matrix3x2 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2) ->
    @Matrix3x2 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a3ˏ1 + b3ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2, a3ˏ2 + b3ˏ2)

sub : Matrix3x2, Matrix3x2 -> Matrix3x2
sub = \@Matrix3x2 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2), @Matrix3x2 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2) ->
    @Matrix3x2 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a3ˏ1 - b3ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2, a3ˏ2 - b3ˏ2)

elementwiseMul : Matrix3x2, Matrix3x2 -> Matrix3x2
elementwiseMul = \@Matrix3x2 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2), @Matrix3x2 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2) ->
    @Matrix3x2 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a3ˏ1 * b3ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2, a3ˏ2 * b3ˏ2)

div : Matrix3x2, Matrix3x2 -> Matrix3x2
div = \@Matrix3x2 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2), @Matrix3x2 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2) ->
    @Matrix3x2 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a3ˏ1 / b3ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2, a3ˏ2 / b3ˏ2)

isApproxEq : Matrix3x2, Matrix3x2, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix3x2 (a1ˏ1, a2ˏ1, a3ˏ1, a1ˏ2, a2ˏ2, a3ˏ2), @Matrix3x2 (b1ˏ1, b2ˏ1, b3ˏ1, b1ˏ2, b2ˏ2, b3ˏ2), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a3ˏ1 b3ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol } && Num.isApproxEq a3ˏ2 b3ˏ2 { rtol, atol }
