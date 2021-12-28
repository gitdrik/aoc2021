open("25.txt") do f
    S = [collect(l) for l ∈ readlines(f)]
    rows, cols = length(S), length(S[1])
    movement = true
    steps = 0
    while movement
        steps += 1
        movement = false
        oS = deepcopy(S)
        for row ∈ 1:rows, col ∈ 1:cols
            oS[row][col] ≠ '>' && continue
            oS[row][mod1(col+1, cols)] ≠ '.' && continue
            movement = true
            S[row][col] = '.'
            S[row][mod1(col+1, cols)] = '>'
        end
        oS = deepcopy(S)
        for row ∈ 1:rows, col ∈ 1:cols
            oS[row][col] ≠ 'v' && continue
            oS[mod1(row+1, rows)][col] ≠ '.' && continue
            movement = true
            S[row][col] = '.'
            S[mod1(row+1, rows)][col] = 'v'
        end
    end
    println("Part 1: ", steps)
end
