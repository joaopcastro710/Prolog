% dish(Name, Price, IngredientGrams).
dish(pizza,2200, [cheese-300, tomato-350]).
dish(ratatouille,2200, [tomato-70, eggplant-150, garlic-50]).
dish(garlic_bread,  1600, [cheese-50, garlic-200]).

:- dynamic ingredient/2.

% ingredient(Name, CostPerGram).
ingredient(cheese,4).
ingredient(tomato,2).
ingredient(eggplant,7).
ingredient(garlic,6).


%1

%count_ingredients(?Dish,?NumIngredients)

count_ingredients(Dish,Num) :-
    dish(Dish,_,Ingredients),
    length(Ingredients, Num).
    
% 2

%ingredient_amount_cost(?Ingredient, +Grams, ?TotalCost)

ingredient_amount_cost(Ingredient,Grams,Cost) :-
    ingredient(Ingredient,CostPG),
    Cost is Grams * CostPG.

% 3

%dish_profit(?Dish,?Profit)
dish_profit(Dish, Profit) :-
    dish(Dish,Price,Ingredients),
    cost_dish(Ingredients,TotalCost),
    Profit is Price - TotalCost.
    
cost_dish([],0).
cost_dish([A-B|T],TotalCost) :-
    ingredient_amount_cost(A,B,Cost),
    cost_dish(T,TotalCost1),
    TotalCost is TotalCost1+Cost.

% 4

% update_unit_cost(+Ingredient,+NewUnitCost)

% 5

% most_expensive_dish(?Dish, ?Price)
most_expensive_dish(Dish,Price) :-
    dish(Dish,Price,_Ingredients),
    \+ (dish(_,OtherPrice,_),OtherPrice > Price).


% 6 

consume_ingredient(IngredientStocks, Ingredient, Grams,NewIngredientStocks) :-
    append(Before,[Ingredient-OldAmount|After],IngredientStocks),
    OldAmount >= Grams,
    NewAmount is OldAmount - Grams,
    append(Before,[Ingredient-NewAmount | After],NewIngredientStocks).


% 7

count_dishes_with_ingredient(Ingredient, N) :-
    count_dishes_with_ingredient_acc(Ingredient, 0, N).

count_dishes_with_ingredient_acc(Ingredient, Acc, N) :-
    dish(_, _, Ingredients),
    member(Ingredient-_, Ingredients),
    Acc1 is Acc + 1,
    count_dishes_with_ingredient_acc(Ingredient, Acc1, N).

count_dishes_with_ingredient_acc(_, N, N).


% dish(Name, Price, IngredientGrams).

% 8
list_dishes(DishIngredients) :-
    findall(Dish-IngredientNames,
        ( dish(Dish, _, Ingredients),
          findall(Ing, member(Ing-_, Ingredients), IngredientNames)
        ),
        DishIngredients).

% 9

reverse(L, R) :-
    reverse_acc(L, [], R).

reverse_acc([], Acc, Acc).
reverse_acc([H|T], Acc, R) :-
    reverse_acc(T, [H|Acc], R).

most_lucrative_dishes(Dishes) :-
    findall(Profit-Dish,
        dish_profit(Dish, Profit),
        Pairs),
    keysort(Pairs, SortedAsc),
    reverse(SortedAsc, SortedDesc),
    findall(Dish, member(_-Dish, SortedDesc), Dishes).

