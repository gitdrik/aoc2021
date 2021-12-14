open("14.txt") do f
    s = readline(f)
    readline(f)
    d = Dict(l[1:2]=>l[7] for l ∈ eachline(f))
    dn = Dict([[a, b] for (a, b) in d if ('N' in a*b || 'C' in a*b)])
    for i ∈ 1:40
        ns = s[1:1]
        for j ∈ 1:length(s)-1
            s[j:j+1] in keys(d) && (ns *= d[s[j:j+1]]*s[j+1])
        end
        s = ns
        C = Dict{Char, Int}()
        for c ∈ collect(ns)
            c ∈ keys(C) ? C[c] += 1 : C[c] = 1
        end
        println(sort([(b,a) for (a,b) in C]))
    end
end
