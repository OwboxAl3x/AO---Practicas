ball = sphere radius:10 wireColor:blue segs:16
caja1= box length:20 width:20 height:0
caja2= box length:20 width:20 height:0
caja3= box length:20 width:20 height:0
caja4= box length:20 width:20 height:0

caja1.pos = [-40,30,0]
caja2.pos = [28,23,0]
caja3.pos = [35,-30,0]
caja4.pos = [-40,-35,0]
ball.pos = caja1.pos

addModifier ball (Stretch name:"Stretch")

fn interpolacion Traveler CP1 CP2 Inicio Fin= 
(
	PuntoMedio = (CP2+CP1)/2
	AB = (CP2-CP1)
	PuntoMedio.z = sqrt(AB.x^2+AB.y^2+AB.z^2)
	V1 = (PuntoMedio-CP1)
	V2 = (CP2-PuntoMedio)

	animate on
	(
		for t in Inicio to Fin by 1 do
		(
			at time t
			(
				Q0 = CP1 + ((normalize V1)*(((length V1)/(Fin-Inicio))*(t-Inicio)))
				Q1 = PuntoMedio + ((normalize V2)*(((length V2)/(Fin-Inicio))*(t-Inicio)))
				VectorSalto = (Q1-Q0)
				
				Traveler.pos = Q0 + ((normalize VectorSalto)*(((length VectorSalto)/(Fin-Inicio))*(t-Inicio)))
			)
		)
	)
)

fn rellenaKeys Traveler Inicio Fin puntos vec=
(
	animate on
	(
		for t in Inicio to Fin by 1 do
		(
			at time t
			(
				if (t == Inicio or t == Fin or (t == (Fin+Inicio)/2 and puntos == 3) or ((t == ((Fin-Inicio)/3)+Inicio or t == (2*(Fin-Inicio)/3)+Inicio) and puntos == 4)) do
				(
					Traveler.rotation.x_rotation = 0.0
					Traveler.modifiers[#Stretch].Stretch = -0.15
				)
				if (t == Inicio+1 or (t == ((Fin+Inicio)/2)+1 and puntos == 3) or ((t == ((Fin-Inicio)/3)+Inicio+1 or t == (((Fin-Inicio)/3)*2)+Inicio+1) and puntos == 4)) do
				(
					if t == (Inicio+1) then
					(
						Traveler.dir = vec[1]
					)
					if (puntos == 3 and t == ((Fin+Inicio)/2)+1) or (puntos == 4 and t == ((Fin-Inicio)/3)+Inicio+1) do
					(
						Traveler.dir = vec[2]
					)
					if puntos == 4 and t == (((Fin-Inicio)/3)*2)+Inicio+1 do
					(
						Traveler.dir = vec[3]
					)

					Traveler.rotation.x_rotation = 20.0
					Traveler.modifiers[#Stretch].Stretch = 0.3
				)
				if (t == Fin-1 or (t == ((Fin+Inicio)/2)-1 and puntos == 3) or ((t == ((Fin-Inicio)/3)+Inicio-1 or t == (((Fin-Inicio)/3)*2)+Inicio-1) and puntos == 4)) do
				(
					Traveler.rotation.x_rotation = -20.0
					Traveler.modifiers[#Stretch].Stretch = 0.2
				)
				if (t == (Fin+Inicio)/2 and (puntos == 2 or puntos == 4)) or (puntos == 3 and (t == (((Fin+Inicio)/2)+Inicio)/2 \
					or t == (((Fin+Inicio)/2)+Fin)/2)) or (puntos == 4 and (t == (Fin-Inicio)/6+Inicio or t == (5*Fin+Inicio)/6)) do
				(
					Traveler.modifiers[#Stretch].Stretch = 0.0
				)
			)
		)
	)
)

rollout Salto "Salto"
(
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	multilistbox UI_SelectorPs "Selecciona los puntos" items:(for o in objects collect o.name)
	
	spinner UI_IF "Comienzo" range:[0,1000,0] type:#Integer
	spinner UI_FF "Duracion" range:[5,100,60] type:#Integer
	button UI_CrearSalto "Crear"
	
	on UI_SelectorActor picked obj do
	(
		global Traveler = obj
		UI_SelectorActor.text = obj.name
	)
	on UI_SelectorPs selected val do
	(
		format "selected: % - %\n" val UI_SelectorPs.selection[val]
		if UI_SelectorPs.selection[2] == true do
			global P1 = caja1
		if UI_SelectorPs.selection[3] == true do
			global P2 = caja2
		if UI_SelectorPs.selection[4] == true do
			global P3 = caja3
		if UI_SelectorPs.selection[5] == true do
			global P4 = caja4
	)
	
	on UI_CrearSalto pressed do
	(
		  if Traveler!= undefined do
		  (
			deletekeys ball
			  
			Traveler.dir = [0,0,1]
			  
			local puntos = 0
			  
			vec = #()
			  
			if (P1!= undefined and P2!= undefined and P3!= undefined and P4!= undefined) then
			(
				interpolacion Traveler P1.pos P2.pos UI_IF.value ((UI_FF.value/3)+UI_IF.value)
				interpolacion Traveler P2.pos P3.pos ((UI_FF.value/3)+UI_IF.value) ((2*UI_FF.value/3)+UI_IF.value)
				interpolacion Traveler P3.pos P4.pos ((2*UI_FF.value/3)+UI_IF.value) (UI_IF.value+UI_FF.value)
				
				puntos = 4
				
				vec[1] = (P2.pos-P1.pos)
				vec[2] = (P3.pos-P2.pos)
				vec[3] = (P4.pos-P3.pos)
			)
			else if (P1!= undefined and P2!= undefined and P3!= undefined) then
			(
				interpolacion Traveler P1.pos P2.pos UI_IF.value (((UI_IF.value+UI_FF.value)+UI_IF.value)/2)
				interpolacion Traveler P2.pos P3.pos (((UI_IF.value+UI_FF.value)+UI_IF.value)/2) (UI_IF.value+UI_FF.value)
				
				puntos = 3
				
				vec[1] = (P2.pos-P1.pos)
				vec[2] = (P3.pos-P2.pos)
			)
			else if (P1!= undefined and P2!= undefined) then
			(
				interpolacion Traveler P1.pos P2.pos UI_IF.value (UI_IF.value+UI_FF.value)
				
				puntos = 2
				
				vec[1] = (P2.pos-P1.pos)
			)
			
			 if (P1!= undefined and P2!= undefined) then
			(
				rellenaKeys Traveler UI_IF.value (UI_IF.value+UI_FF.value) puntos vec
			)
			  
			Traveler.showtrajectory = on
				
			format "% puntos\n" puntos
			
			Traveler = undefined
			P1 = undefined
			P2 = undefined
			P3 = undefined
			P4 = undefined
		  )
    )
)

createDialog Salto

