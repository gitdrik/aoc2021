function solve()
    # Part 1, manual optimal play gave sequence
    # [3, 6, 60, 30, 6000, 6000, 600, 30, 60, 700, 3, 3]
    println("Part 1: ", sum([3, 6, 60, 30, 6000, 6000, 600, 30, 60, 700, 3, 3]))

    #  #############
    #  #...........#
    #  ###A#D#A#B###
    #    #D#C#B#A#
    #    #D#B#A#C#
    #    #C#C#D#B#
    #    #########
    paths = [ # paths[room][hall] = (steps, betweens)
        [(3,[2]), (2,[]), (2,[]), (4,[3]), (6,[3,4]), (8,[3,4,5]), (9,[3,4,5,6])],
        [(5,[2,3]), (4,[3]), (2,[]), (2,[]), (4,[4]), (6,[4,5]), (7,[4,5,6])],
        [(7,[2,3,4]), (6,[3,4]), (4,[4]), (2,[]), (2,[]), (4,[5]), (5,[5,6])],
        [(9,[2,3,4,5]), (8,[3,4,5]), (6, [4,5]), (4,[5]), (2,[]), (2,[]), (3,[6])]
    ]

    rooms = [[1,4,4,3], [4,3,2,3], [1,2,1,4], [2,1,3,2]]
    home = [0, 0, 0, 0] #No of pods thats reached home
    hall = Dict{Int, Int}() #Hall position to pod type

    function move(rooms, home, hall, energy)
        home = deepcopy(home)
        # Step 1. Walk home all pods that can
        while true
            nomoves = true
            for r ∈ eachindex(rooms)
                !isempty(rooms[r]) && continue
                for (h, p) ∈ hall
                    p ≠ r && continue
                    steps, between = paths[r][h]
                    if isempty(between ∩ keys(hall))
                        nomoves = false
                        energy += (steps + 3 - home[p]) * 10^(p-1)
                        home[p] += 1
                        delete!(hall, h)
                        break
                    end
                end
            end
            nomoves && break
        end
        all(home .== 4) && return energy

        # Step 2. Take out pod and calc new energies.
        minenergy = typemax(Int)
        for r ∈ eachindex(rooms)
            isempty(rooms[r]) && continue
            for h ∈ 1:7
                h ∈ keys(hall) && continue
                steps, between = paths[r][h]
                if isempty(between ∩ keys(hall))
                    nextenergy = energy + (steps + 4 - length(rooms[r])) * 10^(rooms[r][1]-1)
                    nexthall = deepcopy(hall)
                    nexthall[h] = rooms[r][1]
                    nextrooms = deepcopy(rooms)
                    popfirst!(nextrooms[r])
                    minenergy = min(minenergy, move(nextrooms, home, nexthall, nextenergy))
                end
            end
        end
        return minenergy
    end
    println("Part 2: ", move(rooms, home, hall, 0))
end
solve()
