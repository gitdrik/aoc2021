open("02.txt") do f
    ins = [(l[1], parse(Int, split(l)[2])) for l in eachline(f)]
    fw, dp = 0, 0
    for (c, n) ∈ ins
        c == 'd' ? dp += n :
        c == 'u' ? dp -= n :
        c == 'f' ? fw += n : nothing
    end
    println("Part 1: ", fw*dp)

    fw, dp, am = 0, 0, 0
    for (c, n) ∈ ins
        c == 'd' ? am += n :
        c == 'u' ? am -= n :
        c == 'f' ? (fw, dp) = (fw+n, dp+am*n) : nothing
    end
    println("Part 2: ", fw*dp)
end
