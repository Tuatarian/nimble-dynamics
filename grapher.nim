import raylib, math, rayutils, rlgl, sugar, desolver, lenientops, sugar

const
    screenWidth = 1920
    screenHeight = 1080
    screenCenter = makevec2(screenWidth, screenHeight) / 2

InitWindow screenWidth, screenHeight, "John Nash's Hex"
SetTargetFPS 60

let
    xscale = [0, 10]
    totX = xscale[^1] - xscale[0]
    yscale = [0, 5]
    totY = yscale[^1] - yscale[0]
    gOrigin = makevec2(50, screenHeight - 50)
    gOriginU = makevec2(50, 50)
    gEndX = makevec2(screenWidth - 50, screenHeight - 50)
    gEndY = makevec2(50, 25)
    dt = 0.1
    scalevec = makevec2((screenWidth - 100)/totX, (screenHeight-75)/totY)

func diffeq(x : float) : float = sin(x) ## dx/dt = f(x)

func refVecY(pt: Vector2, screenHeight : int) : Vector2 =
    return makevec2(pt.x, screenHeight - pt.y)


while not WindowShouldClose():
    ClearBackground BGREY
    BeginDrawing()

    rlSetLineWidth 2
    DrawLineV(gOrigin, gEndX, WHITE)
    DrawLineV(gOrigin, gEndY, WHITE)
    rlSetLineWidth 1

    for i in 1..totX:
        let cLoc = (gEndX.x - gOrigin.x)*(i/totX) + gOrigin.x
        DrawLine(int cLoc, int gEndX.y - 10, int cLoc, int gEndX.y + 10, WHITE)
        drawTextCenteredX($(xscale[0] + i), int cLoc, int gEndX.y + 20, 30, WHITE)

    for i in 1..totY:
        let cLoc = (gEndY.y - gOrigin.y)*(i/totY) + gOrigin.y
        DrawLine(int gEndY.x - 10, int cLoc, int gEndY.x + 10, int cLoc, WHITE)
        drawTextCentered($(yscale[0] + i), int gEndY.x - 20, int cLoc, 30, WHITE)
    
    var xi = 1f
    var y = 0.1f
    for z in 0..totY:
        for j in 0..totX:
            y = float yscale[0] + z
            xi = float xscale[0] + j
            for i in 0..100:
                let y1 = RungeKutta4(diffeq, y, dt)
                let v1 = makevec2(xi, y) * scalevec + gOriginU
                let v2 = makevec2(xi + dt, y1) * scalevec + gOriginU
                DrawLineV(refVecY(v1, screenHeight), refVecY(v2, screenHeight), LEMMIRED)
                # if i == 0:
                #     echo refVecY(makevec2(2, 1)*scalevec + gOriginU, screenHeight), 10, GREEN
                #     DrawCircleV refVecY(makevec2(2, 1)*scalevec + gOriginU, screenHeight), 10, GREEN
                #     DrawCircleV refVecY(makevec2(xi+dt, xi+dt)*scalevec + gOrigin, screenHeight), 5, YELLOW
                xi += dt
                y = y1
        


    EndDrawing()
CloseWindow()