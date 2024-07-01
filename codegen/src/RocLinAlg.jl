module RocLinAlg

using Symbolics
using LinearAlgebra

convert_subscripts(s) = replace(string(s), (collect('₁':'₉') .=> collect(1:9))...)

lines(s) = split(s, '\n')

indent(s) = join("    " .* lines(s), "\n")

function_definition(
    name::String,
    signature::Pair{Vector{String},String},
    definition::Pair{Vector{String},String},
) = """
$name : $(join(first(signature),", ")) -> $(last(signature))
$name = \\$(join(first(definition), ", ")) ->
$(indent(last(definition)))
"""

function vector_module(n)
    v = Symbolics.variables(:v, 1:n)

    a = Symbolics.variables(:a, 1:n)
    b = Symbolics.variables(:b, 1:n)

    vector_type = "Vector$n"

    vector_to_roc(v) = "(" * join(convert_subscripts.(v), ", ") * ")"

    type_definition = "$vector_type : ($(join(repeat(["F64"], n), ", ")))"

    zeros_ = """
    zeros : $vector_type
    zeros = $(vector_to_roc(round.(Int, zeros(n))))
    """

    ones_ = """
    ones : $vector_type
    ones = $(vector_to_roc(round.(Int, ones(n))))
    """

    from_list = function_definition(
        "fromList",
        ["List F64"] => "Result $vector_type [InvalidSize]",
        ["list"] => (
            """
            when list is
                [$(join(convert_subscripts.(v), ", "))] -> Ok ($(join(convert_subscripts.(v), ", ")))
                _ -> Err InvalidSize
            """
        ),
    )


    to_list = function_definition(
        "toList",
        [vector_type] => "List F64",
        [vector_to_roc(v)] => "[ $(join(convert_subscripts.(v), ", ")) ]",
    )

    display = function_definition(
        "display",
        [vector_type] => "Str",
        [vector_to_roc(v)] => (
            """
            Str.joinWith [ "[", $(join(["Num.toStr " * x for x in convert_subscripts.(v)], ", \", \",")), "]" ] ""
            """
        ),
    )

    elementwise_function(name, operator) = function_definition(
        name,
        [vector_type, vector_type] => vector_type,
        [vector_to_roc(a), vector_to_roc(b)] => vector_to_roc([
            convert_subscripts(x) * " $operator " * convert_subscripts(y) for
            (x, y) in zip(a, b)
        ]),
    )

    add = elementwise_function("add", "+")
    sub = elementwise_function("sub", "-")
    elementwise_mul = elementwise_function("elementwiseMul", "*")
    div = elementwise_function("div", "/")

    dot_product = function_definition(
        "dot",
        [vector_type, vector_type] => "F64",
        [vector_to_roc(a), vector_to_roc(b)] =>
            convert_subscripts(LinearAlgebra.dot(a, b)),
    )

    cross_product =
        n == 3 ?
        function_definition(
            "cross",
            [vector_type, vector_type] => vector_type,
            [vector_to_roc(a), vector_to_roc(b)] =>
                vector_to_roc(LinearAlgebra.cross(a, b)),
        ) : missing

    is_approx_eq = function_definition(
        "isApproxEq",
        [vector_type, vector_type, "{rtol ? F64, atol ? F64}"] => "Bool",
        [vector_to_roc(a), vector_to_roc(b), "{ rtol ? 0.00001, atol ? 0.00000001 }"] =>
            join(
                [
                    "Num.isApproxEq $xa $xb {rtol, atol}" for
                    (xa, xb) in zip(convert_subscripts.(a), convert_subscripts.(b))
                ],
                " && ",
            ),
    )

    return roc_module(
        [
            # Type definition
            "Vector$(n)",
            # Constructors
            "zeros",
            "ones",
            "fromList",
            # Methods
            "toList",
            "display",
            # Operations
            "add",
            "sub",
            "elementwiseMul",
            "div",
            "dot",
            n == 3 ? "cross" : missing,
            "isApproxEq",
        ] |>
        skipmissing |>
        collect,
        [],
        [
            type_definition,
            zeros_,
            ones_,
            from_list,
            to_list,
            display,
            add,
            sub,
            elementwise_mul,
            div,
            dot_product,
            cross_product,
            is_approx_eq,
        ] |>
        skipmissing |>
        collect,
    )
end

function matrix_module(n, m)
    is_square = n == m
    is_long = n == 1 || m == 1

    x = Symbolics.variables(:x, 1:n, 1:m)
    x_det = Symbolics.variable(:det)
    v = (is_square || is_long) ? Symbolics.variables(:x, 1:max(n, m)) : missing

    a = Symbolics.variables(:a, 1:n, 1:m)
    b = Symbolics.variables(:b, 1:n, 1:m)

    matrix_type = "Matrix$(n)x$(m)"

    expect_matrix = reshape([x % (n + 1) == 1 ? x : 0 for x = 1:(n*m)], n, m)
    matrix_to_roc(m) = "@$matrix_type ($(join(vcat(convert_subscripts.(m)...), ", ")))"
    vector_to_roc(v) = "($(join(convert_subscripts.(v), ", ")))"

    type_definition = "$matrix_type := ($(join(repeat(["F64"], n*m), ", ")))"

    identity_ = is_square ? """
    identity : $matrix_type
    identity = fromDiagonal (diagonal ones)
    """ : missing

    zeros_ = """
    zeros : $matrix_type
    zeros = $(matrix_to_roc(round.(Int,zeros(n, m))))
    """

    ones_ = """
    ones : $matrix_type
    ones = $(matrix_to_roc(round.(Int,ones(n, m))))
    """

    from_diagonal =
        is_square ?
        function_definition(
            "fromDiagonal",
            ["Vector$n.Vector$n"] => matrix_type,
            [vector_to_roc(v)] => matrix_to_roc(LinearAlgebra.diagm(v)),
        ) : missing

    from_vector =
        is_long ?
        function_definition(
            "fromVector",
            ["Vector$(max(n, m)).Vector$(max(n, m))"] => matrix_type,
            [vector_to_roc(v)] => matrix_to_roc(v),
        ) : missing

    transpose =
        is_square ?
        function_definition(
            "transpose",
            [matrix_type] => matrix_type,
            [matrix_to_roc(x)] => matrix_to_roc(LinearAlgebra.transpose(x)),
        ) : missing

    diagonal =
        is_square ?
        (
            function_definition(
                "diagonal",
                [matrix_type] => "Vector$n.Vector$n",
                [
                    matrix_to_roc([
                        index[1] == index[2] ? a : "_" * string(a) for
                        (index, a) in zip(CartesianIndices(x), x)
                    ]),
                ] => vector_to_roc(LinearAlgebra.diag(x)),
            ) * (
                """

                expect
                    out = diagonal ($(matrix_to_roc(expect_matrix)))
                    out |> Vector$(n).isApproxEq ($(vector_to_roc(LinearAlgebra.diag(expect_matrix)))) {}
                """
            )
        ) : missing

    determinant =
        is_square ?
        (
            function_definition(
                "determinant",
                [matrix_type] => "F64",
                [matrix_to_roc(x)] => convert_subscripts(LinearAlgebra.det(x)),
            ) * """

                expect
                    out = determinant ($(matrix_to_roc(expect_matrix)))
                    out |> Num.isApproxEq $(LinearAlgebra.det(expect_matrix)) {}
                """
        ) : missing

    invert =
        is_square ?
        (
            function_definition(
                "invert",
                [matrix_type] => "Result $matrix_type [NonInvertible]",
                [matrix_to_roc(x)] => (
                    """
                    det = determinant ($(matrix_to_roc(x)))
                    if Num.isApproxEq det 0 {} then
                        Err NonInvertible
                    else
                        Ok ($(matrix_to_roc(LinearAlgebra.inv(x) .* LinearAlgebra.det(x) ./ x_det)))
                    """
                ),
            ) * """
                expect
                    outResult = invert ($(matrix_to_roc(expect_matrix)))
                    when outResult is
                        Ok out -> out |> isApproxEq ($(matrix_to_roc(LinearAlgebra.inv(expect_matrix)))) {}
                        Err NonInvertible -> Bool.false
                """
        ) : missing

    is_approx_eq = function_definition(
        "isApproxEq",
        [matrix_type, matrix_type, "{rtol ? F64, atol ? F64}"] => "Bool",
        [matrix_to_roc(a), matrix_to_roc(b), "{ rtol ? 0.00001, atol ? 0.00000001 }"] =>
            join(
                [
                    "Num.isApproxEq $xa $xb {rtol, atol}" for
                    (xa, xb) in zip(convert_subscripts.(a), convert_subscripts.(b))
                ],
                " && ",
            ),
    )

    elementwise_function(name, operator) = function_definition(
        name,
        [matrix_type, matrix_type] => matrix_type,
        [matrix_to_roc(a), matrix_to_roc(b)] => matrix_to_roc([
            x * " $operator " * y for
            (x, y) in zip(convert_subscripts.(a), convert_subscripts.(b))
        ]),
    )

    add = elementwise_function("add", "+")
    sub = elementwise_function("sub", "-")
    elementwise_mul = elementwise_function("elementwiseMul", "*")
    div = elementwise_function("div", "/")

    return roc_module(
        [
            # Type definition
            "Matrix$(n)x$(m)",
            # Constructors
            is_square ? "identity" : missing,
            "zeros",
            "ones",
            # "fromColumns",
            # "fromRows",
            is_square ? "fromDiagonal" : missing,
            is_long ? "fromVector" : missing,
            # Methods
            # "columns",
            # "rows",
            is_square ? "transpose" : missing,
            is_square ? "diagonal" : missing,
            is_square ? "determinant" : missing,
            is_square ? "invert" : missing,
            # Operations,
            "add",
            "sub",
            "elementwiseMul",
            "div",
            # "dot",
            # "cross",
            "isApproxEq",
        ] |>
        skipmissing |>
        collect,
        [(is_long || is_square) ? "Vector$(max(n,m))" : missing] |> skipmissing |> collect,
        [
            # Type definition
            type_definition,
            # Constructors
            identity_,
            zeros_,
            ones_,
            # from_columns,
            # from_rows,
            from_diagonal,
            from_vector,
            # Methods
            # columns,
            # rows,
            transpose,
            diagonal,
            determinant,
            invert,
            # Operations
            add,
            sub,
            elementwise_mul,
            div,
            # dot_product,
            # cross_product,
            is_approx_eq,
        ] |>
        skipmissing |>
        collect,
    )
end

function roc_module(exposes, imports, body)
    return """
    module [
        $(join(exposes,",\n"))
    ]

    $(join(["import $i" for i in imports],"\n"))

    $(join(body, "\n\n"))
    """
end

roc_package(exposes) = "package [$(join(exposes,",\n"))] {}"

function write_roc_file(filename, content)
    @info "Writing to file $filename"
    open(filename, "w") do io
        write(io, content)
    end
    return nothing
end

function main()
    vector_sizes = range(1, 4)
    matrix_sizes = vcat([(n, m) for n in vector_sizes, m in vector_sizes]...)

    mkpath("src")

    for n in vector_sizes
        write_roc_file("src/Vector$(n).roc", vector_module(n))
    end

    for (n, m) in matrix_sizes
        write_roc_file("src/Matrix$(n)x$(m).roc", matrix_module(n, m))
    end

    write_roc_file(
        "src/main.roc",
        roc_package(
            vcat(
                ["Vector$(n)" for n in vector_sizes],
                ["Matrix$(n)x$(m)" for (n, m) in matrix_sizes],
            ),
        ),
    )
end

end # module
