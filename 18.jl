open("18.txt") do f
    homework = readlines(f)

    function explode(s)
        depth = 0
        for i ∈ eachindex(s)
            s[i] == '[' && (depth += 1)
            s[i] == ']' && (depth -= 1)
            if depth > 4 #BOOM
                if s[i+2] ∈ '0':'9'
                    n1 = parse(Int, s[i+1:i+2])
                    j = i + 4
                else
                    n1 = parse(Int, s[i+1:i+1])
                    j = i + 3
                end
                if s[j+1] ∈  '0':'9'
                    n2 = parse(Int, s[j:j+1])
                    k = j+2
                else
                    n2 = parse(Int, s[j:j])
                    k = j+1
                end
                #cut away pair, push n1 and n2 outwards
                sl, sr = s[1:i-1], s[k+1:end]
                for l ∈ length(sl):-1:1
                    sl[l] ∉ '0':'9' && continue
                    l2 = sl[l-1] ∈ '0':'9' ?  l-1 : l
                    sl = sl[1:l2-1]*string(n1+parse(Int, sl[l2:l]))*sl[l+1:end]
                    break
                end
                for l ∈ 1:length(sr)
                    sr[l] ∉  '0':'9' && continue
                    l2 = sr[l+1] ∈ '0':'9' ? l+1 : l
                    sr = sr[1:l-1]*string(n2+parse(Int, sr[l:l2]))*sr[l2+1:end]
                    break
                end
                return sl*"0"*sr
            end
        end
        return s
    end

    function splitbig(s)
        for i ∈ 1:length(s)-2
            (s[i] ∉ '0':'9' || s[i+1] ∉ '0':'9') && continue
            n = parse(Int, s[i:i+1])
            n1 = n÷2
            n2 = (n+1)÷2
            return s[1:i-1] * "[" *  string(n1) * "," * string(n2) *"]" * s[i+2:end]
        end
        return s
    end

    function fishsum(homework)
        fs = homework[1]
        for i ∈ 2:length(homework)
            fs = '[' * fs * ',' * homework[i] * ']'
            while true
                while true
                    nfs = explode(fs)
                    nfs == fs && break
                    fs = nfs
                end
                nfs = splitbig(fs)
                nfs == fs && break
                fs = nfs
            end
        end
        return eval(Meta.parse(fs))
    end

    function magnitude(r)
        typeof(r) == Int && return r
        return 3*magnitude(r[1]) + 2*magnitude(r[2])
    end

    println("Part 1: ", magnitude(fishsum(homework)))

    p2 = 0
    for i ∈ eachindex(homework), j ∈ i+1:length(homework)
        p2 = max(p2, magnitude(fishsum([homework[i], homework[j]])))
        p2 = max(p2, magnitude(fishsum([homework[j], homework[i]])))
    end
    println("Part 2: ", p2)
end
