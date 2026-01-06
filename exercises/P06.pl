%1

%map(+Pred,+List1,?List2)
map(Predicate,List,Result) :-
    map_aux(Predicate,List,[],Result).

map_aux(_,[],Result,Result).
map_aux(Predicate,[Element|Rest],Accumulator,Result) :-
    Operation =.. [Predicate,Element,R],
    Operation,
    append(Accumulator,[R],Accumulator1),
    map_aux(Predicate,Rest,Accumulator1,Result).

double(X,Y) :- Y is X * 2.

%fold(+Pred,+StartValue,+List, ?FinalValue)
fold(_,Value,[],Value).
fold(Pred,StartValue,[Element|Rest],FinalValue) :-
    Predicate =.. [Pred,StartValue,Element,Result],
    Predicate,
    fold(Pred,Result,Rest,FinalValue).

sum(A,B,R) :- R is A + B.

%separate(+List, +Pred, -Yes, -No)
separate(List, Pred, Yes, No):-
    separate_aux(List, Pred, Yes, [], No, []).

separate_aux([], _, Yes, Yes, No, No).
separate_aux([Element|Rest], Pred, Yes, AccYes, No, AccNo):-
    Condition =.. [Pred, Element],
    Condition, !,
    append(AccYes, [Element], NewAccYes),
    separate_aux(Rest, Pred, Yes, NewAccYes, No, AccNo).
separate_aux([Element|Rest], Pred, Yes, AccYes, No, AccNo):-
    append(AccNo, [Element], NewAccNo),
    separate_aux(Rest, Pred, Yes, AccYes, No, NewAccNo).

even(X):- 0 =:= X mod 2.


%ask_execute/0
ask_execute:-
    read(Operation),
    call(Operation).

% 2

my_functor(Predicate,Name,Arity) :-
    Predicate =..[Name|Args],
    length(Args, Arity).

my_arg(Index,Functor,Arg) :-
    Functor =.. List,
    length(List,Len),
    Len >= Index,
    get_index(Index,List,Arg).

get_index(0,[Arg|_],Arg).
get_index(Index,[_|Rest],Arg) :-
    NextIndex is Index-1,
    get_index(NextIndex,Rest,Arg).

my_univ(Predicate, List):-
    my_functor(Predicate, Name, Arity),
    fill_args(Predicate, 1,  Arity, [Name], List).

fill_args(_, Index, Arity, List, List):-
    Index > Arity, !.
fill_args(Predicate, Index, Arity, Acc, List):-
    my_arg(Index, Predicate, Arg),
    append(Acc, [Arg], Acc1),
    NextIndex is Index + 1,
    fill_args(Predicate, NextIndex, Arity, Acc1, List).


% 3
t(Value,Left,Right).
tree_size(empty,0).
tree_size(t(_,L,R),Size) :-
    tree_size(L,SL),
    tree_size(R,SR),
    Size is SL + SR + 1.

tree_map(_, empty, empty).
tree_map(Pred, t(X,L,R), t(Y,NL,NR)) :-
    call(Pred, X, Y),
    tree_map(Pred, L, NL),
    tree_map(Pred, R, NR).

tree_value_at_level(Tree, Value, Level) :-
    nonvar(Value),
    !,
    ( tree_value_at_level_aux(Tree, Value, 0, Level)
      -> true
      ;  Level = -1
    ).

tree_value_at_level(Tree, Value, Level) :-
    nonvar(Level),
    Level >= 0,
    !,
    tree_value_at_level_level(Tree, Value, 0, Level).

tree_value_at_level(Tree, Value, Level) :-
    tree_value_at_level_aux(Tree, Value, 0, Level).
