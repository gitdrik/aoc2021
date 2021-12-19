open("19.txt") do f
    S = Set{Matrix{Int}}()
    while !eof(f)
        l = readline(f)
        @assert l[1:3] == "---"
        s = Array{Int}(undef, 3, 0)
        while !eof(f)
            l = readline(f)
            l == "" && break
            s = [s parse.(Int, split(l,','))]
        end
        push!(S, s)
    end

    P = [ # all possible 90 deg rotations in 3D
        s -> [ s[1,:]';  s[2,:]';  s[3,:]'],
        s -> [ s[1,:]'; -s[2,:]'; -s[3,:]'],
        s -> [ s[1,:]'; -s[3,:]';  s[2,:]'],
        s -> [ s[1,:]';  s[3,:]'; -s[2,:]'],
        s -> [-s[1,:]';  s[2,:]'; -s[3,:]'],
        s -> [-s[1,:]'; -s[2,:]';  s[3,:]'],
        s -> [-s[1,:]'; -s[3,:]'; -s[2,:]'],
        s -> [-s[1,:]';  s[3,:]';  s[2,:]'],
        s -> [ s[2,:]'; -s[1,:]';  s[3,:]'],
        s -> [ s[2,:]';  s[1,:]'; -s[3,:]'],
        s -> [ s[2,:]';  s[3,:]';  s[1,:]'],
        s -> [ s[2,:]'; -s[3,:]'; -s[1,:]'],
        s -> [-s[2,:]'; -s[1,:]'; -s[3,:]'],
        s -> [-s[2,:]';  s[1,:]';  s[3,:]'],
        s -> [-s[2,:]';  s[3,:]'; -s[1,:]'],
        s -> [-s[2,:]'; -s[3,:]';  s[1,:]'],
        s -> [ s[3,:]';  s[2,:]'; -s[1,:]'],
        s -> [ s[3,:]'; -s[2,:]';  s[1,:]'],
        s -> [ s[3,:]'; -s[1,:]'; -s[2,:]'],
        s -> [ s[3,:]';  s[1,:]';  s[2,:]'],
        s -> [-s[3,:]';  s[2,:]';  s[1,:]'],
        s -> [-s[3,:]'; -s[2,:]'; -s[1,:]'],
        s -> [-s[3,:]'; -s[1,:]';  s[2,:]'],
        s -> [-s[3,:]';  s[1,:]'; -s[2,:]']
    ]

    M = [pop!(S)]
    scanners = [[0,0,0]]
    for m ∈ M
        deletes = []
        for s ∈ S
            for p ∈ P, i ∈ 1:size(m, 2), j ∈ 1:size(s, 2)
                c = p(s)
                # overlap becon i and j
                translation = c[:,j] .- m[:,i]
                c = c .- translation
                cset = Set(c[:,k] for k ∈ 1:size(c,2))
                mset = Set(m[:,k] for k ∈ 1:size(m,2))
                if length(cset ∩ mset) ≥ 12
                    push!(M, c)
                    push!(deletes, s)
                    push!(scanners, translation)
                    break
                end
            end
        end
        for d ∈ deletes
            delete!(S, d)
        end
    end

    B = Set{Vector{Int}}()
    for m ∈ M
        for i ∈ 1:size(m,2)
            push!(B, m[:,i])
        end
    end
    println("Part 1: ", length(B))

    p2 = 0
    for i ∈ 1:length(scanners), j ∈ i+1:length(scanners)
        p2 = max(p2, sum(abs.(scanners[i].-scanners[j])))
    end
    println("Part 2: ", p2)
end
