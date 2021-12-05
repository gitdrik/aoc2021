open("05.txt") do f
    lines =
        readlines(f) .|> s->replace(s, " -> " => ",") |>
        s->split(s, ',') |> s->parse.(Int, s) |> collect
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
