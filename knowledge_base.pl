% =========================================================
% HOME FOOD SAFETY ADVISOR
% Knowledge Base
% =========================================================


% =========================================================
% FACTS
% =========================================================

% Minimum safe cooking temperatures in Celsius
safe_temperature(chicken, 74).
safe_temperature(ground_meat, 71).
safe_temperature(fish, 63).
safe_temperature(leftovers, 74).
safe_temperature(whole_meat, 63).

% Storage facts
maximum_refrigerator_temperature(4).
maximum_room_temperature_hours(2).
maximum_hot_environment_hours(1).

% Hygiene facts
recommended_handwashing_seconds(20).

% Foods requiring refrigeration
requires_refrigeration(chicken).
requires_refrigeration(meat).
requires_refrigeration(fish).
requires_refrigeration(dairy).
requires_refrigeration(leftovers).

% Foods associated with cross-contamination
cross_contamination_source(raw_chicken).
cross_contamination_source(raw_meat).
cross_contamination_source(raw_fish).

% Produce that should be washed
requires_washing(fruits).
requires_washing(vegetables).

% Higher-risk food examples
high_risk_food(raw_chicken).
high_risk_food(raw_meat).
high_risk_food(raw_egg).
high_risk_food(unpasteurized_milk).

% Additional food safety facts
should_not_wash(raw_chicken).
should_not_thaw_on_counter(frozen_food).
should_store_raw_below_ready_food(raw_food).



% =========================================================
% RULES
% =========================================================

% R01 - Hands not washed after handling raw food
rule_r01 :-
    handled_raw_food(yes),
    washed_hands_after_raw_food(no).


% R02 - Same cutting board reused without cleaning
rule_r02 :-
    same_cutting_board(yes),
    cutting_board_cleaned(no).


% R03 - Raw food touched ready-to-eat food
rule_r03 :-
    raw_food_touched_ready_food(yes).


% R04 - Chicken below safe temperature
rule_r04 :-
    selected_food(chicken),
    cooking_temperature(T),
    safe_temperature(chicken, Required),
    T < Required.


% R05 - Ground meat below safe temperature
rule_r05 :-
    selected_food(ground_meat),
    cooking_temperature(T),
    safe_temperature(ground_meat, Required),
    T < Required.


% R06 - Fish below safe temperature
rule_r06 :-
    selected_food(fish),
    cooking_temperature(T),
    safe_temperature(fish, Required),
    T < Required.


% R07 - Refrigerator too warm
rule_r07 :-
    refrigerator_temperature(T),
    maximum_refrigerator_temperature(Max),
    T > Max.


% R08 - Food outside too long
rule_r08 :-
    room_temperature_hours(H),
    maximum_room_temperature_hours(Max),
    H > Max.


% R09 - Food outside too long in hot environment
rule_r09 :-
    hot_environment(yes),
    room_temperature_hours(H),
    maximum_hot_environment_hours(Max),
    H > Max.


% R10 - Vegetables not washed
rule_r10 :-
    selected_food(vegetables),
    produce_washed(no).


% R11 - Fruits not washed
rule_r11 :-
    selected_food(fruits),
    produce_washed(no).


% R12 - Dairy product not pasteurized
rule_r12 :-
    selected_food(dairy),
    pasteurized(no).


% R13 - Leftovers reheated below safe temperature
rule_r13 :-
    leftovers(yes),
    reheating_temperature(T),
    safe_temperature(leftovers, Required),
    T < Required.


% R14 - Frozen food thawed on counter
rule_r14 :-
    thawed_on_counter(yes).


% R15 - Raw food stored above ready-to-eat food
rule_r15 :-
    raw_food_stored_above_ready_food(yes).


% R16 - Hands not washed before food preparation
rule_r16 :-
    washed_hands_before_preparation(no).


% R17 - Raw chicken was washed
rule_r17 :-
    selected_food(chicken),
    washed_raw_chicken(yes).


% R18 - Leftovers not refrigerated promptly
rule_r18 :-
    leftovers(yes),
    refrigerated_leftovers_promptly(no).


% R19 - Egg not fully cooked
rule_r19 :-
    selected_food(egg),
    egg_fully_cooked(no).


% R20 - Leftovers kept outside more than two hours
rule_r20 :-
    leftovers(yes),
    room_temperature_hours(H),
    H > 2.