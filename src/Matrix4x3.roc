module [
    Matrix4x3,
    zeros,
    ones,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

Matrix4x3 := (F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64, F64)

zeros : Matrix4x3
zeros = @Matrix4x3 (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

ones : Matrix4x3
ones = @Matrix4x3 (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

add : Matrix4x3, Matrix4x3 -> Matrix4x3
add = \@Matrix4x3 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3), @Matrix4x3 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3) ->
    @Matrix4x3 (a1ˏ1 + b1ˏ1, a2ˏ1 + b2ˏ1, a3ˏ1 + b3ˏ1, a4ˏ1 + b4ˏ1, a1ˏ2 + b1ˏ2, a2ˏ2 + b2ˏ2, a3ˏ2 + b3ˏ2, a4ˏ2 + b4ˏ2, a1ˏ3 + b1ˏ3, a2ˏ3 + b2ˏ3, a3ˏ3 + b3ˏ3, a4ˏ3 + b4ˏ3)

sub : Matrix4x3, Matrix4x3 -> Matrix4x3
sub = \@Matrix4x3 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3), @Matrix4x3 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3) ->
    @Matrix4x3 (a1ˏ1 - b1ˏ1, a2ˏ1 - b2ˏ1, a3ˏ1 - b3ˏ1, a4ˏ1 - b4ˏ1, a1ˏ2 - b1ˏ2, a2ˏ2 - b2ˏ2, a3ˏ2 - b3ˏ2, a4ˏ2 - b4ˏ2, a1ˏ3 - b1ˏ3, a2ˏ3 - b2ˏ3, a3ˏ3 - b3ˏ3, a4ˏ3 - b4ˏ3)

elementwiseMul : Matrix4x3, Matrix4x3 -> Matrix4x3
elementwiseMul = \@Matrix4x3 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3), @Matrix4x3 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3) ->
    @Matrix4x3 (a1ˏ1 * b1ˏ1, a2ˏ1 * b2ˏ1, a3ˏ1 * b3ˏ1, a4ˏ1 * b4ˏ1, a1ˏ2 * b1ˏ2, a2ˏ2 * b2ˏ2, a3ˏ2 * b3ˏ2, a4ˏ2 * b4ˏ2, a1ˏ3 * b1ˏ3, a2ˏ3 * b2ˏ3, a3ˏ3 * b3ˏ3, a4ˏ3 * b4ˏ3)

div : Matrix4x3, Matrix4x3 -> Matrix4x3
div = \@Matrix4x3 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3), @Matrix4x3 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3) ->
    @Matrix4x3 (a1ˏ1 / b1ˏ1, a2ˏ1 / b2ˏ1, a3ˏ1 / b3ˏ1, a4ˏ1 / b4ˏ1, a1ˏ2 / b1ˏ2, a2ˏ2 / b2ˏ2, a3ˏ2 / b3ˏ2, a4ˏ2 / b4ˏ2, a1ˏ3 / b1ˏ3, a2ˏ3 / b2ˏ3, a3ˏ3 / b3ˏ3, a4ˏ3 / b4ˏ3)

isApproxEq : Matrix4x3, Matrix4x3, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix4x3 (a1ˏ1, a2ˏ1, a3ˏ1, a4ˏ1, a1ˏ2, a2ˏ2, a3ˏ2, a4ˏ2, a1ˏ3, a2ˏ3, a3ˏ3, a4ˏ3), @Matrix4x3 (b1ˏ1, b2ˏ1, b3ˏ1, b4ˏ1, b1ˏ2, b2ˏ2, b3ˏ2, b4ˏ2, b1ˏ3, b2ˏ3, b3ˏ3, b4ˏ3), { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol } && Num.isApproxEq a2ˏ1 b2ˏ1 { rtol, atol } && Num.isApproxEq a3ˏ1 b3ˏ1 { rtol, atol } && Num.isApproxEq a4ˏ1 b4ˏ1 { rtol, atol } && Num.isApproxEq a1ˏ2 b1ˏ2 { rtol, atol } && Num.isApproxEq a2ˏ2 b2ˏ2 { rtol, atol } && Num.isApproxEq a3ˏ2 b3ˏ2 { rtol, atol } && Num.isApproxEq a4ˏ2 b4ˏ2 { rtol, atol } && Num.isApproxEq a1ˏ3 b1ˏ3 { rtol, atol } && Num.isApproxEq a2ˏ3 b2ˏ3 { rtol, atol } && Num.isApproxEq a3ˏ3 b3ˏ3 { rtol, atol } && Num.isApproxEq a4ˏ3 b4ˏ3 { rtol, atol }
