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


% Etapa 4 : Aplicar Restrições

check_constrains([],_).
check_constrains([C|Rest],Board) :-
    call(C,Board),
    check_constrains(Rest,Board).

% Etapa 5 : solve/2 (Parte 1)

solve(Constrains, Board) :-
    board(Board),
    check_constrains(Constrains,Board).


% Etapa 6 : contar violações

count_violations([],_,0).

count_violations([C|Rest],Board,Count) :-
    call(C,Board),
    count_violations(Rest,Board,Count).

count_violations([C|Rest],Board,Count) :-
    \+ call(C,Board),
    count_violations(Rest,Board,Rest),
    Count is Rest+1.


% Etapa 7 : best_score/2 (Parte 2)

best_score(Constraints, BestScore) :-
    findall(Score,
        ( board(Board),
          count_violations(Constraints, Board, V),
          Score is -V
        ),
        Scores),
    max_list(Scores, BestScore).

max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, MaxT),
    ( H > MaxT -> Max = H ; Max = MaxT ).


%------ EXAMPLES--------
%% 12 solutions
example(1, [ next_to(white,orange),
next_to(black,black),
across(yellow,orange),
next_to(green,yellow),
position(blue,[1,2,6]),
across(yellow,blue) ]).
%% 1 solution
example(2, [ across(white,yellow),
position(black,[1,4]),
position(yellow,[1,5]),
next_to(green, blue),
same_edge(blue,yellow),
one_space(orange,black) ]).
%% no solutions (5 constraints are satisfiable)
example(3, [ across(white,yellow),
position(black,[1,4]),
position(yellow,[1,5]),
same_edge(green, black),
same_edge(blue,yellow),
one_space(orange,black) ]).
%% same as above, different order of constraints
example(4, [ position(yellow,[1,5]),
one_space(orange,black),
same_edge(green, black),
same_edge(blue,yellow),
position(black,[1,4]),
across(white,yellow) ]).

% =========================================================
% =============== COMANDOS DE TESTE =======================
% =========================================================

% ---------- Testar geração de tabuleiros ----------
% ?- board(B).
% ?- permutation([green,yellow,blue,orange,white,black], B).

% ---------- Testar restrições individualmente ----------

% next_to
% ?- board(B), next_to(green, yellow, B).

% one_space
% ?- board(B), one_space(blue, orange, B).

% across
% ?- board(B), across(white, black, B).

% same_edge
% ?- board(B), same_edge(green, blue, B).

% position
% ?- board(B), position(blue, [1,2,6], B).

% ---------- Testar aplicação de restrições ----------
% ?- example(1,E), check_constraints(E, B).

% ---------- PARTE 1 — solve/2 ----------

% Exemplo 1 (várias soluções)
% ?- example(1,E), solve(E, B).

% Exemplo 2 (uma solução)
% ?- example(2,E), solve(E, B).

% Exemplo 3 (nenhuma solução)
% ?- example(3,E), solve(E, B).

% Exemplo 4 (ordem diferente)
% ?- example(4,E), solve(E, B).

% ---------- PARTE 2 — contar violações ----------

% ?- example(3,E), board(B), count_violations(E, B, V).

% ---------- PARTE 2 — best_score/2 ----------

% ?- example(1,E), best_score(E, S).
% Esperado: S = 0

% ?- example(2,E), best_score(E, S).
% Esperado: S = 0

% ?- example(3,E), best_score(E, S).
% Esperado: S = -1

% ?- example(4,E), best_score(E, S).
% Esperado: S = -1

% ---------- Teste geral ----------
% ?- example(N,E), solve(E,B).
% ?- example(N,E), best_score(E,S).

% =========================================================
