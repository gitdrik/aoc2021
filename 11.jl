open("11.txt") do f
    O = Array{Int}(undef, 10, 10)
    for (i, l) ∈ enumerate(eachline(f))
        O[i,:] = parse.(Int, collect(l))
    end
    p1, t = 0, 0
    while minimum(O) ≠ maximum(O)
        t += 1
        O .+= 1
        while maximum(O) > 9
            for i∈1:10, j∈1:10
                if O[i, j] > 9
                    ir = max(1, i-1):min(10, i+1)
                    jr = max(1, j-1):min(10, j+1)
                    O[ir, jr] .+= 1
                    O[i, j] = typemin(Int)
                    p1 += t ≤ 100
                end
            end
        end
        O = max.(0, O)
    end
    println("Part 1: ", p1)
    println("Part 2: ", t)
end
