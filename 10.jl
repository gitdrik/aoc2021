open("10.txt") do f
    points = Dict(')'=>3, ']'=> 57, '}' => 1197, '>' => 25137)
    points2 = Dict('(' => 1, '[' => 2, '{' => 3, '<' => 4)
    pairs = Dict('('=>')', '['=> ']', '{' => '}', '<' => '>')
    p1, P2 = 0, []
    for l ∈ eachline(f)
        S = []
        bad = false
        for c ∈ l
            if c ∈ keys(pairs)
                push!(S, c)
            else
                open = pop!(S)
                c == pairs[open] && continue
                p1 += points[c]
                bad = true
                break
            end
        end
        if !bad
            p2 = 0
            for c ∈ reverse(S)
                p2 = p2*5 + points2[c]
            end
            push!(P2, p2)
        end
    end
    println("Part 1: ", p1)
    println("Part 2: ", sort(P2)[(length(P2)+1)÷2])
end
