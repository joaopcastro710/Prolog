% 1

%female/1
female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(pameron).
female(haley).
female(alex).
female(lily).
female(poppy).

%male/1
male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(cameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

%parent/2 -> parent(a,b) is interpreed as 'a is parent of b'
parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(dede,mitchell).
parent(jay,claire).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(barb,pameron).
parent(merle,cameron).
parent(merle,pameron).
parent(phil,haley).
parent(phil,alex).
parent(phil,luke).
parent(claire,haley).
parent(claire,alex).
parent(claire,luke).
parent(mitchell,lily).
parent(mitchell,rexford).
parent(cameron,lily).
parent(cameron,rexford).
parent(pameron,calhoun).
parent(bo,calhoun).
parent(dylan,george).
parent(dylan,poppy).
parent(haley,george).
parent(haley,poppy).

%children(+Person,-Children)
children(Person, Children) :-
    findall(Child, parent(Person, Child), Children).

%children_of(+ListOfPeople, -ListOfPairs)
children_of([], []).
children_of([H|T], [H-Children | Rest]) :-
    children(H, Children),
    children_of(T, Rest).

%family(-F)
family(F) :-
    setof(Person,(male(Person);female(Person)),F).

%couple(C)
couple(C):-
    setof(Mother-Father,(parent(Mother,_X), female(Mother), parent(Father,_X),male(Father)),AllCouples),
    member(C,AllCouples).

%couples(-List)
couples(List) :-
    findall(Couple,couple(Couple),List).

%spouse_children(+Person,-SC)
spouse_children(Person,SC) :-
    setof(Spouse/Children,(parent(Person,_X),parent(Spouse,_X),Person\=Spouse,children(Spouse,Children)),SC).

%immediate_family(+Person,-PC)
immediate_family(Person,PC) :-
    findall(Parents-Children,(parents(Person,Parents),spouse_children(Person,Children)),PC).

parents(Person, All):-
    setof(Parent, parent(Parent, Person), All).

%parents_of_two(-Parents)
parents_of_two(Parents) :-
    setof(Person, (_X,_Y)^(parent(Person,_X),parent(Person,_Y),_X\=_Y),Parents).

% 2

leciona(adalberto, algoritmos).
leciona(bernardete, basesdedados).
leciona(capitolino, compiladores).
leciona(diogenes, estatistica).
leciona(ermelinda, redes).

frequenta(alberto, algoritmos).
frequenta(bruna, algoritmos).
frequenta(cristina, algoritmos).
frequenta(diogo, algoritmos).
frequenta(eduarda, algoritmos).
frequenta(antonio, basesdedados).
frequenta(bruno, basesdedados).
frequenta(cristina, basesdedados).
frequenta(duarte, basesdedados).
frequenta(eduardo, basesdedados).
frequenta(alberto, compiladores).
frequenta(bernardo, compiladores).
frequenta(clara, compiladores).
frequenta(diana, compiladores).
frequenta(eurico, compiladores).
frequenta(antonio, estatistica).
frequenta(bruna, estatistica).
frequenta(claudio, estatistica).
frequenta(duarte, estatistica).
frequenta(eva, estatistica).
frequenta(alvaro, redes).
frequenta(beatriz, redes).
frequenta(claudio, redes).
frequenta(diana, redes).
frequenta(eduardo, redes).
frequenta(xico, redes).

%teachers(-T)
teachers(T) :-
    setof(Teacher,Class^leciona(Teacher,Class),T). /*findall(Teacher,leciona(Teacher,_Class),T)*/

/*usando o setof que elemina os duplicados*/

%students_of(+T,-S)
students_of(T,S) :-
    findall(Student,(leciona(T,_Class), frequenta(Student, _Class)),S).

%teachers_of(+S,-T)
teachers_of(S,T):-
    findall(Teacher,(leciona(Teacher,_Class),frequenta(S,_Class)),T).

%common_courses(+S1,+S2,-C)
common_courses(S1, S2, C):-
    findall(UC, (S1, S2)^(frequenta(S1, UC), frequenta(S2, UC)), C).

%more_than_one_course(-L)
more_than_one_course(L):-
    setof(Student, (UC1, UC2)^(frequenta(Student, UC1), frequenta(Student, UC2), UC1 \= UC2) , L).

%strangers(-L)
strangers(L) :-
    findall(A-B,(frequenta(A,_),frequenta(B,_),common_courses(A,B,UCs),length(UCs, 0)),L).

%good_groups(-L)
good_groups(L) :-
    setof(S1-S2, (UC1, UC2, UCs, Len)^(frequenta(S1, UC1), frequenta(S2, UC2), common_courses(S1, S2, UCs), S1 @< S2, length(UCs, Len), Len > 1), L).



%3
%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).


%same_day(+Course1,+Course2)
same_day(Course1,Course2) :-
    class(Course1,_,Day,_,_),
    class(Course2,_,Day,_,_),
    Course1 \= Course2.

%daily_courses(+Day,-Courses)
daily_courses(Day, Courses) :-
    findall(Course,class(Course, _,Day, _,_),Courses).

%short_classes(-L)
short_classes(L):-
    findall(UC-Dia/Hora, (class(UC, _, Dia, Hora, Duration), Duration < 2), L).

%course_classes(+Course, -Classes)
course_classes(Course, Classes) :-
    findall(Day/Time-Type, class(Course, Type,Day,Time,_),Classes).

%courses(-L)
courses(L):-
    setof(UC, (A, B, C, D)^class(UC, A, B, C, D), L).

%schedule/0
schedule:-
    setof(Key1-Key2-(Course-Tipo-Key1-Key2-Duration), class(Course, Tipo, Key1, Key2, Duration), Values),
    print_courses(Values).

print_courses([]).
print_courses([Key1-Key2-(Course-Tipo-Key1-Key2-Duration)|Tail]):-
    format('~a ~a ~a ~1f ~d', [Course, Tipo, Key1, Key2, Duration]), nl,
    print_courses(Tail).

% 4

%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

%get_all_nodes
get_all_nodes(ListOfAirports) :-
    setof(Airport,source_or_dest(Airport),ListOfAirports).

source_or_dest(Airport) :- flight(Airport,_,_,_,_,_).
source_or_dest(Airport) :- flight(_,Airport,_,_,_,_).

%most_diversified(-Company)
most_diversified(Company) :-
    findall(Quantity-Comp,List^(flight(_,_,Comp,_,_,_),get_destinations(Comp,List),length(List,Quantity)),ListOfCompanies),
    sort(ListOfCompanies,L),
    last(L,_-Company).

get_destinations(Company,Destinations) :-
    findall(Destination,Company^flight(_,Destination,Company,_,_,_),Destinations).

%find_flights(+Origin,+Destination,-Flights)
find_flights(Origin,Destination,Flights) :-
    find_flights_dfs(Origin,Destination,[],Flights).

find_flights_dfs(Destination,Destination,Flights,Flights).
find_flights_dfs(Origin,Destination,Acc,Flights) :-
    flight(Origin,Node,_,Code,_,_),
    \+member(Code,Acc),
    append(Acc,[Code],Acc1),
    find_flights_dfs(Node,Destination,Acc1,Flights).

%find_flights_breath(+Origin,+Destination,-Flights)
find_flights_breath(Origin,Destination,Flights) :-
    find_flights_bfs([Origin],Destination,[],Reversed),
    get_codes(Reversed,[],Flights).

find_flights_bfs([Destination|_],Destination,Visited,Flights) :-
    reverse([Destination|Visited],Flights).
find_flights_bfs([CurrentNode|OldNode], Destination,Visited,Flights) :-
    findall(Child,(flight(CurrentNode,Child,_,_,_,_),\+member(Child,OldNodes), \+member(CHild,Visited)),NewNodes),
    append(OldNodes,NewNodes,Nodes),
    find_flights_bfs(Nodes,Destination,[CurrentNode|Visited],Flights).

get_codes([],Result,Result).
get_codes([_],Result,Result).
get_codes([Origin,Destination|Something],Acc,Result) :-
    flight(Origin,Destination,_,Code,_,_),
    append(Acc,[Code],Acc1),
    get_codes([Destination|Something],Acc1,Result).

%find_all_flights (+Origin, +Destination, -ListOfFlights)
find_all_flights(Origin, Destination, ListOfFlights):-
    findall(Path, find_flights(Origin, Destination, Path), ListOfFlights).

%find_flights_least_stops(+Origin, +Destination, -ListOfFlights)
find_flights_least_stops(Origin, Destination, ListOfFlights):-
    find_all_flights(Origin, Destination, [One|Rest]),
    get_min([One|Rest], One, ListOfFlights).

get_min([], Minimal, Minimal).
get_min([Possible|Rest], Minimal, ListOfFlights):-
    length(Possible, A),
    length(Minimal, Min),
    A =< Min, !, 
    get_min(Rest, Possible, ListOfFlights).
get_min([_|Rest], Minimal, ListOfFlights):-
    get_min(Rest, Minimal, ListOfFlights).

%find_flights_stops(+Origin, +Destination, +Stops, -ListFlights)
find_flights_stops(Origin, Destination, Stops, ListFlights):-
    find_flights_bfs([Origin], Destination, [], Reversed),
    findall(Edge, (member(Edge, Stops), \+member(Edge, Reversed)), List),
    length(List, 0),
    get_codes(Reversed, [], ListFlights).

%find_circular_trip (+MaxSize, +Origin, -Cycle)
find_circular_trip(MaxSize, Origin, Cycle):-
    flight(Origin, Destination, _, _, _, _),
    find_circular_path(Origin, Destination, [], Cycle),
    length(Cycle, Length),
    Length =< MaxSize.

find_circular_path(Origin, Origin, Acc, [Origin|Path]):-
    append(Acc, [Origin], Path), !.
find_circular_path(Origin, NextNode, Acc, Path):-
    append(Acc, [NextNode], Acc1),
    flight(NextNode, AnotherNode, _, _, _, _),
    \+member(AnotherNode, Acc),
    find_circular_path(Origin, AnotherNode, Acc1, Path).

%find_circular_trips(+MaxSize, +Origin, -Cycles)
find_circular_trips(MaxSize, Origin, Cycles):-
    findall(Cycle, find_circular_trip(MaxSize, Origin, Cycle), Cycles).

%strongly_connected(+ListOfNodes)
strongly_connected([]).
strongly_connected([_]).
strongly_connected([Node|Rest]):-
    bfs([Node], [], Visited),
    findall(UnvisitedNode, (member(UnvisitedNode, [Node|Rest]), \+member(UnvisitedNode, Visited)), UnvisitedNodes),
    length(UnvisitedNodes, 0).

bfs([], Visited, Visited).
bfs([CurrentNode|Rest], Visited, Result):-
    findall(Node, (flight(CurrentNode, Node, _, _, _, _), \+member(Node, Visited), \+member(Node, Rest)), NewNodes),
    append(Rest, NewNodes, List),
    bfs(List, [CurrentNode|Visited], Result).

%strongly_connected_components(-Components)
strongly_connected_components(Components):-
    setof(Node, is_node(Node), Nodes),
    get_components(Nodes, [], Components).

is_node(Node):- flight(Node, _, _, _, _, _).
is_node(Node):- flight(_, Node, _, _, _, _).

get_components([], Components, Components).
get_components([Node|Rest], Accumulator, Components):-
    bfs([Node], [], Component),
    append(Accumulator, Component, NextAccumulator),
    findall(UnvisitedNode, (member(UnvisitedNode, [Node|Rest]), \+member(UnvisitedNode, Component)), UnvisitedNodes),
    get_components(UnvisitedNodes, NextAccumulator, Components).   