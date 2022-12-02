extends Node2D
export (PackedScene) var characterSprite = null;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export (String) var text = "abcdcdbc"

# Called when the node enters the scene tree for the first time.
func _ready():
    drawText(text, 0)
    pass # Replace with function body.

var connections = []

var clickedItem = null


func _process(delta):
    update()
    #if (clickedItem != null):


func removeAllConnectionOfLetter(letter):
    for i in range(len(connections) - 1, -1, -1):
        var connection = connections[i]
        if (connection[0] == letter || connection[1] == letter):
            connections.remove(i)

func clearConnection():
    for letter in letters:
        letter.mousePressed = false
    clickedItem = null


func updateLetterIfMouse():

    for letter in letters:
        if (letter.containsPos(get_global_mouse_position())):
    
            letter.mousePressed = true

            if (clickedItem != null && clickedItem != letter):
                SignalManager.emit_signal("PlaySound", "plug")
                addConnection(letter, clickedItem)
                clickedItem = null
                isSolved()
            else:

                SignalManager.emit_signal("PlaySound", "grab")
                clickedItem = letter
                isSolved()
            return


func tryRemoveAllConnections():
    for letter in letters:
        if (letter.containsPos(get_global_mouse_position())):
            removeAllConnectionOfLetter(letter)
            isSolved()

func _input(event):
    if event is InputEventMouseButton:

        if event.button_index == BUTTON_LEFT and event.pressed:

            updateLetterIfMouse()

        if event.button_index == BUTTON_RIGHT and event.pressed:
            if (clickedItem == null):
                tryRemoveAllConnections()

            else:
                clearConnection()

            SignalManager.emit_signal("PlaySound", "cancel")
            #isSolved()
    


var rawLetters = []

var solveList = [
    ["a", "b", "c"],
    ["b", "c", "d"],
]

var basicSolvers = [
    ["a", "b", "c"],
    ["b", "c", "d"],
]

var complexSolvers = [
    ["a", "b", "c", "g"],
]

var complexSolvers2 = [
    ["a", "b", "h"],
    ["a", "b", "c"],

]

"""
var solveList = [
    ["a", "b", "c"], ["a", "b"], ["b", "c"], ["c", "a"],
    ["b", "c", "d"], ["b", "c"], ["c", "d"], ["d", "b"],
]
"""


func connectionPairContainsPair(connectionPairs, target):
    for pair in connectionPairs:
        if pair[0].character == target[0] and pair[1].character == target[1]: return true
        elif pair[0].character == target[1] and pair[1].character == target[0]: return true
    return false

func checkCycle(cycle, pairs):
    for i in range(0, len(cycle) - 1):
        if !connectionPairContainsPair(pairs, [cycle[i], cycle[i + 1]]):
            return false

    if !connectionPairContainsPair(pairs, [cycle[len(cycle)-1], cycle[0]]): return false
    return true

    #for item in cycle:

func arrayContainsSubarray(array, possibleSubarray):
    for x in possibleSubarray:
        if !(x in array): return false
    return true

func getNeededConnections():
    var connectionsNeeded = []
    for cycle in solveList:
        if arrayContainsSubarray(rawLetters, cycle):
            connectionsNeeded.append(cycle)
    return connectionsNeeded
 
func array2dContainsElem(arr2d, elem):
    for arr in arr2d:
        if elem in arr: return true
    return false

func getNeighbours(startIndex):
    var neighbours = []
    for connection in connections:
        if connection[0].id == startIndex: neighbours.append(connection[1].id)
        if connection[1].id == startIndex: neighbours.append(connection[0].id)
    return neighbours

func buildAdjacencyList(availableItems):
    var openSet = [] + availableItems
    var seenItems = {}
    var adjList = {}

    while len(openSet) != 0:

        var node = openSet.pop_back()
        seenItems[node] = true
        var neighbours = getNeighbours(node)
        adjList[node] = []

        for neighbour in neighbours:

            if !(neighbour in seenItems):
                openSet.push_front(neighbour)
            adjList[node].append(neighbour)
    return adjList


func areArraysTheSame(a, b):
    if len(a) != len(b): return false
    for i in range(0, len(a)):
        if a[i] != b[i]: return false
    return true

func areCyclesTheSame(a, b):
    if len(a) != len(b): return false
    var ac = [] + a
    for i in range(len(ac)):
        if areArraysTheSame(ac, b): return true
        ac.push_front(ac.pop_back())
    ac.invert()
    for i in range(len(ac)):
        if areArraysTheSame(ac, b): return true
        ac.push_front(ac.pop_back())
    return false



func isCycleASubCycleHelper(cycle, pc):

    for i in len(cycle) - len(pc):
        for r in len(pc):

            var isSubcycle = true
            for j in len(pc):
                if cycle[i + j] != pc[j]: isSubcycle = false
            if (isSubcycle):
                return true
            pc.push_back(pc.pop_front())

    return false
 

func isCycleASubCycle(cycle, possibleSubCycle):
    if len(cycle) < len(possibleSubCycle):
        return false

    var bigCycle = [] + cycle + cycle
    var pc = [] + possibleSubCycle
    if isCycleASubCycleHelper(bigCycle, pc): return true
    bigCycle.invert()
    if isCycleASubCycleHelper(bigCycle, pc): return true
    return false
    """
    var pc = [] + possibleSubCycle
    #This just prevents complicated if statements I can't be bothered with
    for i in len(cycle):
        var isSubcycle = true
        for j in len(pc):
            if bigCycle[i + j] != pc[j]: isSubcycle = false
        if (isSubcycle):
            return true
    # Cycles are valid if they are reversed, so need to check that case too.
    pc.invert()
    for i in len(cycle):
        var isSubcycle = true
        for j in len(pc):
            if bigCycle[i + j] != pc[j]: isSubcycle = false
        if (isSubcycle):
            return true
    return false
    """




func updateCycles(allCycles, newCycle):
    newCycle.pop_back() # Item in the back is the same as the front, so remove it.
    #print(newCycle)
    for cycle in allCycles:
        var isSame = areCyclesTheSame(cycle, newCycle)
        if (isSame):
            #print("Cycles are the same: " + str(cycle) + ", " + str(newCycle))
            return
        else:
            pass
            #print("Cycles are NOT the same: " + str(cycle) + ", " + str(newCycle))
        
    allCycles.append(newCycle)


func dfs(adj, start, node, visited, cycle, allCycles):
    if (node in visited && visited[node]):
        if (node == start):
            updateCycles(allCycles, cycle)
            #allCycles.append(cycle)
        return
    visited[node] = true
    if node in adj:
        for child in adj[node]:
            dfs(adj, start, child, visited, cycle + [child], allCycles)
    visited[node] = false

#func containsItem():

func indiceCycleToLetterCycle(cycle):
    var g = []
    for i in cycle:
        g.append(rawLetters[i - 1])
    return g

func doesListContainCycle(cycles, target):
    #print("cycles: " + str(cycles) + ", target: " + str(target))
    for cycle in cycles:
        if areCyclesTheSame(cycle, target):
            #print("Cycles MATCH!") 
            return true
        #print(cycle)
        #print(target)
    #print("Cycles DON'T MATCH")
    return false


    
func areCyclesValid(allCycles, neededCycles, hide2s=false):
    if len(allCycles) == 0: return false
    var moreThan2 = false
    var validCycles = []

    for cycle in allCycles:
        
        if hide2s:
            if len(cycle) <= 2: continue
            else:
                moreThan2 = true
            
        var isShorter = false
        for neededCycle in neededCycles:
            if len(cycle) <= len(neededCycle):
                isShorter = true
            
        if isShorter:
            if (!doesListContainCycle(neededCycles, indiceCycleToLetterCycle(cycle))): return false
        
    if hide2s:
        return moreThan2
    return true

func neededCyclesContainsCycle(neededCycles, cycle):

    var res = false
    for neededCycle in neededCycles:
        if (areCyclesTheSame(neededCycle, cycle)):
            res = true
            break
    #print("neededCycle: " + str(neededCycles) + ", ps: " + str(cycle) + ", o: " + str(res))
    return res

func cyclesContainSubcycle(cycleList, possibleSubcycle):
    for cycle in cycleList:
        if isCycleASubCycle(cycle, possibleSubcycle): return true
    return false

func getLongestArray(xs):
    var longest = null
    var length = 0
    for x in xs:
        if len(xs) > length:
            length = len(xs)
            longest = x
    return longest 

func checkLongCycle(longCycle, shortCycles):

    var longElementChecker = []
    for i in longCycle:
        longElementChecker.append(false)

    for shortCycle in shortCycles:
        if isCycleASubCycle(longCycle, shortCycle):
            #print("Cycle: " + str(shortCycle) + " is a subcycle")
            for element in shortCycle:
                longElementChecker[longCycle.find(element)] = true

        #else:
        #print("Cycle: " + str(shortCycle) + " is NOT a subcycle")
    #print(longElementChecker)

    for value in longElementChecker:
        if !value: return false


    return checkLongCycle2(longCycle, shortCycles)

func checkLongCycle2(longCycle, shortCycles):
    var pairs = []
    for i in range(0, len(longCycle) - 1):
        pairs.append([longCycle[i], longCycle[i + 1]])
    pairs.append([longCycle[len(longCycle) - 1], longCycle[0]])

    for pair in pairs:
        var isPairInShortCycles = false
        for cycle in shortCycles:
            if isCycleASubCycle(cycle, pair):
                isPairInShortCycles = true
                break
        if !isPairInShortCycles:
            return false
    return true


    """
    var longElementChecker = []
    for i in longCycle:
        longElementChecker.append(false)

    for shortCycle in shortCycles:
        if isCycleASubCycle(longCycle, shortCycle):
            print("Cycle: " + str(shortCycle) + " is a subcycle")
            for element in shortCycle:
                longElementChecker[longCycle.find(element)] = true

        else:
            print("Cycle: " + str(shortCycle) + " is NOT a subcycle")
    print(longElementChecker)

    for value in longElementChecker:
        if !value: return false

    return true
    """

#var validLongCycles = []
var storedValidLongCycles = []

func longCycleIsValid(cycleToCheck):
    for cycle in storedValidLongCycles:
        if (areCyclesTheSame(cycle, cycleToCheck)):
            return true
    return false
        #if len(cycleToCheck) <= cycle:
            #isCycleASubCycle(cycle, cycleToCheck)


func areCyclesValid2(allCycles, neededCycles, redundantValue=false):
    #print("storedValidLongCycles: " + str(storedValidLongCycles))
    if len(allCycles) == 0: return false
    var longerCycles = []
    var validCycles = []
    var otherCycles = []
    var maxNeededCycleLength = 100000
    var longestCycle = getLongestArray(neededCycles)
    #for cycle in allCycles:
        # if needed cycles contains cycle:
        #     valid cycles.append(cycle)
        # else if !validCycles contains subcycle (cycle):
        #     return false
    #return true
    #print("longest cycle: " + str(len(longestCycle)))

    for cycle in allCycles:
        #print("examining cycle: " + str(cycle))
        if len(cycle) > len(longestCycle):
            longerCycles.append(cycle)
        elif neededCyclesContainsCycle(neededCycles, indiceCycleToLetterCycle(cycle)):
            validCycles.append(cycle)
        elif !cyclesContainSubcycle(validCycles, cycle):
            otherCycles.append(cycle)
            #print("cycle" + str(cycle) + " not subcycle of: " + str(validCycles))
            #return false
    #print("storedValidSubCycles")
    #print("longer" + str(longerCycles))
    #print("valid: " + str(validCycles))
    #print("otherCycles: " + str(otherCycles))
    #var validLongCycles = []

    for i in range(len(longerCycles) - 1, -1, -1):
        var longCycle = longerCycles[i]
        if longCycleIsValid(longCycle):
            longerCycles.pop_back()
        elif checkLongCycle(longCycle, validCycles):
            storedValidLongCycles.append(longCycle)
            longerCycles.pop_back()


    """
    for longCycle in longerCycles:
        if longCycleIsValid(longCycle):
            validLongCycles.append(longCycle)
        elif checkLongCycle(longCycle, validCycles):
            validLongCycles.append(longCycle)
    """
    if len(longerCycles) != 0:
        return false
    #If there's any left over long cycles, then return
    #if (len(validLongCycles) <= len(longerCycles)):
    #    return false

    for otherCycle in otherCycles:
        if !cyclesContainSubcycle(storedValidLongCycles, otherCycle):
            return false

    return true
        #     return false
    #return true


func getCyclesThatContainElement(allCycles, indice):
    var t = []
    for cycle in allCycles:
        if indice in cycle:
            t.append(cycle)
    return t

func arrayLengthComparator(a, b):
    return len(a) < len(b)

func sortArraysBylength(arrays):
    arrays.sort_custom(self, "arrayLengthComparator")


func areConnectionsSolved():
    storedValidLongCycles = []
    var adjList = buildAdjacencyList(letterIndices)
    var visited = {}
    var allCycles = []

    for i in letterIndices:
        dfs(adjList, i,i, visited, [i], allCycles)
    
    var neededConnections = getNeededConnections()

    #print("----------------------")
    #print(allCycles)
    #print("needed cycles: " + str(neededConnections))

    sortArraysBylength(allCycles)
    allCycles.invert()

    var isValid = areCyclesValid2(allCycles, neededConnections)
    #print("isValid: " + str(isValid))
    #return isValid
    if !isValid: return false

    allCycles.invert()

    #print(allCycles)

    for i in range(0, len(letterIndices)):
        var indice = letterIndices[i]
        var letter = rawLetters[i]
        #print("exmaining letter: " + str(indice))
        if array2dContainsElem(neededConnections, letter):
            var cycles = getCyclesThatContainElement(allCycles, indice)
            #print("containing cycles: " + str(cycles))
            sortArraysBylength(cycles)
            cycles.invert()
            var res = areCyclesValid2(cycles,neededConnections, true)
            if (!res): return false
    return true

            
        


    #for index in range(letterIndices):
    #    var id = letterIndices[index]
    #    var rawLetter = rawLetters[index]



    #for cycle in allCycles:
    #    cycle.pop_back()
    #print("all cycles")
    #print(allCycles)
    #var neededConnections = getNeededConnections()
    #print("needed connectins")
    #print(neededConnections)
    #print(allCycles)

    """
    var neededConnections = getNeededConnections()
    var i = 0
    for rawLetter in rawLetters:
        if array2dContainsElem(neededConnections, rawLetter):
            if !checkIfIndexInCycle(i, neededConnections): return false
        i += 1
    return true
    """


    #for neededConnection in neededConnections:
    #    if !checkCycle(neededConnection, connections):
    #        return false
    #return true

var _lineIsSolvedVar = false

signal SolvedSignal(isItemSolved)

func lineIsSolved():
    return _lineIsSolvedVar

func isSolved():

    if "g" in rawLetters:
        solveList = complexSolvers
    elif "h" in rawLetters:
        solveList = complexSolvers2
    else:
        solveList = basicSolvers 

    var solved = areConnectionsSolved()
    #print("solved: " + str(solved))
    if (solved):
        SignalManager.emit_signal("PlaySound", "done")
        _lineIsSolvedVar = true
        for letter in letters:
            letter.done = true
        #print("Solved")
    else:
        _lineIsSolvedVar = false
        for letter in letters:
            letter.done = false
        #print("Not Solved")
    emit_signal("SolvedSignal", solved)

    


var lineWidth = 1


func addConnection(a, b):
    #if (a == b): 
    #    print("Can't add smae connection.")
    connections.append([a, b])

    drawConnection(to_local(a.global_position), to_local(b.global_position), lineColor, lineWidth)
    update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
export (Vector2) var cellSize = Vector2(16, 16);
export (float) var acrossWidth = 16;
var xGap = 2

func initAtlas(character, charIndex, pos):
    var t = characterSprite.instance()
    add_child(t);
    var x = int((charIndex * cellSize.x))%int(acrossWidth * cellSize.x)
    var y = floor(charIndex/acrossWidth) * cellSize.y;
    var rect = Rect2(x, y, cellSize.x, cellSize.y)
    #print(rect)
    t.texture.region = rect
    add_child(t)
    t.global_position = pos
    t.character = character
    return t

func lowerParabola(x, dist):
    return - (pow(2 * x * 1.0/dist - 1.0, 2) - 1)
    #return x * x - (dist + 1) * x


func drawParabola(p1, p2, color, width):
    var segmentSize = 0.01;
    var currentStartPoint = p1;
    var t = 0;
    var xDist = (p2.x - p1.x)
    var yHeight = (p2.y - p1.y)
    var yDist = 15

    var startPos = p1;
    var lastDist = 100000
    var segmentCount = 20
    var heading = p2 - p1
    var increment = heading/segmentCount
    var totalLength = heading.length()
    var dir = heading/totalLength
    var orthAngle = Vector2(-dir.y, dir.x)
    if (orthAngle.dot(Vector2.UP) > 0):
        orthAngle *= -1
    var lastPoint = p1

    var counter = 0
    var runningPoint = p1

    var hangMod = abs(p1.x - p2.x)/40

    var minHang = 4
    var maxHang = 15

    var spaceOffset = clamp(inverse_lerp(0, 40, abs(p1.y - p2.y)), 0, 1)
    var hang = lerp(maxHang, minHang, spaceOffset) * hangMod



    while true:
        counter += 1
        if (counter > 1000):
            break
        runningPoint += increment
        var point = runningPoint
        var curerntLength = (p2 - point).length()
        if (curerntLength > lastDist):
            break
        lastDist = curerntLength
        #var moveDirection = 
        var offsetAmount = lowerParabola(curerntLength/totalLength, 1) * hang
        point += orthAngle * offsetAmount
        #draw_line(lastPoint, point, color, width)
        draw_line(lastPoint, point, color, width)
        lastPoint = point

    """
    while t < 1-segmentSize:
        t += segmentSize
        var endY = lowerParabola(t, -yHeight) 
        var currentEnd = Vector2(p1.x + t * xDist, p1.y + endY * -30)
        print("currentStartPoint: " + str(currentStartPoint))
        draw_line(currentStartPoint, currentEnd, color, width)
        currentStartPoint = currentEnd
    """

func drawConnection(p1, p2, color, width):

    draw_circle(p1, connectionCircleSize, color)
    draw_circle(p2, connectionCircleSize, color)
    drawParabola(p1, p2, color, width)

var connectionOfset = Vector2(0, 15)
var connectionCircleSize = 2

var lineColor = Color8(255, 251, 228)

func _draw():
    #drawConnection(Vector2(0, 0), Vector2(50, 0), Color(0, 255, 255), 1)
    for item in connections:
        var a = item[0]
        var b = item[1]
        drawConnection(
            to_local(a.global_position + connectionOfset), 
            to_local(b.global_position + connectionOfset + Vector2(0, 0)), 
            lineColor,
            lineWidth)

    if (clickedItem != null):
        drawConnection(
            to_local(clickedItem.global_position + connectionOfset), 
            to_local(get_global_mouse_position()), 
            lineColor,
            1)

var letters = []
var letterIndices = []



func drawText(text, yPos):
    var offset = ord("a")
    var i = 1;
    var totalWidth = (len(text) - 1) * (xGap) + cellSize.x * len(text)
    var xOffset = -totalWidth/2.0 - cellSize.x/2
    for character in text:
        rawLetters.append(character)
        letterIndices.append(i)
        var index = ord(character) - offset
        #var letter = initAtlas(character, index, global_position + Vector2(xOffset + i * cellSize.x + i * xGap, yPos))
        var letter = initAtlas(character, index, global_position + Vector2(xOffset + i * cellSize.x + i * xGap, yPos))
        letters.append(letter)
        letter.textNode = self
        letter.id = i
        letter.character = character
        i+=1
    #addConnection(letters[0], letters[3])
    #addConnection(letters[2], letters[6])
    
