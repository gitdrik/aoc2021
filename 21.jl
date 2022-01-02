function dirac()
    pos, score, dice, p, rolls = [4, 5], [0, 0], 0, 1, 0
    while maximum(score) < 1000
        for i ∈ 1:3
            dice = mod1(dice + 1, 100)
            rolls += 1
            pos[p] = mod1(pos[p] + dice, 10)
        end
        score[p] += pos[p]
        p = mod1(p+1, 2)
    end
    println("Part 1: ", minimum(score)*rolls)

    diracdice = [1, 3, 6, 7, 6, 3, 1]  # Number of 3 to 9 points for a roll
    # Scoreboards, one per player, keeping track of number of universes at each position and score.
    # Position (1-10) in rows, score (0-30) in column (1-31)
    scoreboard = [zeros(BigInt, 10, 31), zeros(BigInt, 10, 31)]
    scoreboard[1][4, 1] = 1
    scoreboard[2][5, 1] = 1
    wins = Array{BigInt}([0, 0])
    for t ∈ Iterators.countfrom(1)
        roller = isodd(t) ? 1 : 2
        other  = isodd(t) ? 2 : 1
        # Roller rolls with diracdice, creating 27 new universes from every
        # previous universe.
        newboard = zeros(BigInt, 10, 31)
        for points ∈ 1:21, pos ∈ 1:10
            n = scoreboard[roller][pos, points]
            for i ∈ 3:9
                npos = mod1(pos+i, 10)
                newpoints = points + npos
                newboard[npos, newpoints] += n * diracdice[i-2]
            end
        end
        scoreboard[roller] = newboard
        # Increse number of universes also in other player
        scoreboard[other] .*= 27
        # Count winners
        rollerwins = sum(scoreboard[roller][:,22:31])
        wins[roller] += rollerwins
        # Remove loosers from game
        scoreboard[other] -= (scoreboard[other] .* rollerwins) .÷ sum(scoreboard[roller])
        # Remove winners from game
        scoreboard[roller][:,22:31] .= 0
        sum(scoreboard[roller])==0 && break
    end
    println("Part 2: ", maximum(wins))
end
dirac()
