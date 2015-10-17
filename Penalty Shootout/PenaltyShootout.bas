 rem **************************************************************************
 rem Penalty Shootout
 rem Players switch turns being goalie and shooter 
 rem Player0 is the shooter at start
 rem Player1 is goalie at start 
 rem Shooter chooses a direction to shoot the ball (left, up, down)
 rem Goalie chooses a direction to dive to block the ball (left, up, down)
 rem right side of scoreboard is Player0's score; left side is Player1's score
 rem **************************************************************************

 set tv ntsc
 set romsize 4k

 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X....X...................X....X
 X.............................X
 X.............................X
 X.............................X
 X.............................X
 X.............................X
 X.............................X
 X.............................X
 X.............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

 player0:
 %00100010
 %00010100
 %00001000
 %00111110
 %00001000
 %00011100
 %00011100
 %00011100
end

 player1:
 %01000100
 %00101000
 %00010000
 %01111100
 %00010000
 %00111000
 %00111000
 %00111000
end

 COLUBK = $0F
 ballx = 79 : bally = 65
 NUSIZ0 = $30
 score = 00000 :  scorecolor = $08
 a = 0
 b = 0
 z = 0
 y = 0
 c = 0
 player0x = 75 : player0y = 75
 player1x = 75 : player1y = 25


main
 COLUP1 = $80
 COLUP0 = $40
 COLUBK = $C4
 COLUPF = $0E
 


draw
 drawscreen
 if joy0left then a = -1
 if joy0up then a = 0
 if joy0right then a = 1
 if joy1left then b = -1
 if joy1up then b = 0
 if joy1right then b = 1
 if joy0fire then z = 1
 if joy1fire then y = 1
 if z = 1 && y = 1 then goto shoot
 if switchreset then goto reset

 goto main

shoot
 if c = 1 then goto shoot2
 COLUP1 = $80
 COLUP0 = $40
 COLUBK = $C4
 COLUPF = $0E
 drawscreen
 bally = bally - 2
 ballx = ballx + a
 player1x = player1x + b
 if collision(ball, player1) || collision(ball, playfield) then goto aftershoot
 goto shoot

aftershoot
 if a = b then goto block
 score = score + 1
 goto switch1

block
 score = score + 1000
 goto switch1

switch1
 a = 0
 b = 0
 z = 0
 y = 0
 c = 1
 ballx = 79 : bally = 65
 player1x = 75 : player1y = 75
 player0y = 25
 goto main

shoot2
 COLUP1 = $80
 COLUP0 = $40
 COLUBK = $C4
 COLUPF = $0E
 drawscreen
 bally = bally - 2
 ballx = ballx + b
 player0x = player0x + a
 if collision(ball, player0) || collision(ball, playfield) then goto aftershoot2
 goto shoot2

aftershoot2
 if a = b then goto block2
 score = score + 1000
 goto switch2

block2
 score = score + 1
 goto switch2

switch2
 a = 0
 b = 0
 z = 0
 y = 0
 c = 0
 ballx = 79 : bally = 65
 player0x = 75 : player0y = 75
 player1y = 25
 goto main

reset
  COLUBK = $0F
 ballx = 79 : bally = 65
 NUSIZ0 = $30
 score = 00000 :  scorecolor = $08
 a = 0
 b = 0
 z = 0
 y = 0
 c = 0
 player0x = 75 : player0y = 75
 player1x = 75 : player1y = 25
 goto main


