open("20.txt") do f
    E = Dict{BitMatrix, Bool}()
    for (n, c) ∈ enumerate(readline(f))
        d = reverse(digits(n-1, base=2, pad=9))
        k = BitMatrix([d[1:3] d[4:6] d[7:9]])
        E[k] = (c=='#')
    end
    @assert readline(f) == ""
    I = falses(202, 202)
    for (i, l) ∈ enumerate(readlines(f))
        I[52:151, i+51] = [c=='#' for c ∈ l]
    end
    for t∈1:50
        nI = isodd(t) ? trues(202, 202) : falses(202, 202)
        for r∈52-t:151+t, c∈52-t:151+t
            nI[r,c] = E[I[r-1:r+1, c-1:c+1]]
        end
        I = nI
        t == 2 && println("Part 1: ", sum(I))
    end
    println("Part 2: ", sum(I))
end
