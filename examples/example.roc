app [main] {
    cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.11.0/SY4WWMhWQ9NvQgvIthcv15AUeA7rAIJHAHgiaSHGhdY.tar.br",
    linalg: "../src/main.roc",
}

import cli.Stdout
import cli.Task
import linalg.Matrix4x4
import linalg.Vector4

main =
    vecA = (1, 2, 3, 4)
    Stdout.line! "Vector a is $(Vector4.display vecA)."
    vecB = (5, 6, 7, 8)
    Stdout.line! "Vector b is $(Vector4.display vecB)."
    vecC = Vector4.add vecA vecB
    Stdout.line! "The sum of a and b is $(Vector4.display vecC)."
    aDotB = Vector4.dot vecA vecB
    Stdout.line! "The dot product of a and b is $(Num.toStr aDotB)."
    mat = Matrix4x4.fromDiagonal vecC
    det = Matrix4x4.determinant mat
    Stdout.line! "The determinant of the matrix is $(Num.toStr det)."
