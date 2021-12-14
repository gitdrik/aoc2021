using Counters
open("14.txt") do f
    s = readline(f)
    readline(f)
    d = Dict(l[1:2]=>l[7] for l ∈ eachline(f))

    for i ∈ 1:10
        ns = ""
        for j ∈ 1:length(s)-1
            ns *= s[j]*d[s[j:j+1]]*s[j+1]
        end
        println(counter(collect(ns)))
        s = ns
    end
end
