padre(juan, luis).
padre(juan, lia).
padre(luis, jorge).
padre(luis, ines).
padre(jorge, diego).

abuelo_paterno(X, Y):-
    padre(X, Z),
    padre(Z, Y).

madre(ana,luis).
madre(lia,maria).
madre(lia,rosa).

abuelo_materno(X, Y):-
    padre(X, Z),
    madre(Z, Y).

abuelo(X,Y):- abuelo_paterno(X,Y).
abuelo(X,Y):- abuelo_materno(X,Y).

hermano(H_1, H_2):-
    (
        (padre(P, H_1) , padre(P, H_2));
        (madre(M, H_1) , madre(M, H_2))
    ),
    H_1 \= H_2.

tio(Tio, Sobrino):-
    hermano(Tio, Progenitor),
    (madre(Progenitor, Sobrino) ; padre(Progenitor, Sobrino)).

ancestro(Ancestro, Descendiente):- madre(Ancestro, Descendiente).
ancestro(Ancestro, Descendiente):- padre(Ancestro, Descendiente).
ancestro(Ancestro, Descendiente):-
    (madre(Ancestro, DescDirecto) ; padre(Ancestro, DescDirecto)),
    ancestro(DescDirecto, Descendiente).
