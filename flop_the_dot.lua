-- Looks For A Monitor
local monitor = peripheral.find("monitor")
local deadZoneX, deadZoneY = 5, 6

if monitor == nil then
    printError("Please Connect a Monitor")
    return
end

term.setTextColour(colours.purple)
print("Monitor Detected... Starting Flop The Dot")

monitor.setTextScale(1)

-- Gets The Size of The Monitor
local width, height = monitor.getSize()
monitor.setCursorBlink(false)

function handleTouch(x, y)
    monitor.clear()
    monitor.setCursorPos(x, y)
end

-- Draws a Square
function drawSquare(x, y, size, colour)
    for i = x, x + size - 1 do
        for j = y, y + size - 1 do
            monitor.setCursorPos(i, j)
            monitor.setTextColour(colour)
            monitor.write("X")
        end
    end
end

-- Checks if the points match
function pointInSquare(x, y, squareX, squareY, squareSize)
    return x >= squareX and x < squareX + squareSize and y >= squareY and y < squareY + squareSize
end

-- Randomizes the Squares Position
function RandomizeSquare()
    return math.random(3, width - 2), math.random(deadZoneY, height - 2)
end

-- Centers the Text (monitor)
function monitorCentered(y, text)
    local centerX = math.floor((width - string.len(text)) / 2)
    monitor.setCursorPos(centerX, y)
    monitor.write(text)
end

-- Centers the Text (terminal)
function termCentered(y, text)
    local centerX = math.floor((width - string.len(text)) / 2)
    term.setCursotPos(centerX, y)
    term.write(text)
end

-- Some local variables
local squareX, squareY = RandomizeSquare()
local squareSize = 2
local score = 0

-- The Terminal Title
term.setTextColour(colours.orange)
print("Flop The Dot")
term.setTextColour(colours.red)
print("Screen Resolution:", width, height)

monitor.clear()

-- Shows The Start Information
monitor.setBackgroundColour(colours.black)
monitorCentered(8, "Right click and hold")
monitorCentered(9, "on the screen")
monitorCentered(10, "to play the game,")
monitorCentered(13, "Get That Score!")

-- The Main Program
while true do
    monitor.setTextColour(colours.orange)
    monitorCentered(2, "Flop The Dot")
    monitor.setTextColour(colours.purple)
    monitorCentered(4, string.format("Score: %d", score))
    local event, side, x, y = os.pullEvent("monitor_touch")
    handleTouch(x, y)
    drawSquare(x, y, 1, colours.lime)
    
    drawSquare(squareX, squareY, squareSize, colours.red)
    if pointInSquare(x, y, squareX, squareY, squareSize) then
        squareX, squareY = RandomizeSquare()
        score = score + 1
    end
end
