open("16.txt") do f
    B = BitArray([])
    for c ∈ readline(f)
        B = [B; BitArray(reverse(digits(parse(Int, "0x"*c), base=2, pad=4)))]
    end
    bits2int(bits) = bits' * [2^n for n ∈ length(bits)-1:-1:0]

    p1 = 0
    function pack(pos)
        ver = bits2int(B[pos:pos+2])
        p1 += ver
        ID = bits2int(B[pos+3:pos+5])
        if ID == 4 # value packe
            pos += 6
            vbits = []
            while true
                vbits = [vbits; B[pos+1:pos+4]]
                !B[pos] && break
                pos += 5
            end
            return pos+5, [ID, bits2int(vbits)]
        else # operator packet
            P = []
            if B[pos+6] #length type 1
                subpackets = bits2int(B[pos+7:pos+17])
                pos += 18
                for _ ∈ 1:subpackets
                    pos, p = pack(pos)
                    push!(P, p)
                end
            else #length type 0
                subbits = bits2int(B[pos+7:pos+21])
                pos += 22
                last = pos+subbits-1
                while pos ≤ last
                    pos, p = pack(pos)
                    push!(P, p)
                end
            end
            return pos, [ID, P]
        end
    end
    # Replacing name of PP with P, creates circular reference error!!
    # Same on 1.5.3 and 1.7.0 Why? Is this a bug?
    pos, PP = pack(1)
    println("Part 1: ", p1)

    function calc(P)
        P[1] == 4 && return P[2]
        P[1] == 0 && return sum(calc(p) for p in P[2])
        P[1] == 1 && return prod(calc(p) for p in P[2])
        P[1] == 2 && return minimum(calc(p) for p in P[2])
        P[1] == 3 && return maximum(calc(p) for p in P[2])
        P[1] == 5 && return Int(calc(P[2][1]) > calc(P[2][2]))
        P[1] == 6 && return Int(calc(P[2][1]) < calc(P[2][2]))
        P[1] == 7 && return Int(calc(P[2][1]) == calc(P[2][2]))
    end
    println("Part 2: ", calc(PP))
end
