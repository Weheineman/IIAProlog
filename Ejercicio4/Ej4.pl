jugador(pedro,9).
jugador(pablo,10).
jugador(cristian,9).
jugador(susana,9).

torneo(X, Y):-
    jugador(X, 9),
    jugador(Y, 9),
    X @< Y.
