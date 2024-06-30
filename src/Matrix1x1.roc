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
identity = fromDiagonal (1)

zeros : Matrix1x1
zeros = @Matrix1x1 (0)

ones : Matrix1x1
ones = @Matrix1x1 (1)

fromDiagonal : Vector1.Vector1 -> Matrix1x1
fromDiagonal = \a ->
    @Matrix1x1 (a)

fromVector : Vector1.Vector1 -> Matrix1x1
fromVector = \a ->
    @Matrix1x1 (a)

transpose : Matrix1x1 -> Matrix1x1
transpose = \@Matrix1x1 a ->
    @Matrix1x1 (a)

diagonal : Matrix1x1 -> Vector1.Vector1
diagonal = \@Matrix1x1 a -> a

expect
    out = diagonal (@Matrix1x1 (1))
    out |> Vector1.isApproxEq (1) {}

determinant : Matrix1x1 -> F64
determinant = \@Matrix1x1 a ->
    a

expect
    out = determinant (@Matrix1x1 (1))
    out |> Num.isApproxEq 1.0 {}

invert : Matrix1x1 -> Result Matrix1x1 [NonInvertible]
invert = \@Matrix1x1 a ->
    det = determinant (@Matrix1x1 (a))
    if Num.isApproxEq det 0 {} then
        Err NonInvertible
    else
        Ok
            (
                @Matrix1x1
                    (
                        1 / det
                    )
            )

expect
    outResult = invert (@Matrix1x1 (1))
    when outResult is
        Ok out -> out |> isApproxEq (@Matrix1x1 (1.0)) {}
        Err NonInvertible -> Bool.false

add : Matrix1x1, Matrix1x1 -> Matrix1x1
add = \@Matrix1x1 aA, @Matrix1x1 bA ->
    @Matrix1x1 (aA + bA)

sub : Matrix1x1, Matrix1x1 -> Matrix1x1
sub = \@Matrix1x1 aA, @Matrix1x1 bA ->
    @Matrix1x1 (aA - bA)

elementwiseMul : Matrix1x1, Matrix1x1 -> Matrix1x1
elementwiseMul = \@Matrix1x1 aA, @Matrix1x1 bA ->
    @Matrix1x1 (aA * bA)

div : Matrix1x1, Matrix1x1 -> Matrix1x1
div = \@Matrix1x1 aA, @Matrix1x1 bA ->
    @Matrix1x1 (aA / bA)

isApproxEq : Matrix1x1, Matrix1x1, { rtol ? F64, atol ? F64 } -> Bool
isApproxEq = \@Matrix1x1 aA, @Matrix1x1 bA, { rtol ? 0.00001, atol ? 0.00000001 } ->
    Num.isApproxEq aA bA { rtol, atol }
