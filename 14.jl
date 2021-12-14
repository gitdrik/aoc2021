using Counters

open("14.txt") do f
    s = readline(f)
    readline(f)
    d = Dict(l[1:2]=>l[7] for l ∈ eachline(f))

    ns = ""
    for i ∈ 1:10
        for j ∈ 1:length(s)-1
            ns *= s[i]*d[s[i:i+1]]*s[i+1]
        end
        println(counter(collect(ns)))
        s = ns
    end
end
