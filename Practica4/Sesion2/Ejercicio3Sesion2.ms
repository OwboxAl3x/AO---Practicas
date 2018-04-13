fn interpolacion Traveler CP1 CP2 CP3= 
(
	
V1 = (CP2-CP1)
V2 = (CP3-CP2)

animate on
(
	for t in 0 to 100 by 1 do
	(
		at time t
		(
			Q0 = CP1 + ((normalize V1)*(((length V1)/100)*t))
			Q1 = CP2 + ((normalize V2)*(((length V2)/100)*t))
			V3 = (Q1-Q0)
			Traveler.pos = Q0 + ((normalize V3)*(((length V3)/100)*t))
		)
		
	)
)
)

interpolacion $Ball $Box001.pos $Box002.pos $Box003.pos