% 1

r(a,b).
r(a,d).
r(b,a).
r(a,c).
s(b,c).
s(b,d).
s(c,c).
s(d,e).

/*
a)
i. r(X,Y), s(Y,Z). - a,b,c a,b,d a,d,e a,c,c
ii. s(Y,Y), r(X,Y). c,a
iii. r(X,Y), s(Y,Y). a,c
*/

% 2

pairs(X,Y) :- d(X),q(Y).
pairs(X,X) :- u(X).
u(1).
d(2).
d(4).
q(4).
q(16).

% 3
/*
a(a1,1).
a(a2,2).
a(a3,N).
b(1,b1).
b(2,b2).
b(N,b3).
c(X,Y) :- a(X,Z), b(Z,Y).
d(X,Y) :- a(X,Z), b(Y,Z).
d(X,Y) :- a(Z,X), b(Z,Y).
*/

% 4
/*
%factorial(+N,-F)
factorial(0,1).         %base 
factorial(N,F) :-       %recursivo       
    N > 0,              %guarda
    N1 is N-1,          %update, o que vai mudar em cada caso
    factorial(N1,F1),       
    F is F1*N.

%sum_rec(+N,-Sum)
sum_rec(0,0).
sum_rec(N,Sum) :-
    N>0,
    N1 is N-1,
    sum_rec(N1,Sum1),
    Sum is Sum1+N.

%pow_rec(+X,+Y,-P)
pow_rec(_,0,1).
pow_rec(X,1,X).
pow_rec(X,Y,P) :-
    Y>0,
    Y1 is Y-1,
    pow_rec(X,Y1,P1),
    P is X*P1.
*/
%square_rec(+N,-S)
square_rec(N,S) :-
    square_rec_aux(N,N,0,S).

square_rec_aux(_,0,Acc,Acc).
square_rec_aux(N,Count,Acc,S) :-
    Count>0,
    Acc1 is Acc+N,
    Count1 is Count-1,
    square_rec_aux(N,Count1,Acc1,S).

%fibonacci(+N,-F)
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(2, 1).
fibonacci(N, F):-
    N1 is N-1,
    N2 is N-2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    F is F1 + F2.

%is_prime(+X)
is_prime(1).
is_prime(2).
is_prime(X) :-
    X>2,
    Next is X-1,
    is_prime_aux(X,Next).

is_prime_aux(_,1).
is_prime_aux(X,N) :-
    X mod N =\= 0,
    Next is N-1,
    is_prime_aux(X,Next).

% 5

factorial_tail(N,F) :-
    factorial_tail_aux(N,1,F).

factorial_tail_aux(0,Acc,Acc).
factorial_tail_aux(N,Acc,F) :-
    N>0,
    Acc1 is Acc*N,
    N1 is N-1,
    factorial_tail_aux(N1,Acc1,F).

sum_rec_tail(N,Sum) :-
    sum_rec_tail_aux(N,0,Sum).

sum_rec_tail_aux(0,Acc,Acc).
sum_rec_tail_aux(N,Acc,Sum) :-
    N>0,
    Acc1 is Acc+N,
    N1 is N-1,
    sum_rec_tail_aux(N1,Acc1,Sum).


pow_rec_tail(X,Y,P) :-
    pow_rec_tail_aux(X,Y,1,P).      

pow_rec_tail_aux(_,0,Acc,Acc).
pow_rec_tail_aux(X,Y,Acc,P) :-
    Y>0,
    Acc1 is Acc*X,
    Y1 is Y-1,
    pow_rec_tail_aux(X,Y1,Acc1,P).

