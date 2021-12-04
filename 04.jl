open("04.txt") do f
    ns = parse.(Int, split(readline(f), ','))
    B = []
    while !eof(f)
        readline(f)
        board = Array{Int}(undef, 5, 5)
        for i ∈ 1:5
            board[i,:] = parse.(Int, split(readline(f)))
        end
        numbers = Set(board)
        rows = [Set(board[i,:]) for i ∈ 1:5]
        cols = [Set(board[:,i]) for i ∈ 1:5]
        push!(B, [numbers, rows, cols])
    end

    wins = Set{Int}()
    lastwin = 0
    for n ∈ ns, i ∈ eachindex(B)
        i ∈ wins && continue
        win = false
        delete!(B[i][1], n)
        for j ∈ 1:5
            delete!(B[i][2][j], n)
            delete!(B[i][3][j], n)
            win = (isempty(B[i][2][j]) || isempty(B[i][3][j]))
            win && break
        end
        if win
            lastwin = sum(B[i][1]) * n
            isempty(wins) && println("Part 1: ", lastwin)
            push!(wins, i)
        end
    end
    println("Part 2: ", lastwin)
end
