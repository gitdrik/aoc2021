open("12.txt") do f
    G = Dict{String, Set{String}}()
    for l ∈ eachline(f)
        a, b = split(l,'-')
        a ∉ keys(G) && (G[a] = Set())
        b ∉ keys(G) && (G[b] = Set())
        push!(G[a], b)
        push!(G[b], a)
    end

    paths = 0
    function explore(pos, smalls, twice)
        if pos=="end"
            paths += 1
        else
            twice = twice || pos ∈ smalls
            islowercase(pos[1]) && (smalls = smalls ∪ Set([pos]))
            for p ∈ setdiff(G[pos], twice ? smalls : Set(["start"]))
                explore(p, smalls, twice)
            end
        end
    end
    explore("start", Set{String}(), true)
    println("Part 1: ", paths)

    paths = 0
    explore("start", Set{String}(), false)
    println("Part 2: ", paths)
end
