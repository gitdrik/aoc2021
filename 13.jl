open("13.txt") do f
    P = Set{Tuple{Int,Int}}()
    for l ∈ eachline(f)
        l == "" && break
        x, y = parse.(Int, split(l,','))
        push!(P, (x, y))
    end
    for (i, l) ∈ enumerate(eachline(f))
        ss = split(l, r" |=")
        f, n = ss[end-1], parse(Int, ss[end])
        nP = Set{Tuple{Int,Int}}()
        for (x, y) ∈ P
            f == "x" && x > n && (x = 2n-x)
            f == "y" && y > n && (y = 2n-y)
            push!(nP, (x,y))
        end
        P = nP
        i == 1 && println("Part 1: ", length(P))
    end
    println("Part 2: ")
    for y ∈ 0:5
        for x ∈ 0:40
            print((x,y) ∈ P ? '█' : ' ')
        end
        println()
    end
end
