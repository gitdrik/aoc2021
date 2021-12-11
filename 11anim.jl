function pprint(O, t, p1, n)
    run(`clear`)
    s = ""
    for i ∈ 1:10
        for j ∈ 1:10
            m = ['█',' ','·','◦','🞊','∘','○','⊙','⦾','0','█']
            s *= m[min(11, max(0, O[i,j])+1)]
        end
        s *= "\n"
    end
    print(s)
    println("Part 1: ", p1, " flashes")
    println("Part 2: ", t, " steps")
    sleep(n)
end

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
            for i ∈ 1:10, j ∈ 1:10
                if O[i, j] > 9
                    ir = max(1, i-1):min(10, i+1)
                    jr = max(1, j-1):min(10, j+1)
                    O[ir, jr] .+= 1
                    O[i, j] = typemin(Int)
                    p1 += t ≤ 100
                end
            end
            pprint(O, t, p1, 0.03)
        end
        O = max.(0, O)
        pprint(O, t, p1, 0.1)
    end
end
