open("05.txt") do f
    lines = [parse.(Int, split(l, r",| -> ")) for l ∈ eachline(f)]
    M = zeros(Int, 1000, 1000)
    for (x1, y1, x2, y2) ∈ lines
        x1 == x2 ? M[x1, y1:sign(y2-y1):y2] .+= 1 :
        y1 == y2 ? M[x1:sign(x2-x1):x2, y1] .+= 1 : nothing
    end
    println("Part 1: ", sum(M .> 1))
    for (x1, y1, x2, y2) ∈ lines
        (x1==x2 || y1==y2) && continue
        for (x, y) ∈ zip(x1:sign(x2-x1):x2, y1:sign(y2-y1):y2)
            M[x,y] += 1
        end
    end
    println("Part 2: ", sum(M .> 1))
end
