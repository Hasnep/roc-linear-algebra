module [
    Matrix1x1,
    identity,
    zeros,
    ones,
    fromDiagonal,
    fromVector,
    transpose,
    diagonal,
    determinant,
    invert,
    add,
    sub,
    elementwiseMul,
    div,
    isApproxEq,
]

import Vector1

Matrix1x1 := F64

identity : Matrix1x1
identity = fromDiagonal (diagonal ones)

zeros : Matrix1x1
zeros = @Matrix1x1 (0)

ones : Matrix1x1
ones = @Matrix1x1 (1)

fromDiagonal : Vector1.Vector1 -> Matrix1x1
fromDiagonal = \x1 ->
    @Matrix1x1 (x1)

fromVector : Vector1.Vector1 -> Matrix1x1
fromVector = \x1 ->
    @Matrix1x1 (x1)

transpose : Matrix1x1 -> Matrix1x1
transpose = \@Matrix1x1 x1ˏ1 ->
    @Matrix1x1 (x1ˏ1)

diagonal : Matrix1x1 -> Vector1.Vector1
diagonal = \@Matrix1x1 x1ˏ1 ->
    x1ˏ1

expect
    out = diagonal (@Matrix1x1 (1))
    out |> Vector1.isApproxEq (1) {}

determinant : Matrix1x1 -> F64
determinant = \@Matrix1x1 x1ˏ1 ->
    x1ˏ1

expect
    out = determinant (@Matrix1x1 (1))
    out |> Num.isApproxEq 1.0 {}

invert : Matrix1x1 -> Result Matrix1x1 [NonInvertible]
invert = \@Matrix1x1 x1ˏ1 ->
    det = determinant (@Matrix1x1 (x1ˏ1))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok (@Matrix1x1 (1 / det))

expect
    outResult = invert (@Matrix1x1 (1))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix1x1 (1.0)) {}
        Err NonInvertible -> Bool.false

add : Matrix1x1, Matrix1x1 -> Matrix1x1
add = \@Matrix1x1 a1ˏ1, @Matrix1x1 b1ˏ1 ->
    @Matrix1x1 (a1ˏ1 + b1ˏ1)

sub : Matrix1x1, Matrix1x1 -> Matrix1x1
sub = \@Matrix1x1 a1ˏ1, @Matrix1x1 b1ˏ1 ->
    @Matrix1x1 (a1ˏ1 - b1ˏ1)

elementwiseMul : Matrix1x1, Matrix1x1 -> Matrix1x1
elementwiseMul = \@Matrix1x1 a1ˏ1, @Matrix1x1 b1ˏ1 ->
    @Matrix1x1 (a1ˏ1 * b1ˏ1)

div : Matrix1x1, Matrix1x1 -> Matrix1x1
div = \@Matrix1x1 a1ˏ1, @Matrix1x1 b1ˏ1 ->
    @Matrix1x1 (a1ˏ1 / b1ˏ1)

isApproxEq : Matrix1x1, Matrix1x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x1 a1ˏ1, @Matrix1x1 b1ˏ1, { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq a1ˏ1 b1ˏ1 { rtol, atol }
