tiene_tarjeta(chris, visa).
tiene_tarjeta(chris, diners).
tiene_tarjeta(sam, mastercard).
tiene_tarjeta(sam, citibank).

esta_vencida(chris, visa).
esta_vencida(chris, diners).
esta_vencida(sam, mastercard).

disfruta_compras(Persona):-
    tiene_tarjeta(Persona, Tarjeta),
    not(esta_vencida(Persona, Tarjeta)).
