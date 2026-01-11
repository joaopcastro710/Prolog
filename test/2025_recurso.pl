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

book_genre(Title,Genre) :-
    book(Title,_,_,_,Genres),
    member(Genre,Genres).

% 2

author_wrote_book_at_age(Author,Title,Age) :-
    author(AuthorID,Author,YearOfBirth,_),
    book(Title,AuthorID,YearOfRelease,_,_),
    Age is YearOfRelease-YearOfBirth.

% 3

youngest_author(Author) :-
    author_wrote_book_at_age(Author,_Title,_Age),
    \+ (author_wrote_book_at_age(_Author2,_Title2,_Age2), _Age2 < _Age).

% 4

genres(Book) :-
    book(Book,_AuthorID,_Year,_Pages,Genres),
    member(Genre,Genres),
    write(Genre),nl,
    fail.

genres(_Book).

% 5

filterArgs(Term,Indexes,NewTerm) :-
    Term =.. [F|_Args],
    filterAux(Indexes,Term,NewArgs),
    NewTerm =.. [F|NewArgs].

filterAux([],_,[]).
filterAux([Idx|Idxs],Term,[Arg|Rest]) :-
    arg(Idx,Term,Arg),
    filterAux(Idxs,Term,Rest).

% 6

diverse_books(Books) :-
    findall(Title,(book(Title,_,_,_,Genres),length(Genres,Len), \+ ((book(_,_,_,_,Genres2),length(Genres2,Len2),Len2>Len))),Books).


% 7 
country_authors(Country,Authors) :-
    bagof(Author,(AuthorID,YearOfBirth)^author(AuthorID,Author,YearOfBirth,Country),Authors).


read_book(bernardete, 'The Firm').
read_book(bernardete, 'The Client').
read_book(clarice, 'The Firm').
read_book(clarice, 'Carrie').
read_book(deirdre, 'The Firm').
read_book(deirdre, 'Next').



popular(Title) :-
    setof(Person,_B^read_book(Person,_B),People),
    length(People,NTotal),
    setof(Person,read_book(Person,Title),HaveRead),
    length(HaveRead,N),
    N/NTotal >=0.75.



