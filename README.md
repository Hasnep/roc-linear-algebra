# Roc Linear Algebra

Linear algebra library for small vectors and matrices in Roc.

## Example

Import a matrix and vector type.

```roc
import linalg.Matrix4x4
import linalg.Vector4
```

Vectors are just tuples.

```roc
vecA = (1, 2, 3, 4)
Stdout.line! "Vector a is $(Vector4.display vecA)."
vecB = (5, 6, 7, 8)
Stdout.line! "Vector b is $(Vector4.display vecB)."
```

```text
Vector a is [1, 2, 3, 4].
Vector b is [5, 6, 7, 8].
```

Vectors have various vector-y functions that work how you'd expect.

```roc
vecC = Vector4.add vecA vecB
Stdout.line! "The sum of a and b is $(Vector4.display vecC)."
aDotB = Vector4.dot vecA vecB
Stdout.line! "The dot product of a and b is $(Num.toStr aDotB)."
```

```text
The sum of a and b is [6, 8, 10, 12].
The dot product of a and b is 70.
```

Matrices are opaque types.

```roc
mat = Matrix4x4.fromDiagonal vecC
```

Matrices also have matrix-y functions.

```roc
det = Matrix4x4.determinant mat
Stdout.line! "The determinant of the matrix is $(Num.toStr det)."
```

```text
The determinant of the matrix is 5760.
```
