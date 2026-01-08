:- use_module(library(lists)).

% gerar tabuleiro

board(Board) :-
    permutation([green,yellow,blue,orange,white,black],Board).

