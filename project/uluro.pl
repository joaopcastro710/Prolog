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
    member(PositionY,[1,2]).
common_edge(X,Y,Board) :-
    nth1(PositionX,Board,X),
    nth1(PositionY,Board,Y),
    member(PositionX,[4,5,6]),
    member(PositionY,[4,5,6]).

position_board(X,L,Board) :-
    nth1(PositionX,Board,X),
    member(PositionX,L).

% Etapa 3 : restrições

anywhere(_,_).

next_to(X,X,_).
next_to(X,Y,Board) :- consecutive(X,Y,Board).
next_to(X,Y,Board) :- consecutive(Y,X,Board).

one_space(X,X,_).
one_space(X,Y,Board) :- space_between(X,Y,Board).
one_space(X,Y,Board) :- space_between(Y,X,Board).

across(X,X,_).
across(X,Y,Board) :- across_board(X,Y,Board).
across(X,Y,Board) :- across_board(Y,X,Board).

same_edge(X,X,_).
same_edge(X,Y,Board) :- common_edge(X,Y,Board).

position(X,L,Board) :- position_board(X,L,Board).