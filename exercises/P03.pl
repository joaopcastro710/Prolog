% 2

%list_size(+List,?Size)
list_size([],0).
list_size([_|T],Size) :-
    list_size(T,NewSize),
    Size is NewSize + 1.


%list_sum(+List,?Sum)
list_sum([],0).
list_sum([H|T],Sum) :-
    list_sum(T,NewSum),
    Sum is NewSum + H.

/*
list_sum([1,2,3], S)
→ list_sum([2,3], NewSum1)
→ list_sum([3], NewSum2)
→ list_sum([], 0)        % CASO BASE

NewSum2 = 0 + 3 = 3
NewSum1 = 3 + 2 = 5
S       = 5 + 1 = 6

*/

%list_prod(+List,?Prod)
list_prod([],1).
list_prod([H|T],Prod) :-
    list_prod(T,NewProd),
    Prod is NewProd * H.

% prof - só considero dois casos: quando ambas são vazias e quando ambas são não vazias
%inner_product(+List1,+List2,?Result)
inner_product([],[],0).
inner_product([H1|T1],[H2|T2],Result) :-
    inner_product(T1,T2,NewResult),
    Result is NewResult+H1*H2.


%count(+Elem,+List,?N)
count(_,[],0).
count(Elem,[Elem|T],N) :-
    count(Elem,T,NewN),
    N is NewN+1.
count(Elem,[_|T],N) :-
    count(Elem,T,N).

% 3

%invert(+List1,?List2)
invert([],[]).
invert([H|T],List) :-
    invert(T,List2),
    append(List2,[H],List).

% usar diferente
del_one(_, [], []).
del_one(Elem, [Elem|T], T).
del_one(Elem, [H|T], [H|Rest]) :-
    Elem \= H,      
    del_one(Elem, T, Rest).

/*
vai passo a passo ver os elementos. Encontra um que não é o Elem? Mete no resultado(primeira linha do 2º caso). Encontrou? Então não acrescenta e simplemenste mete o resto. Para aí.
*/

%del_all(+Elem,+List1,?List2).