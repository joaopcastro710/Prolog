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

/*
i.female(haley).
ii. male(gil).
iii. parent(frank,phil)
iv. parent(X,claire).
v. parent(gloria,X).
vi. parent(jay,_X),parent(_X,Y).
vii. parent(X,_Y),parent(_Y,lily).
viii. parent(alex,X).
ix. parent(_X,luke),parent(_Y,luke),_X @< _Y,parent(_X,Z),parent(_Y,Z),Z\=luke.
*/

father(X,Y) :- 
    male(X),parent(X,Y).
mother(X,Y) :- 
    female(X),parent(X,Y).

grandparent(X,Y) :- 
    parent(X,Z), parent(Z,Y).
grandfather(X,Y) :- 
    grandparent(X,Y), male(X).
grandmother(X,Y) :- 
    grandparent(X,Y), female(X).

siblings(X,Y) :- 
    parent(A,X), parent(B,X), A@>B, parent(A,Y), parent(B,Y), X\=Y.

halfsiblings(X,Y) :-
    mother(Z,X),
    mother(Z,Y),
    father(W,X),
    father(WW,Y),
    W\=WW,
    X\=Y,
    X @< Y.

halfsiblings(X,Y) :-
    mother(Z,X),
    mother(ZZ,Y),
    father(W,X),
    father(W,Y),
    Z\=ZZ,
    X\=Y,
    X @< Y.

cousins(X,Y) :-
    parent(A,X), parent(B,Y), siblings(A,B).

uncle(X,Y) :-
    male(X), parent(Z,Y), siblings(X,Z).

aunt(X,Y) :-
    female(X), parent(Z,Y), siblings(X,Z).

%marriage(husband,wife,year)
marriage(jay,gloria,2008).
marriage(jay,dede,1968).

%divorce(husband,wife,year)
divorce(jay,dede,2003).

/************************************************************************/

% 2

%teaches(class,prof)
teaches(algorithms,adalberto).
teaches(databases,bernardete).
teaches(compilers,capitolino).
teaches(statics,diogenes).
teaches(networks,ermelinda).

%attends(class,students)
attends(algorithms,alberto).
attends(algorithms,bruna).
attends(algorithms,cristina).
attends(algorithms,diogo).
attends(algorithms,eduarda).

attends(databases,antonio).
attends(databases,bruno).
attends(databases,cristina).
attends(databases,duarte).
attends(databases,eduardo).

attends(compilers,alberto).
attends(compilers,bernardo).
attends(compilers,clara).
attends(compilers,diana).
attends(compilers,eurico).

attends(statistics,antonio).
attends(statistics,bruna).
attends(statistics,claudio).
attends(statistics,duarte).
attends(statistics,eva).

attends(networks,alvaro).
attends(networks,beatriz).
attends(networks,claudio).
attends(networks,diana).
attends(networks,eduardo).

student(X,Y) :-
    attends(Z,X), teaches(Z,Y).

students(X,Y) :-
    attends(Z,Y), teaches(Z,X). 

teachers(X,Y) :-
    attends(Z,X), teaches(Z,Y).

bothProfessors(X,Y,Z) :-
    teaches(A,X), teaches(B,Y), attends(A,Z), attends(B,Z), X\=Y.

colleagues(X,Y) :-
    attends(Z,X),
    attends(Z,Y),
    X \= Y;
    teaches(_Z,X),
    teaches(_Z,Y).

more(X) :-
    attends(Y,X),
    attends(Z,X),
    Y \= Z.

/************************************************************************/

% 3

%pilot(name).
pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

%team(name,pilot).
team(breitling,lamb).
team(redbull,besenyei).
team(redbull,chambliss).
team(mediterranean,maclean).
team(cobra,mangold).
team(matador,jones).
team(matador,bonhomme).

%pilots(car,pilot).
pilots(mx2,lamb).
pilots(edge540,besenyei).
pilots(edge540,chambliss).
pilots(edge540,maclean).
pilots(edge540,mangold).
pilots(edge540,jones).
pilots(edge540,bonhomme).

%circuit
circuit(istambul).
circuit(budapest).
circuit(porto).

%won(circuit,pilot)
won(porto,jones).
won(budapest,mangold).
won(istambul,mangold).

%gates(circuit,number)
gates(istambul,9).
gates(budapest,6).
gates(porto,5).

%teamWin(team,circuit)
teamWin(X,Y) :-
    team(X,Z),
    won(Y,Z).

not_flying_edge540(Pilot) :-
    pilot(Pilot),
    \+ pilots(edge540, Pilot).

won_more(X) :-
    won(Y,X),
    won(Z,X),
    Y @> Z.

/************************************************************************/

% 4

translate(1,'Integer Overflow').
translate(2,'Division by Zero').
translate(3,'ID Unknown').

/************************************************************************/

% 5

job(technician, eleuterio).
job(technician, juvenaldo).
job(analyst, leonilde).
job(analyst, marciliano).
job(engineer, osvaldo).
job(engineer, porfirio).
job(engineer, reginaldo).
job(supervisor, sisnando).
job(chief_supervisor, gertrudes).
job(secretary, felismina).
job(director, asdrubal).

supervised_by(technician, engineer).
supervised_by(engineer, supervisor).
supervised_by(analyst, supervisor).
supervised_by(supervisor, chief_supervisor).
supervised_by(chief_supervisor, director).
supervised_by(secretary, director).