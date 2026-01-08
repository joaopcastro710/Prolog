:- use_module(library(lists)).

% Etapa 1 : gerar tabuleiro

board(Board) :-
    permutation([green,yellow,blue,orange,white,black],Board).

% Etapa 2 : predicados auxiliares

consecutive(X,Y,Board) :-
    append(_,[X,Y|_],Board).

space_between(X,Y,Board) :-
    append(_,[X,_,Y|_],Board).

across_board(X,Y,Board) :-
    nth1(PositionX,Board,X),
    nth1(PositionY,Board,Y),
    member(PositionX,[1,2]),
    member(PositionY,[4,5,6]).

common_edge(X,Y,Board) :-
    nth1(PositionX,Board,X),
    nth1(PositionY,Board,Y),
    member(PositionX,[1,2]),
    member(Positiony,[1,2]).
common_edge(X,Y,Board) :-
    nth1(PositionX,Board,X),
    nth1(PositionY,Board,Y),
    member(PositionX,[4,5,6]),
    member(Positiony,[4,5,6]).

position_board(X,L,Board) :-
    nth1(PositionX,Board,X),
    member(PositionX,L).