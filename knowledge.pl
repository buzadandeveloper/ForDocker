% Facts: types of cars
car(electric).
car(suv).
car(luxury_sedan).
car(sports_car).

% Budgets in USD
budget(electric, 20000).
budget(suv, 35000).
budget(luxury_sedan, 60000).
budget(sports_car, 80000).

% Features
eco_friendly(electric).
needs_space(suv).
needs_space(luxury_sedan).
likes_speed(sports_car).

% Flexible recommendation: always returns at least one car
recommends(Car, MaxBudget, NeedsEco, NeedsSpace, LikesSpeed) :-
    car(Car),
    budget(Car, Price),
    % primary: match all requested conditions under budget
    Price =< MaxBudget,
    (NeedsEco = yes -> eco_friendly(Car) ; true),
    (NeedsSpace = yes -> needs_space(Car) ; true),
    (LikesSpeed = yes -> likes_speed(Car) ; true).

recommends(Car, MaxBudget, _, _, _) :-
    % fallback: return any car under budget + 20000 if no match
    car(Car),
    budget(Car, Price),
    Price =< MaxBudget + 20000.
