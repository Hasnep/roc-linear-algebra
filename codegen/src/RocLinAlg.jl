module RocLinAlg

using Symbolics
using LinearAlgebra

letters(n) = first(collect('a':'z'), n)

elements(n::Integer) = letters(n)
elements(n::Integer, m::Integer) = letters(n * m)
elements(n::Integer, m::Integer, prefix::String) =
    [prefix * uppercase(s) for s in elements(n, m)]
elements(n::Integer, prefix::String) = [prefix * uppercase(s) for s in elements(n)]

function vec_to_letters(s, prefix = nothing)
    return replace(
        s,
        collect(
            ((isnothing(prefix) ? "" : prefix) .* collect('₁':'₉')) .=>
                ((isnothing(prefix) ? uppercase : identity).(letters(9))),
        )...,
    )
end

function matrix_to_letters(s, n, m, prefix = nothing)
    subscripts = collect('₁':'₉')
    return replace.(
        s,
        [
            (isnothing(prefix) ? "" : prefix) * column_sub * "ˏ" * row_sub =>
                (isnothing(prefix) ? uppercase : identity)(elements(n, m)[index]) for
            (index, (column_sub, row_sub)) in enumerate(
                vcat(
                    [
                        (column_sub, row_sub) for column_sub in first(subscripts, n),
                        row_sub in first(subscripts, m)
                    ]...,
                ),
            )
        ]...,
    )
end

function vector_module(n)
    a = Symbolics.variables(:a, 1:n)
    b = Symbolics.variables(:b, 1:n)

    vector_type = "Vector$n"

    type_definition = "$vector_type : ($(join(repeat(["F64"], n), ", ")))"

    zeros = """
    zeros : $vector_type
    zeros =  ($(join(repeat(["0"], n), ", ")))
    """

    ones = """
    ones : $vector_type
    ones =  ($(join(repeat(["1"], n), ", ")))
    """

    from_list = """
    fromList : List F64 -> Result $vector_type [InvalidSize]
    fromList = \\list ->
        when list is
            [$(join(elements(n), ", "))] -> Ok ($(join(elements(n), ", ")))
            _ -> Err InvalidSize
    """

    to_list = """
    toList : $vector_type -> List F64
    toList = \\($(join(elements(n), ", "))) -> [$(join(elements(n), ", "))]
    """

    display = """
    display : $vector_type -> Str
    display = \\($(join(elements(n), ", "))) ->
        Str.joinWith ["[", $(join(["Num.toStr " * x for x in elements(n)], ", \", \",")), "]"] ""
    """

    elementwise_function(name, operator) = """
    $(name) : $vector_type, $vector_type -> $vector_type
    $(name) = \\($(join(elements(n, "a"), ", "))),  ($(join(elements(n, "b"), ", "))) ->
         ($(join(elements(n, "a") .* " $(operator) " .* elements(n, "b"), ", ")))
    """

    add = elementwise_function("add", "+")
    sub = elementwise_function("sub", "-")
    elementwise_mul = elementwise_function("elementwiseMul", "*")
    div = elementwise_function("div", "/")

    dot_product = """
    dot : $(vector_type), $(vector_type) -> F64
    dot = \\ ($(join(elements(n,"a"), ", "))),  ($(join(elements(n,"b"), ", "))) -> $(vec_to_letters(string(dot(a,b))))
    """

    cross_product =
        n == 3 ?
        """
cross : $(vector_type), $(vector_type) -> $(vector_type)
cross = \\ ($(join(elements(n, "a"), ", "))),  ($(join(elements(n, "b"), ", "))) ->
     ($(join(vec_to_letters.(string.(cross(a,b))), ", ")))
""" : missing

    is_approx_eq = """
    isApproxEq : $(vector_type), $(vector_type), { rtol ? F64, atol ? F64 } -> Bool
    isApproxEq = \\ ($(join(elements(n, "a"), ", "))),  ($(join(elements(n, "b"), ", "))), { rtol ? 0.00001, atol ? 0.00000001 } ->
        $(join( ["Num.isApproxEq $xa $xb {rtol, atol}" for (xa,xb) in zip(elements(n, "a"),   elements(n, "b"))], " && "))
    """

    return roc_module(
        skipmissing([
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
        ]),
        [],
        skipmissing([
            type_definition,
            zeros,
            ones,
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
        ]),
    )
end

function matrix_module(n, m)
    is_square = n == m
    is_long = n == 1 || m == 1

    a = Symbolics.variables(:a, 1:n, 1:m)
    b = Symbolics.variables(:b, 1:n, 1:m)
    a_det = Symbolics.variable(:det)

    matrix_type = "Matrix$(n)x$(m)"

    expect_matrix = reshape([x % (n + 1) == 1 ? x : 0 for x = 1:(n*m)], n, m)
    matrix_to_roc(m) = "@$matrix_type ($(join(vcat(m...), ", ")))"
    vector_to_roc(v) = "($(join(v, ", ")))"

    type_definition = "$matrix_type := ($(join(repeat(["F64"], n*m), ", ")))"

    identity = is_square ? """
    identity : $matrix_type
    identity = fromDiagonal ($(join(repeat(["1"], n), ", ")))
    """ : missing

    zeros = """
    zeros : $matrix_type
    zeros = @$matrix_type ($(join(repeat(["0"], n*m), ", ")))
    """

    ones = """
    ones : $matrix_type
    ones = @$matrix_type ($(join(repeat(["1"], n*m), ", ")))
    """

    from_diagonal =
        is_square ?
        """
        fromDiagonal : Vector$n.Vector$n -> $matrix_type
        fromDiagonal = \\($(join(skipmissing([i == j ? matrix_to_letters(string(LinearAlgebra.diag(a)[i]),n,m,"a") : missing for i in 1:n, j in 1:m]), ", "))) ->
            @$matrix_type ($(join([i == j ? matrix_to_letters(string(LinearAlgebra.diag(a)[i]),n,m,"a") : "0" for i in 1:n, j in 1:m], ", ")))
        """ : missing

    from_vector =
        is_long ? begin
            nm = max(n, m)
            """
            fromVector : Vector$nm.Vector$nm -> $matrix_type
            fromVector = \\($(join(elements(nm), ", "))) ->
                @$matrix_type ($(join(elements(nm), ", ")))
            """
        end : missing

    transpose =
        is_square ?
        """
        transpose : $matrix_type -> $matrix_type
        transpose = \\@$matrix_type ($(join(elements(n*m), ", "))) ->
            @$matrix_type ($(join(vcat(matrix_to_letters.(string.(LinearAlgebra.transpose(a)), n, m, "a")...), ",")))
        """ : missing

    diagonal =
        is_square ?
        begin
            diagonal_letters =
                matrix_to_letters.(
                    string.(diag(Symbolics.variables(:a, 1:n, 1:m))),
                    n,
                    m,
                    "a",
                )
            """
            diagonal : $matrix_type -> Vector$n.Vector$n
            diagonal = \\@$matrix_type ($(join([(string(e) in diagonal_letters ? e : "_" * e ) for e in elements(n*m)], ", "))) -> ($(join(diagonal_letters, ", ")))

            expect
                out = diagonal ($(matrix_to_roc(expect_matrix)))
                out |> Vector$(n).isApproxEq ($(vector_to_roc(LinearAlgebra.diag(expect_matrix)))) {}
            """
        end : missing

    determinant =
        is_square ? """
                    determinant : $matrix_type -> F64
                    determinant = \\@$matrix_type ($(join(elements(n*m), ", "))) ->
                        $(matrix_to_letters(string.(LinearAlgebra.det(a)),n,m,"a"))

                    expect
                        out = determinant ($(matrix_to_roc(expect_matrix)))
                        out |> Num.isApproxEq $(LinearAlgebra.det(expect_matrix)) {}
                    """ : missing

    invert =
        is_square ?
        """
        invert : $matrix_type -> Result $matrix_type [NonInvertible]
        invert = \\@$matrix_type ($(join(elements(n*m), ", "))) ->
            det = determinant (@$matrix_type ($(join(elements(n * m), ", "))))
            if Num.isApproxEq det 0 {} then
                Err NonInvertible
            else
                Ok (
                    @$matrix_type (
                        $(join(vcat(matrix_to_letters.(string.(LinearAlgebra.inv(a) .* LinearAlgebra.det(a) ./ a_det), n, m, "a")...), ","))
                    )
                )

        expect
            outResult = invert ($(matrix_to_roc(expect_matrix)))
            when outResult is
                Ok out -> out |> isApproxEq ($(matrix_to_roc(LinearAlgebra.inv(expect_matrix)))) {}
                Err NonInvertible -> Bool.false
        """ : missing

    is_approx_eq = """
    isApproxEq : $matrix_type, $matrix_type, { rtol ? F64, atol ? F64 } -> Bool
    isApproxEq = \\@$matrix_type ($(join(elements(n*m, "a"), ", "))), @$matrix_type ($(join(elements(n*m, "b"), ", "))), { rtol ? 0.00001, atol ? 0.00000001 } ->
        $(join( ["Num.isApproxEq $xa $xb {rtol, atol}" for (xa, xb) in zip(elements(n*m, "a"),   elements(n*m, "b"))], " && "))
    """

    elementwise_function(name, operator) = """
    $name : $matrix_type, $matrix_type -> $matrix_type
    $name = \\@$matrix_type ($(join(elements(n*m, "a"), ", "))), @$matrix_type ($(join(elements(n*m, "b"), ", "))) ->
        @$matrix_type ($(join(elements(n*m, "a") .* " $operator " .* elements(n*m, "b"), ", ")))
    """

    add = elementwise_function("add", "+")
    sub = elementwise_function("sub", "-")
    elementwise_mul = elementwise_function("elementwiseMul", "*")
    div = elementwise_function("div", "/")

    return roc_module(
        skipmissing([
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
        ]),
        skipmissing([(is_long || is_square) ? "Vector$(max(n,m))" : missing]),
        skipmissing([
            # Type definition
            type_definition,
            # Constructors
            identity,
            zeros,
            ones,
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
        ]),
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
