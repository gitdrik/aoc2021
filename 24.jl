open("24.txt") do f
    C = split.(readlines(f))
    function alu(digs)
        M, ds = Dict("w"=>0, "x"=>0, "y"=>0, "z"=>0), copy(digs)
        for c ∈ C
            c[1] == "inp" ? (M[c[2]] = popfirst!(ds)) :
            c[1] == "add" ? (M[c[2]] = M[c[2]] + (c[3][1] ∈ 'w':'z' ? M[c[3]] : parse(Int, c[3]))) :
            c[1] == "mul" ? (M[c[2]] = M[c[2]] * (c[3][1] ∈ 'w':'z' ? M[c[3]] : parse(Int, c[3]))) :
            c[1] == "div" ? (M[c[2]] = M[c[2]] ÷ (c[3][1] ∈ 'w':'z' ? M[c[3]] : parse(Int, c[3]))) :
            c[1] == "mod" ? (M[c[2]] = M[c[2]] % (c[3][1] ∈ 'w':'z' ? M[c[3]] : parse(Int, c[3]))) :
            c[1] == "eql" ? (M[c[2]] = M[c[2]] == (c[3][1] ∈ 'w':'z' ? M[c[3]] : parse(Int, c[3]))) :
            println("Syntax error in: ", c[1])
        end
        return M["z"]
    end

    digs = zeros(Int, 14)
    # De-assmebling input code (see 24notes.txt) gives that z is 0 if
    # d3 = d4+7
    digs[3] = 9
    digs[4] = 2
    # d2 = d5+5
    digs[2] = 9
    digs[5] = 4
    # d8 = d7+1
    digs[8] = 9
    digs[7] = 8
    # d10 = d9+5
    digs[10] = 9
    digs[9] = 4
    # d11 = d12
    digs[11] = 9
    digs[12] = 9
    # d6 = d13+3
    digs[6] = 9
    digs[13] = 6
    # d14 = d1+6
    digs[14] = 9
    digs[1] = 3
    @assert alu(digs)==0
    println("Part 1: ", join(string.(digs)))

    # Retuning for minimum number
    # d3 = d4+7
    digs[3] = 8
    digs[4] = 1
    # d2 = d5+5
    digs[2] = 6
    digs[5] = 1
    # d8 = d7+1
    digs[8] = 2
    digs[7] = 1
    # d10 = d9+5
    digs[10] = 6
    digs[9] = 1
    # d11 = d12
    digs[11] = 1
    digs[12] = 1
    # d6 = d13+3
    digs[6] = 4
    digs[13] = 1
    # d14 = d1+6
    digs[14] = 7
    digs[1] = 1
    @assert alu(digs)==0
    println("Part 2: ", join(string.(digs)))
end
