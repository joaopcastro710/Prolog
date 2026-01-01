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
del_all(_,[],[]).
del_all(Elem,[Elem|T],Rest) :-
    del_all(Elem,T,Rest).
del_all(Elem,[H|T],Rest) :-
    del_all(Elem,T,Rest1),
    append([H],Rest1,Rest).

%del_all_list(+ListElements,+List1,?List2)
del_all_list([],List,List).
del_all_list([H|T],List1,List2) :-
    del_all(H,List1,SubResult),
    del_all_list(T,SubResult,List2).

%del_dups(+List1,?List2)
del_dups([],[]).
del_dups([H|T],[H|R]) :-
    del_all(H,T,T1),
    del_dups(T1,R).

%list_perm(+L1,+L2)
list_perm(List1,List2) :-
    length(List1,Len),
    length(List2,Len),
    del_all_list(List1,List2,[]),
    del_all_list(List2,List1,[]).

%replicate(+Amount,+Elem,?List)
replicate(0,_,[]).
replicate(Amount,Elem,List):-
    Amount>0,
    NewAmount is Amount-1,
    replicate(NewAmount,Elem,List1),
    append([Elem],List1,List).

%intersperse(+Elem,+List1,?List2)
intersperse(_,[],[]).
intersperse(_,[H],[H]).
intersperse(Element,[H|T],Result) :-
    intersperse(Element, T, SubResult),
    append([H,Element],SubResult,Result).

%insert_elem(+Index,+List1,+Elem,?List2)
insert_elem(0,List,Element,[Element|List]).
insert_elem(N,[H|T],Element,Result) :-
    length([H|T],X), X>N,
    NextN is N-1,
    insert_elem(NextN,T,Element,SubResult),
    append([H],SubResult,Result).

%delete_elem(+Index, +List1, +Elem, ?List2)
delete_elem(0, [Element|T], Element, T).
delete_elem(N, [H|T], Element, Result):-
    length([H|T], X), X > N,
    NextN is N - 1,
    delete_elem(NextN, T, Element, SubResult),
    append([H], SubResult, Result).

%replace(+List1,+Index,?Old,+New,?List2)
replace([Old|Tail],0,Old,New,[New|Tail]).
replace([H|T],Index,Old,New,List2) :-
    NextIndex is Index-1,
    replace(T,NextIndex,Old,New,SubResult),
    append([H],SubResult,List2).

% 4

%list_append(?L1,?L2,?L3)
list_append([],L2,L2).
list_append([H|T],L2,[H|R]) :-
    list_append(T,L2,R).

%list_member(?Elem,?List)
list_member(_,[]) :- fail.
list_member(Element,List) :-
    append(_,[Element|_],List).

%list_last(+List,?Last)
list_last(List,Last) :-
    append(_,[Last],List).

%list_nth(?N,?List,?Elem)
list_nth(N,List,Elem) :-
    append(Before,[Elem|_],List),
    length(Before,N).

%list_append(+ListOfLists,?List)
list_append([],[]).
list_append([H],H).
list_append([H|T],Result) :-
    list_append(T,SubResult),
    list_append(H,SubResult,Result).

%list_del(+List,+Elem,?Res)
list_del(List,Elem,Res) :-
    append(Before,[Elem|After],List),
    append(Before,After,Res).

%list_before(?First,?Second,?List)
list_before(First,Second,List) :-
    append(_,[First|After],List),
    append(_,[Second|_],After).

%list_replace_one(+X,+Y,+List1,?List2)
list_replace_one(X,Y,List1,List2):-
    append(Before,[X|After],List1),
    append(Before,[Y|After],List2).

%list_repeated(+X,+List)
list_repeated(X,List) :-
    append(_,[X|After],List),
    append(_,[X|_],After).

%list_slice(+List1, +Index, +Size, ?List2)
list_slice(List1, Index, Size, List2):-
    append(Before, After, List1),
    length(Before, Index),
    append(List2, _, After),
    length(List2, Size).


%list_shift_rotate(+List1, +N, ?List2)
list_shift_rotate(List1, N, List2):-
    append(Before, After, List1),
    length(Before, N),
    append(After, Before, List2).

%5

%list_to(+N,?List)
list_to(0,[]).
list_to(N,List) :-
    NextN is N-1,
    list_to(NewN,List1),
    append(List1,[H],List).

%list_from_to(+Inf,+Sup,?List)
list_from_to(Sup,Sup,[Sup]).
list_from_to(Inf,Sup,List) :-
    NextNumber is Inf +1,
    list_from_to(NextNumber,Sup,SubList),
    append([Inf],SubList,List).

%list_from_to_step(+Inf,+Step,+Sup,?List)
list_from_to_step(Inf,_,Sup,[]) :- Inf>Sup,!.
list_from_to_step(Inf,Step,Sup,List) :-
    NextNumber is Inf+Step,
    list_from_to_step(NextNumber,Step,Sup,SubList),
    append([Inf],SubList,List).

% 6