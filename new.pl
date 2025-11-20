% 1. Family Relations

%a) 

male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(pameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(manny).
female(cameron).
female(haley).
female(alex).
female(lily).
female(poppy).

parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(jay,claire).
parent(dede,mitchell).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(merle,cameron).
parent(barb,pameron).
parent(merle,pameron).
parent(phil, haley).
parent(claire, haley).
parent(phil, alex).
parent(claire, alex).
parent(phil, luke).
parent(claire, luke).
parent(mitchell, lily).
parent(mitchell, rexford).
parent(cameron, lily).
parent(cameron, rexford).
parent(pameron, calhoun).
parent(bo, calhoun).
parent(dylan, george).
parent(dylan, poppy).
parent(haley, george).
parent(haley, poppy).


%1.b - done in the interpreter

% 1.c

father(X,Y):-male(X),parent(X,Y).

mother(X,Y):-female(X),parent(X,Y).

grandparent(X,Y):-
    parent(X,Z),
    parent(Z,Y).

grandfather(X,Y):-
    male(X),
    grandparent(X,Y).

grandmother(X,Y):-
    female(X),
    grandparent(X,Y).

siblings(X, Y):-
    father(A, X),
    father(A, Y),
    mother(B, X),
    mother(B, Y),
    X \= Y.

halfsiblings(x,y):-
    parent(z,x),
    parent(w,y),
    \+siblings(x,y),    %they are NOT siblings, they do not share both parents
    z==w.               % z and w are the same individual

cousins(X,Y):-
    parent(Z,X),
    parent(W,Y),
    siblings(Z,W).

uncle(x,y):-
    parent(z,y),
    siblings(x,z).

% 1.e)

married(jay, gloria, 2008).
married(jay, dede, 1968).
divorce(jay, dede, 2003).

% We assume that Person1 and Person2 never got divorce
is_married(X,Y, CurrentYear):-
    married(X,Y,Year1),
    CurrentYear >= Year1,
    \+divorce(X,Y,_).

% We assume that Person1 and Person2 got divorced sometime later

is_married(X,Y,CurrentYear):-
    married(X,Y,Year1),
    CurrentYear >= Year1,
    \+divorce(X,Y,Year2),
    CurrentYear < Year2.

% 2.a

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

% 2.b

% 2.c

aluno(X,Y):-
    leciona(Y,W),
    frequenta(X,W).

students(Professor, Student) :-
    leciona(Professor, Course),
    frequenta(Student, Course).

teachers(S, T):-
    frequenta(S,C),
    leciona(T,C).

commonStudent(X,Y, Student):-
    leciona(X,XX),
    leciona(Y,YY),
    frequenta(Student,XX),
    frequenta(Student,YY),
    XX \= YY.

colleagues(X,Y):-
    frequenta(X,Z),
    frequenta(Y,Z),
    X\=Y;
    leciona(X, _Z),
    leciona(Y, _Z).

more(S):-
    frequenta(S,C1),
    frequenta(S,C2),
    C1 \= C2.

% 3.


piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(maclean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).

equipa(lamb, breitling).
equipa(besenyei, redbull).
equipa(chambliss, redbull).
equipa(maclean, mediterraneanracingteam).
equipa(mangold, cobra).
equipa(jones, matador).
equipa(bonhomme, matador).

aviao(lamb, mx2).
aviao(besenyei, edge540).
aviao(chambliss, edge540).
aviao(maclean, edge540).
aviao(mangold, edge540).
aviao(jones, edge540).
aviao(bonhomme, edge540).

circuito(istanbul).
circuito(budapest).
circuito(porto).

venceu(jones, porto).
venceu(mangold, budapest).
venceu(mangold, istanbul).

gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

won(X,Y):-
    equipa(Z,X),
    venceu(Z,Y).

% 4.

legenda(1, 'Integer Overflow').
legenda(2, 'Divisao por Zero').
legenda(3, 'ID Desconhecido').

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