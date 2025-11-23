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

halfSiblings(X,Y) :- 
    parent(A,X), parent(A,Y), X\=Y.

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

pilots(lamb).