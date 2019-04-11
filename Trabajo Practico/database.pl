/*
    🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍
             emoji.pro
    emoji identification game.
    start with ?- emojinator.
    🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍
*/

encoding(utf8).


emojinator :- suponer(Emoji),
          write('El emoji que está buscando es '),
          write(Emoji),
          write('!'),
          nl,
          write('Quiere agregarlo a la base de datos? [si./no.]'),
          nl,
          read(Respuesta),
          ((Respuesta == si ; Respuesta == s) ->
              agregar ; !).
          % limpiar_base.

% Lista de emojis 📝
suponer(😂) :- 😂, !.
suponer(😭) :- 😭, !.
suponer(😡) :- 😡, !.
suponer(😍) :- 😍, !.
suponer(😩) :- 😩, !.
suponer(👌) :- 👌, !.
suponer(💯) :- 💯, !.
suponer(🔝) :- 🔝, !.
suponer(🍆) :- 🍆, !.
suponer(🍌) :- 🍌, !.
suponer(🍑) :- 🍑, !.
suponer(🍎) :- 🍎, !.
suponer(💦) :- 💦, !.
suponer(desconocido). % Si ninguno de los emojis conocidos matchea
                      % 🤔🤔🤔🤔🤔

% Reglas de identificacion 🧐
😂 :-   feliz,
        verificar(lagrimas).

😭 :-   smiley,
        not(feliz),
        verificar(lagrimas).

😡 :-   smiley,
        verificar(tiene_rojo).

😍 :-   feliz,
        verificar(tiene_rojo).

😩 :-   smiley,
        not(feliz),
        not(verificar(lagrimas)).

👌 :-   verificar(amarillo),
        verificar(mano).

💯 :-   simbolo,
        verificar(tiene_rojo).

🔝 :-   simbolo,
        verificar(azul).

🍆 :-   fruta_verdura.

🍌 :-   fruta_verdura,
        verificar(amarillo).

🍑 :-   fruta_verdura,
        verificar(ocote).

🍎 :-   fruta_verdura,
        verificar(tiene_rojo).

💦 :-   verificar(comida_bebida),
        verificar(azul).



% Clasificacion de Emojis 🔬
smiley   :- verificar(redondo),
            verificar(tiene_ojos), !.
smiley   :- verificar(expresa_emocion).
feliz    :- smiley,
            verificar(contento).
fruta_verdura :-
            verificar(comida_bebida),
            verificar(proviene_arbol).
simbolo  :- verificar(letras),!.
simbolo  :- verificar(numeros).


% I/O para obtener informacion. En particular las preguntas son si el
% emoji buscado cumple cierta caracteristica. La respuesta se guarda en la
% base de conocimiento. 💾💾💾💾

preguntar(Propiedad) :-
    write('El emoji cumple con la siguiente propiedad: '),
    write(Propiedad),
    write(' [si./no.] ? '),
    read(Respuesta),
    nl,
    ( (Respuesta == si ; Respuesta == s) ->
       asserta(cumple(Propiedad)) ;
       asserta(no_cumple(Propiedad)), fail).

:- dynamic cumple/1,no_cumple/1.

% Verificacion de propiedades.☑️ ☑️  En caso de no estar en la base de
% conocimiento, realiza una pregunta al usuario.❓❓❓
% Si recibe una lista, lo hace en el orden en el que recibe las propiedades
% hasta que alguna falle.
verificar_lista([]).

verificar_lista([H|T])  :-
    verificar(H),
    verificar_lista(T).

verificar(Propiedad)    :-
    (cumple(Propiedad)    -> true ;
    (no_cumple(Propiedad) -> fail ;
     preguntar(Propiedad))).

% Genera una lista con todas las propiedades cumplidas 👶✔️📝
lista_cumple(ListaVieja, [H|T]) :-
    cumple(H),
    not(member(H, ListaVieja)),
    lista_cumple([H|ListaVieja], T).

lista_cumple(_ListaVieja, []).

% Recibe una lista y aplica la funcion not() a cada elemento. ❌📝
negar_lista([], []).
negar_lista([H_1|T_1], [H_2|T_2]):-
    H_2 = not(H_1),
    negar_lista(T_1, T_2).

% Agrega el emoji ingresado por teclado a la base de conocimiento, con las
% propiedades especificadas en las preguntas (ocurre solo cuando no se
% encuentra un emoji acorde en la base de conocimiento). 🙄 ➡️ 📝
agregar :- write('Ingrese el emoji nuevo: '),
           read(Emoji),
           lista_cumple([], ListaCumple),
           asserta(Emoji :- verificar(ListaCumple)).




% Elimina de la base de conocimiento la informacion obtenida en las consultas
% 🗑️🗑️🗑️
limpiar_base :- retract(cumple(_)), fail.
limpiar_base :- retract(no_cumple(_)), fail.
limpiar_base.
