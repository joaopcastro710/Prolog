% author(AuthorID, Name, YearOfBirth, CountryOfBirth).

author(1, 'John Grisham', 1955, 'USA').
author(2, 'Wilbur Smith', 1933, 'Zambia').
author(3, 'Stephen King', 1947, 'USA').
author(4, 'Michael Crichton', 1942, 'USA').

% book(Title, AuthorID, YearOfRelease, Pages, Genres).

book('The Firm', 1, 1991, 432, ['Legal thriller']).
book('The Client', 1, 1993, 422, ['Legal thriller']).
book('The Runaway Jury', 1, 1996, 414, ['Legal thriller']).
book('The Exchange', 1, 2023, 338, ['Legal thriller']).

book('Carrie', 3, 1974, 199, ['Horror']).
book('The Shining', 3, 1977, 447, ['Gothic novel', 'Horror', 'Psychological horror']).
book('Under the Dome', 3, 2009, 1074, ['Science fiction', 'Political']).
book('Doctor Sleep', 3, 2013, 531, ['Horror', 'Gothic', 'Dark fantasy']).

book('Jurassic Park', 4, 1990, 399, ['Science fiction']).
book('Prey', 4, 2002, 502, ['Science fiction', 'Techno-thriller', 'Horror', 'Nanopunk']).
book('Next', 4, 2006, 528, ['Science fiction', 'Techno-thriller', 'Satire']).


% 1

book_author(Title,Author) :-
    author(AID,Author,_,_),
    book(Title,AID,_,_,_).

% 2

multi_genre_book(Title) :-
    book(Title,_AuthorID,_YearOfRelease,_Pages,Genres),
    length(Genres,Num),
    Num > 1.

% 3

shared_genres(Title1,Title2,CommonGenres) :-
    book(Title1,_AuthorID1,_YearOfRelease1,_Pages1,Genres1),
    book(Title2,_AuthorID2,_YearOfRelease2,_Pages2,Genres2),
    common(Genres1,Genres2,CommonGenres).

common([],_,[]).
common([H|T],G2,[H|CommonGenres]) :-
    member(H,G2),
    common(T,G2,CommonGenres).

common([H|T],G2,CommonGenres) :-
    \+member(H,G2),
    common(T,G2,CommonGenres).


% 4

similarity(Title1,Title2,Similarity) :-
    book(Title1,_AuthorID1,_YearOfRelease1,_Pages1,Genres1),
    book(Title2,_AuthorID2,_YearOfRelease2,_Pages2,Genres2),
    common(Genres1,Genres2,CommonGenres),
    length(CommonGenres,Intersection),
    length(Genres1,G1L),
    length(Genres2,G2L),
    Union is G1L+G2L-Intersection,
    Similarity is Intersection/Union.


% gives_gift_to(Giver, Gift, Receiver)
gives_gift_to(bernardete, 'The Exchange', celestina).
gives_gift_to(celestina, 'The Brethren', eleuterio).
gives_gift_to(eleuterio, 'The Summons', felismina).
gives_gift_to(felismina, 'River God', juvenaldo).
gives_gift_to(juvenaldo, 'Seventh Scroll', leonilde).
gives_gift_to(leonilde, 'Sunbird', bernardete).

gives_gift_to(marciliano, 'Those in Peril', nivaldo).
gives_gift_to(nivaldo, 'Vicious Circle', sandrino).
gives_gift_to(sandrino, 'Predator', marciliano).

% 6

circle_size(Person,Size) :-
    collect([Person],People),
    length(People,Size).


collect([H|T],People) :-
    gives_gift_to(H,_,N),
    \+member(N,[H|T]),!,
    collect([N,H|T],People).
collect(People,People).

% 10

dec2bin(Dec,List,N) :-
    Dec >= 0,
    dec2bin(Dec,[],List,N).

dec2bin(0,List,List,0):-!
dec2bin(Dec,Acc,List,N) :-
    N>0,
    Bit is Dec mod 2,
    Next is Dec div 2,
    N1 is N-1,
    dec2bin(Next,[Bit|Acc],List,N1).

initialize(Dec, N, Padd, List):
dec2bin(Dec, Mid, N),
dec2bin(0, Side, Padd),
append([Side, Mid, Side], List).