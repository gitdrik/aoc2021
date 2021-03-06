open("09.txt") do f
    M = fill(9, 102, 102)
    for (y, l) ∈ enumerate(eachline(f))
        M[2:101, y+1] = parse.(Int, [c for c ∈ l])
    end

    p1, lows = 0, []
    adj = [(0,-1), (1, 0), (0, 1), (-1,0)]
    for x ∈ 2:101, y ∈ 2:101
        any(M[x+i, y+j] ≤ M[x,y] for (i,j) ∈ adj) && continue
        p1 += M[x, y]+1
        push!(lows, (x, y))
    end
    println("Part 1: ", p1)

    basins = Array{Int}([])
    seen = Set{Tuple{Int,Int}}()
    for l ∈ lows
        edges = Set{Tuple{Int,Int}}([l])
        basin = 0
        while !isempty(edges)
            e = pop!(edges)
            push!(seen, e)
            basin += 1
            for n ∈ [a .+ e for a ∈ adj]
                (M[n...] == 9 || n ∈ seen) && continue
                push!(edges, n)
            end
        end
        push!(basins, basin)
    end
    println("Part 2: ", prod(sort(basins)[end-2:end]))
end
