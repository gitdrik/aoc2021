open("14.txt") do f
    s = readline(f)
    readline(f)
    d = Dict{String,String}()
    for l ∈ eachline(f)
        d[l[1:2]] = l[7]*l[2]
    end

    ns = s[1]
    for i ∈ 1:10
        for j ∈ 1:length(s)-1
            ns *= d[s[i:i+1]]
        end
        println(length(ns))
        s = ns
    end
end
