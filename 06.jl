open("06.txt") do f
    F = zeros(Int, 9)
    for n ∈ parse.(Int, split(readline(f),','))
        F[n+1] += 1
    end
    for t ∈ 1:80
        F = circshift(F, -1)
        F[7] += F[9]
    end
    println("Part 1: ", sum(F))
    for t ∈ 81:256
        F = circshift(F, -1)
        F[7] += F[9]
    end
    println("Part 2: ", sum(F))
end
