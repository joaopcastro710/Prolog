:-dynamic by/3.

% by(Character, Movie, Actor)
by(jackRyan, theSumOfAllFears, benAffleck).
by(cathyMuller, theSumOfAllFears, bridgetMoynahan).
by(jackRyan, theHuntForRedOctober, alecBaldwin).
by(jackRyan, patriotGames, harrisonFord).
by(cathyMuller, patriotGames, anneArcher).
by(jackRyan, clearAndPresentDanger, harrisonFord).
by(cathyMuller, clearAndPresentDanger, anneArcher).
by(president, airForceOne, harrisonFord).
by(frasierCrane, cheers, kelseyGrammer).
by(frasierCrane, frasier, kelseyGrammer).
by(rachelGreen, friends, jenniferAniston).
by(monicaGeller, friends, courteneyCox).
by(phoebeBuffay, friends, lisaKudrow).
by(ursulaBuffay, friends, lisaKudrow).
by(joeyTribbiani, friends, mattLeBlanc).
by(joeyTribbiani, joey, mattLeBlanc).
by(alexGarrett, joey, andreaAnders).
by(stephenColbert, dailyShow, stephenColbert).
by(stephenColbert, theColbertReport, stephenColbert).
by(addisonMontgomery, privatePractice, kateWalsh).
by(addisonMontgomery, greysAnatomy, kateWalsh).
by(mattMurdock, daredevil, benAffleck).
by(elektraNatchios, daredevil, jenniferGarner).
by(elektraNatchios, elektra, jenniferGarner).
by(elektraNatchios, elektra, lauraWard).
by(sydneyBristow, alias, jenniferGarner).

% 11

plays_twins(Actor,Movie) :-
    by(Actor, Movie, Char1),
    by(Actor, Movie, Char2),
    Char1 \= Char2.


% 12


actor_movies(Actor,L) :-
    actor_movies(Actor,[],L).

actor_movies(Actor,Acc,L) :-
    by(_Char,Movie,Actor),
    \+member(Movie,Acc),!,
    actor_movies(Actor,[Movie|Acc],L).
actor_movies(_Actor,Acc,Acc).

% 14

playedBy(Character,List) :-
    setof(Actor,Movie^by(Character,Movie,Actor),Actors),
    findall(A-Ms, (member(A,Actors),findall(M,by(Character,M,A),Ms)),List).

% 15

most_popular(Exclude,List,NMovies) :-
    setof(N-Actor,(_Char,_Movie,_Movies)^(by(_Char,_Movie,Actor), \+ member(Actor,Exclude),actor_movies(Actor,_Movies),length(_Movies,N)),TempL),last(TempL,NMovies-_),findall(Actor,member(NMovies-Actor,TempL),List).

