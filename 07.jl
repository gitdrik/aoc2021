open("07.txt") do f
    ns = parse.(Int, split(readline(f),','))
    median = sort(ns)[500]
    println("Part 1: ", sum(abs.(ns .- median)))

    mean = sum(ns)÷length(ns)
    f = typemax(Int)
    for i ∈ min(mean, median)-1:max(mean, median)+1
        ds = abs.(ns .- i)
        f = min(f, sum((ds.*ds.+ds).÷2))
    end
    println("Part 2: ", f)
end
