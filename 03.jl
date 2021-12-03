open("03.txt") do f
    ns = readlines(f) .|> l->parse.(Bool, collect(l))
    common_bit(bits) = 2 * sum(bits) ≥ length(bits)
    int(bits) = sum(bits .* 2 .^ (length(bits)-1:-1:0))
    gamma = [common_bit([n[i] for n ∈ ns]) for i ∈ eachindex(ns[1])]
    println("Part 1: ", int(gamma) * int(.!gamma))

    ns2 = deepcopy(ns)
    for i ∈ eachindex(ns[1])
        c = common_bit([n[i] for n ∈ ns])
        filter!(n->n[i]==c, ns)
        length(ns) == 1 && break
    end
    for i ∈ eachindex(ns2[1])
        c = !common_bit([n[i] for n ∈ ns2])
        filter!(n->n[i]==c, ns2)
        length(ns2) == 1 && break
    end
    println("Part 2: ", int(ns[1]) * int(ns2[1]))
end
