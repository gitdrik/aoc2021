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

    # Number of 3 to 9 points for a roll
    diracdice = [1, 3, 6, 7, 6, 3, 1]
    # Number of universes at each position and score
    # One row per position, one column per score, 0 score in pos 0
    scoreboards = [zeros(BigInt, 10, 32), zeros(BigInt, 10, 32)]
    scoreboards[1][4, 1] = 1
    scoreboards[2][5, 1] = 1
    wins = Array{BigInt}([0, 0])
    for t ∈ Iterators.countfrom(1)
        roller = isodd(t) ? 1 : 2
        other  = isodd(t) ? 2 : 1
        newboard = zeros(BigInt, 10, 32)
        for points ∈ 1:21
            for pos ∈ 1:10
                n = scoreboards[roller][pos, points]
                for i ∈ 3:9
                    npos = mod1(pos+i, 10)
                    newpoints = points + npos
                    newboard[npos, newpoints] += n * diracdice[i-2]
                end
            end
        end
        scoreboards[roller] = newboard
        # Increse number of universes also in other player
        scoreboards[other] .*= 27
        # compute winners
        rollerwins = sum(scoreboards[roller][:,22:32])
        wins[roller] += rollerwins
        # Remove loosers
        scoreboards[other] -= (scoreboards[other] .* rollerwins) ./ sum(scoreboards[roller])
        # Remove winners
        scoreboards[roller][:,22:32] .= 0
        sum(scoreboards[roller])==0 && break
    end
    println("Part 2: ", maximum(wins))
end
dirac()
