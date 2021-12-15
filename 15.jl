using DataStructures
open("15.txt") do f
    G = Array{Int}(undef, 100, 100)
    for (i, l) ∈ enumerate(eachline(f))
        G[i,:] = parse.(Int, collect(l))
    end
    function solve(maxx, maxy)
        dirs = [(0,-1), (1, 0), (0, 1), (-1, 0)]
        Q = SortedSet([(0, (1, 1))])
        seen = Set{Tuple{Int, Int}}()
        while length(Q) > 0
            risk, pos = pop!(Q)
            pos == (maxx, maxy) && return risk
            pos ∈ seen && continue
            push!(seen, pos)
            for (nx, ny) ∈ [pos .+ d for d ∈ dirs]
                (nx ∉ 1:maxx || ny ∉ 1:maxy) && continue
                (nx, ny) ∈ seen && continue
                r = mod1(G[mod1(nx,100), mod1(ny,100)] + (nx-1)÷100 + (ny-1)÷100, 9)
                push!(Q, (risk+r, (nx, ny)))
            end
        end
    end
    println("Part 1: ", solve(100, 100))
    println("Part 2: ", solve(500, 500))
end
