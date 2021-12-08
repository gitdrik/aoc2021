using Bijections

open("08.txt") do f
    D = [split.(split(s,'|')) for s in eachline(f)]
    p1 = 0
    for (ss, out) ∈ D
        p1 += sum([length(d) ∈ Set([2,3,4,7]) for d ∈ out])
    end
    println("Part 1: ", p1)

    p2 = 0
    for (ss, out) ∈ D
        decode = Bijection{Set{Char}, Int}()
        charcount = Dict(Set(s) => length(s) for s ∈ ss)
        uniqueseg = Dict(v => k for (k,v) ∈ charcount)
        fives = [k for (k, v) ∈ charcount if v == 5]
        sixes = [k for (k, v) ∈ charcount if v == 6]
        decode[uniqueseg[2]] = 1
        decode[[s for s ∈ fives if decode(1) ⊆ s][1]] = 3
        decode[uniqueseg[4]] = 4
        decode[uniqueseg[3]] = 7
        decode[uniqueseg[7]] = 8
        decode[decode(3) ∪ decode(4)] = 9
        decode[[s for s ∈ sixes if decode(1) ⊈ s][1]] = 6
        decode[[s for s ∈ sixes if s ≠ decode(9) && s ≠ decode(6)][1]] = 0
        decode[[s for s ∈ fives if s ≠ decode(3) && s ∪ decode(4) == decode(8)][1]] = 2
        decode[[s for s ∈ fives if s ≠ decode(3) && s ≠ decode(2)][1]] = 5

        p2 += [decode[Set(o)] for o in out]' * [1000, 100, 10, 1]
    end
    println("Part 2: ", p2)
end
