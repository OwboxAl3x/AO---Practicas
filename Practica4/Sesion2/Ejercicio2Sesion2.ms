bola = sphere radius:10 wireColor:blue segs:16
animate on
( 
	at time 0   bola.pos = [0,-100,0]
	at time 100 bola.pos = [0,100,0]
)

toro = torus radius1: 10 radius2:2 wireColor:red segs:16
rot_toro = eulerangles 180 0 0
animate on for t in 0 to 100 by 5 do
	at time t
( 
	toro.pos = bola.pos
	at time 100 rotate toro rot_toro
)

bola2 = sphere radius: 5  wireColor:red segs:16
animate on for t in 0 to 100 by 5 do
	at time t
( 
	bola2.pos = toro.pos + random [-15,-15,15] [15,15,15]
)