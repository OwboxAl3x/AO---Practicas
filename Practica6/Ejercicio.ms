plano = $Plane001
pelota = $Sphere001
pelotaSombra = $Sphere002

deletekeys pelotaSombra

fn pegarPelota pelota plano=
(
	animate on
	(
		for t in 0 to 400 by 1 do
		(
			at time t
			(
				
				-- Colisión y posición de la pelota
				rayo = ray pelota.pos [0,0,-1]
				colision = IntersectRay plano rayo
				if colision != undefined do
				(
					pelotaSombra.pos = colision.pos + ((normalize colision.dir) * pelota.radius)
				)
				
				-- Dirección de la pelota
				vectorDir = pelotaSombra.pos - (at time (t-1) (pelotaSombra.pos))
					
				-- Rotación de la pelota
				vectorRot = cross vectorDir colision.dir
				anguloRot = (length vectorDir / (pelotaSombra.radius * pi)) * 180
				Quaternion = quat anguloRot (normalize vectorRot)
				RotEuler = QuatToEuler Quaternion
				rotate pelotaSombra RotEuler
				
			)
		)
	)
)

pegarPelota pelota plano