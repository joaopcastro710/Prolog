% 1

s(1).
s(2) :- !.
s(3).

/*
a) s(X) -> X=1 X=2
b) s(X), s(Y) -> X=1 Y=1, X=1 Y=2, X=2 Y=1, X=2 Y=2
c) X=1 Y=1, X=1 Y=2 ---- aqui o cut da querie impede que haja outra opção para além do X=1
*/

% 2

data(one).
data(two).
data(three).

cut_test_a(X):-data(X).
cut_test_a('five').

cut_test_b(X):-data(X), !.
cut_test_b('five').

cut_test_c(X,Y) :- data(X), !, data(Y).
cut_test_c('five','five').

/*
a) one two three five
b) one
c) one one one two one three
*/

% 3

immature(X) :- adult(X), !, fail.
immature(_X).

adult(X) :- person(X), !, age(X,N), N >= 18.
adult(X) :- turtle(X), !, age(X,N), N >= 50.
adult(X) :- spider(X), !, age(X,N), N >= 1.
adult(X) :- bat(X), !, age(X,N), N >= 5.

% Em immature/1 o cut usado é vermelho, pois influencia nos resultados obtidos pelo predicado
% Em adult/1 o cut usado é verde pois trava o backtracking do prolog por motivos de eficiência de pesquisa


% 4

%max(+A,+B,+C,?Max)
max(A, B, C, A) :-
    A >= B,
    A >= C,
    !.
max(_, B, C, B) :-
    B >= C,
    !.
max(_, _, C, C).

% 5

%print_n(+N, +S)
print_n(0, _).
print_n(N, S):-
    write(S),
    NextN is N - 1,
    print_n(NextN, S).

%print_text(+Text, +Symbol, +Padding)
print_text(Text,Symbol,Padding) :-
    write(Symbol),
    print_n(Padding,' '),
    text(Text),
    print_n(Padding,' '),
    write(Symbol), nl.


text([]).
text([H|T]) :-
    put_code(H),
    text(T).

%print_banner(+Text, +Symbol, +Padding)
print_banner(Text, Symbol, Padding) :-
    length(Text,Len),
    TotalLength is Len + 2*Padding + 2,
    Spaces is TotalLength - 2,
    print_n(TotalLength,Symbol), nl, print_n(1,Symbol),
    print_n(Spaces, ' '), print_n(1, Symbol), nl,
    print_n(1,Symbol), print_n(Padding,' '), text(Text), print_n(Padding,' '), print_n(1,Symbol), nl,
    print_n(1,Symbol), print_n(Spaces, ' '), print_n(1,Symbol), nl, print_n(TotalLength,Symbol), nl.


%read_number(X)
read_number(X) :-
    read_number_aux(0,X).

read_number_aux(Acc,X):-
    get_code(C),
    C >= 48,
    C =< 57, !,
    NextAcc is Acc*10+(C-48),
    read_number_aux(NextAcc,X).
read_number_aux(Acc,Acc).


%read_until_between(+Min, +Max, -Value)
read_until_between(Min, Max, Value):-
    repeat,
    read_number(Value),
    Min =< Value,
    Max >= Value.

% 4.f

%read_string(-X)
read_string(X):-
    read_string_aux([], X).

read_string_aux(List, Result):-
    get_code(C),
    C \= 10, !,
    append(List, [C], AnotherList),
    read_string_aux(AnotherList, Result).
read_string_aux(String, String).

% 4.g

banner:-
    write('Some text: '),
    read_string(Text),
    write('Symbol: '),
    get_char(C), 
    write('Paddind between 1 and 10: '),
    read_until_between(1, 10, Padding), nl,
    print_banner(Text, C, Padding).

% 4.h

%print_multi_banner(+ListOfTexts, +Symbol, +Padding)
print_multi_banner(ListOfTexts, Symbol, Padding):-
    getMax(ListOfTexts, -1, Max),
    TotalLength is Max + 2*Padding + 2,
    MinLength is TotalLength - 2,
    print_n(Symbol, TotalLength), nl, print_n(Symbol, 1), print_n(' ', MinLength), print_n(Symbol, 1), nl,
    print_texts(ListOfTexts, Max, Padding, Symbol),
    print_n(Symbol, 1), print_n(' ', MinLength), print_n(Symbol, 1), nl, print_n(Symbol, TotalLength), nl.

getMax([], Result, Result).
getMax([H|T], Acc, Result):-
    length(H, Attemp),
    Attemp >= Acc, !,
    getMax(T, Attemp, Result).
getMax([_|T], Acc, Result):-
    getMax(T, Acc, Result).

print_texts([], _, _, _):- !.
print_texts([Text|Tail], Max, Padding, Symbol):-
    length(Text, TextLength),
    Spaces is (Max - TextLength)//2 + Padding,
    print_n(Symbol, 1), print_n(' ', Spaces), 
    text(Text),
    print_n(' ', Spaces), print_n(Symbol, 1), nl, !, 
    print_texts(Tail, Max, Padding, Symbol).

%oh_christmas_tree(+N)
oh_christmas_tree(N):- tree(0, N).

tree(Max, Max):-
    Padding is (Max*2 + 1) // 2,
    print_n(' ', Padding), print_n('*', 1), !.
tree(N, Max):-
    Stars is N*2 + 1,
    MaxStars is Max*2 + 1,
    Padding is (MaxStars - Stars) // 2,
    print_n(' ', Padding), print_n('*', Stars), nl,
    NextTree is N + 1,
    tree(NextTree, Max).
