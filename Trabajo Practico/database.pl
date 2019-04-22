/*
    🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍
            emoji.pro
    emoji identification game.
    start with ?- emojinator.
         Oriana Reschini
         Gianni Weinand
    🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍🧞‍
*/


% Funcion principal. En caso de que el emoji buscado no este en la base de
% datos, se da la opcion de agregarlo. Luego se limpian las relaciones
% cumple y no_cumple.
emojinator :- suponer(Emoji),
              write('El emoji que está buscando es '),
              write(Emoji),
              write('!'),
              (Emoji \== desconocido -> true;
                  nl,
                  write('Quiere agregarlo a la base de datos? [si./no.]'),
                  nl,
                  read(Respuesta),
                  ((Respuesta == si ; Respuesta == s) ->
                      agregar ; !)),
              limpiar_base.

% Lista de emojis. 📝
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
suponer(desconocido). % Si ninguno de los emojis conocidos matchea...
                      % 🤔🤔🤔🤔🤔
:- dynamic suponer/1.

% Reglas de identificacion. 🧐
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

🍆 :-   fruta_verdura,
        verificar(violeta).

🍌 :-   fruta_verdura,
        verificar(amarillo).

🍑 :-   fruta_verdura,
        verificar(carozo).

🍎 :-   fruta_verdura,
        verificar(tiene_rojo).

💦 :-   verificar(comida_bebida),
        verificar(azul).



% Clasificacion de Emojis. 🔬
smiley   :- verificar(redondo),
            verificar(tiene_ojos),
            verificar(expresa_emocion).
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
verificar(Propiedad)    :-
    (cumple(Propiedad)    -> true ;
    (no_cumple(Propiedad) -> fail ;
    preguntar(Propiedad))).

% Verifica que se cumplan todas las propiedades de una lista. ✔️📝
verificar_si_lista([]).

verificar_si_lista([H|T])  :-
    verificar(H),
    verificar_si_lista(T).

% Verifica que NO se cumpla ninguna de las propiedades de la lista. ❌📝
verificar_no_lista([]).

verificar_no_lista([H|T])  :-
    not(verificar(H)),
    verificar_no_lista(T).


% Genera una lista con todas las propiedades cumplidas. 👶✔️📝
lista_cumple(ListaVieja, [H|T]) :-
    cumple(H),
    not(member(H, ListaVieja)),
    lista_cumple([H|ListaVieja], T).

lista_cumple(_ListaVieja, []).

% Genera una lista con todas las propiedades NO cumplidas. 👶❌📝
lista_no_cumple(ListaVieja, [H|T]) :-
    no_cumple(H),
    not(member(H, ListaVieja)),
    lista_no_cumple([H|ListaVieja], T).

lista_no_cumple(_ListaVieja, []).

% Agrega el emoji ingresado por teclado a la base de conocimiento, con las
% propiedades especificadas en las preguntas (ocurre solo cuando no se
% encuentra un emoji acorde en la base de conocimiento). 🙄 ➡️ 📝
agregar :- write('Ingrese el emoji nuevo: '),
           read(Emoji),
           lista_cumple([], ListaCumple),
           write("El emoji cumple con: "),
           write(ListaCumple),
           nl,
           lista_no_cumple([], ListaNoCumple),
           write("El emoji NO cumple con: "),
           write(ListaNoCumple),
           nl,
           asserta((Emoji :- verificar_si_lista(ListaCumple),
                             verificar_no_lista(ListaNoCumple))),
           asserta((suponer(Emoji) :- Emoji, !)).

% Elimina de la base de conocimiento la informacion obtenida en las consultas.
% 🗑️🗑️🗑️
limpiar_base :- retract(cumple(_)), fail.
limpiar_base :- retract(no_cumple(_)), fail.
limpiar_base.
