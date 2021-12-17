function newton()
    #target area: x=29..73, y=-248..-194
    tx, ty = 29:73, -248:-194
    println("Part 1: ", 248*247÷2)
    p2 = 0
    for i ∈ 8:73, j ∈ -248:247
        x, y = 0, 0
        dx, dy = i, j
        while x ≤ 73 && y ≥ -248
            x += dx
            y += dy
            if x ∈ tx && y ∈ ty
                p2 += 1
                break
            end
            dx -= sign(dx)
            dy -= 1
        end
    end
    println("Part 2: ", p2)
end
newton()
