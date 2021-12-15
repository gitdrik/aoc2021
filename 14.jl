open("14.txt") do f
    s = readline(f)
    readline(f)
    split = Dict(l[1:2] => (string(l[1],l[7]), string(l[7],l[2])) for l ∈ eachline(f))
    pairs = Dict{String, Int}()
    for i ∈ 1:length(s)-1
        s[i:i+1] ∈ keys(pairs) ? pairs[s[i:i+1]] +=1 : pairs[s[i:i+1]] = 1
    end

    function poly(pairs, n)
        n == 0 && return pairs
        np = Dict{String, Int}()
        for (p, m) ∈ pairs
            p1, p2 = split[p]
            p1 ∈ keys(np) ? np[p1] += m : np[p1] = m
            p2 ∈ keys(np) ? np[p2] += m : np[p2] = m
        end
        poly(np, n-1)
    end

    function charcount(pairs)
        cc = Dict{Char,Int}()
        for (s, n) ∈ pairs
            s[1] ∈ keys(cc) ? cc[s[1]] += n : cc[s[1]] = n
        end
        s[end] ∈ keys(cc) ? cc[s[end]] += 1 : cc[s[end]] = 1
        return cc
    end

    pairs = poly(pairs, 10)
    cc = charcount(pairs)
    println("Part 1: ", maximum(values(cc))-minimum(values(cc)))

    pairs = poly(pairs, 30)
    cc = charcount(pairs)
    println("Part 2: ", maximum(values(cc))-minimum(values(cc)))
end
