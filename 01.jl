open("01.txt") do f
    ns = parse.(Int, readlines(f))
    println("Part 1: ", sum([ns[i] > ns[i-1] for i ∈ 2:length(ns)]))
    println("Part 2: ", sum([ns[i] > ns[i-3] for i ∈ 4:length(ns)]))
end
