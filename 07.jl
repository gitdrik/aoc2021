open("07.txt") do f
    ns = parse.(Int, split(readline(f),','))
    f1, f2 = typemax(Int), typemax(Int)
    for i ∈ minimum(ns):maximum(ns)
        ds = abs.(ns .- i)
        f1 = min(f1, sum(ds))
        f2 = min(f2, sum((ds.*ds.+ds).÷2))
    end
    println("Part 1: ", f1)
    println("Part 2: ", f2)
end
