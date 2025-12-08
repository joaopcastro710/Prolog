% 1

r(a,b).
r(a,d).
r(b,a).
r(a,c).
s(b,c).
s(b,d).
s(c,c).
s(d,e).

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

%factorial(+N,-F)
factorial(0,1).
factorial(1,1).
factorial(N,F) :-
    N > 0,
    N1 is N-1,
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

pow_rec(0,_,0).
pow_rec(X,1,X).

pow_rec(X,Y,P) :-
    Y>0,
    Y1 is Y-1,
    pow_rec(X,Y1,P1),
    P is P1*X.

%square_rec(+N,-S)
square_rec(N, S) :-
    square_rec_aux(N, N, 0, S).

%square_rec_aux(+N, +Count, +Acc, -S)
% Acc vai acumulando o resultado
% Count é o número de vezes que ainda falta somar N
square_rec_aux(_, 0, Acc, Acc).

square_rec_aux(N, Count, Acc, S) :-
    Count > 0,
    Acc1 is Acc + N,
    Count1 is Count - 1,
    square_rec_aux(N, Count1, Acc1, S).

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

factorial_tr(N,F) :-
    factorial_tr_aux(N,1,F).

factorial_tr_aux(0,Acc,Acc).
factorial_tr_aux(N,Acc,F) :-
    N > 0,
    Acc1 is Acc*N,
    N1 is N-1,
    factorial_tr_aux(N1,Acc1,F).

sum_rec_tr(N,S) :-
    sum_rec_tr_aux(N,0,S).

sum_rec_tr_aux(0,Acc,Acc).
sum_rec_tr_aux(N,Acc,S) :-
    N > 0,
    Acc1 is Acc+N,
    N1 is N-1,
    sum_rec_tr_aux(N1,Acc1,S).


pow_rec_tr(X,Y,P) :-
    pow_rec_tr_aux(X,Y,1,P).

pow_rec_tr_aux(_,0,Acc,Acc). % X^0=1
pow_rec_tr_aux(X,Y,Acc,P) :-
    Y > 0,
    Acc1 is Acc*X,
    Y1 is Y-1,
    pow_rec_tr_aux(X,Y1,Acc1,P).


square_rec_tr(N,S) :- square_rec_tr_aux(N,N,0,S).

square_rec_tr_aux(_,0,Acc,Acc).
square_rec_tr_aux(N,Count,Acc,S) :-
    Count > 0,
    Acc1 is Acc + N,
    Count1 is Count-1,
    square_rec_tr_aux(N,Count1,Acc1,S). 
