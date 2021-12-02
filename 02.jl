open("02.txt") do f
    ins = [(l[1], parse(Int, split(l)[2])) for l in eachline(f)]
    x, y, z = 0, 0, 0
    for (c, n) ∈ ins
        c == 'd' ? y += n :
        c == 'u' ? y -= n : (x, z) = (x+n, z+y*n)
    end
    println("Part 1: ", x*y)
    println("Part 2: ", x*z)
end
