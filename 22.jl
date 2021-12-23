open("22.txt") do f
    C = []
    for l ∈ readlines(f)
        ss = split(l, r"=|\.\.|,| ")
        push!(C, (on = ss[1]=="on",
            xr = parse(Int, ss[3]):parse(Int, ss[4]),
            yr = parse(Int, ss[6]):parse(Int, ss[7]),
            zr = parse(Int, ss[9]):parse(Int, ss[10])))
    end

    function subtract(a, b) # Substracts b from a
        intersection = [a[1]∩b[1], a[2]∩b[2], a[3]∩b[3]]
        intersection == a && return []
        any(isempty.(intersection)) && return [a]
        left   = [a[1].start:b[1].start-1, a[2], a[3]]
        right  = [b[1].stop+1:a[1].stop, a[2], a[3]]
        top    = [a[1]∩b[1], b[2].stop+1:a[2].stop, a[3]]
        bottom = [a[1]∩b[1], a[2].start:b[2].start-1, a[3]]
        front  = [a[1]∩b[1], a[2]∩b[2], a[3].start:b[3].start-1]
        back   = [a[1]∩b[1], a[2]∩b[2], b[3].stop+1:a[3].stop]
        return filter(a->all((!isempty).(a)), [left, right, top, bottom, front, back])
    end

    volume(a) = prod(length.(a))

    lights = []
    for (i, c) ∈ enumerate(C)
        nlights::Vector{Vector{UnitRange{Int64}}} = c.on ? [[c.xr, c.yr, c.zr]] : []
        for l ∈ lights
            append!(nlights, subtract(l, [c.xr, c.yr, c.zr]))
        end
        lights = nlights
        i == 20 && println("Part 1: ", sum(volume.(lights)))
    end
    println("Part 2: ", sum(volume.(lights)))
end
