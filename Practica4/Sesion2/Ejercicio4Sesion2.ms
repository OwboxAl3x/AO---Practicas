fn interpolacion Traveler CP1 CP2 CP3 CP4= 
(
	
V1 = (CP2-CP1)
V2 = (CP3-CP2)
V3 = (CP4-CP3)

animate on
(
	for t in 0 to 100 by 1 do
	(
		at time t
		(
			Q0 = CP1 + ((normalize V1)*(((length V1)/100)*t))
			Q1 = CP2 + ((normalize V2)*(((length V2)/100)*t))
			V4 = (Q1-Q0)
			Q2 = CP3 + ((normalize V3)*(((length V3)/100)*t))
			V5 = (Q2-Q1)
			R0 = Q0 + ((normalize V4)*(((length V4)/100)*t))
			R1 = Q1 + ((normalize V5)*(((length V5)/100)*t))
			V6 = (R1-R0)
			Traveler.pos = R0 + ((normalize V6)*(((length V6)/100)*t))
		)
		
	)
)
)

interpolacion $Ball $Box001.pos $Box002.pos $Box003.pos $Box004.pos