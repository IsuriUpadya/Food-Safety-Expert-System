% =========================================================
% HOME FOOD SAFETY ADVISOR
% Main Program
% =========================================================

:- consult('knowledge_base.pl').


% =========================================================
% DYNAMIC FACTS
% These store user answers temporarily
% =========================================================

:- dynamic selected_food/1.
:- dynamic cooking_temperature/1.

:- dynamic handled_raw_food/1.
:- dynamic washed_hands_after_raw_food/1.
:- dynamic washed_hands_before_preparation/1.

:- dynamic same_cutting_board/1.
:- dynamic cutting_board_cleaned/1.
:- dynamic raw_food_touched_ready_food/1.

:- dynamic refrigerator_temperature/1.
:- dynamic room_temperature_hours/1.
:- dynamic hot_environment/1.

:- dynamic produce_washed/1.
:- dynamic pasteurized/1.

:- dynamic leftovers/1.
:- dynamic reheating_temperature/1.
:- dynamic refrigerated_leftovers_promptly/1.

:- dynamic thawed_on_counter/1.
:- dynamic raw_food_stored_above_ready_food/1.

:- dynamic washed_raw_chicken/1.
:- dynamic egg_fully_cooked/1.



% =========================================================
% START PROGRAM
% =========================================================

start :-
    reset_answers,

    nl,
    writeln('=============================================='),
    writeln('       HOME FOOD SAFETY ADVISOR'),
    writeln('=============================================='),
    nl,

    ask_food_type,
    ask_hygiene_questions,
    ask_cross_contamination_questions,
    ask_cooking_questions,
    ask_storage_questions,
    ask_special_questions,

    nl,
    evaluate,

    nl,
    writeln('=============================================='),
    writeln('Assessment completed.'),
    writeln('==============================================').



% =========================================================
% RESET OLD USER ANSWERS
% =========================================================

reset_answers :-

    retractall(selected_food(_)),
    retractall(cooking_temperature(_)),

    retractall(handled_raw_food(_)),
    retractall(washed_hands_after_raw_food(_)),
    retractall(washed_hands_before_preparation(_)),

    retractall(same_cutting_board(_)),
    retractall(cutting_board_cleaned(_)),
    retractall(raw_food_touched_ready_food(_)),

    retractall(refrigerator_temperature(_)),
    retractall(room_temperature_hours(_)),
    retractall(hot_environment(_)),

    retractall(produce_washed(_)),
    retractall(pasteurized(_)),

    retractall(leftovers(_)),
    retractall(reheating_temperature(_)),
    retractall(refrigerated_leftovers_promptly(_)),

    retractall(thawed_on_counter(_)),
    retractall(raw_food_stored_above_ready_food(_)),

    retractall(washed_raw_chicken(_)),
    retractall(egg_fully_cooked(_)).



% =========================================================
% INPUT HELPERS
% =========================================================

ask_yes_no(Question, Answer) :-

    repeat,

    format('~w (yes/no): ', [Question]),

    read_line_to_string(user_input, Input),

    string_lower(Input, Lower),

    (
        Lower = "yes"
        ->
        Answer = yes,
        !

        ;

        Lower = "no"
        ->
        Answer = no,
        !

        ;

        writeln('Invalid input. Please enter yes or no.'),
        fail
    ).


ask_number(Question, Number) :-

    repeat,

    format('~w: ', [Question]),

    read_line_to_string(user_input, Input),

    (
        catch(number_string(Number, Input), _, fail)
        ->
        !

        ;

        writeln('Invalid number. Please try again.'),
        fail
    ).



% =========================================================
% FOOD TYPE
% =========================================================

ask_food_type :-

    nl,

    writeln('Select the food type:'),
    writeln('1 - Chicken'),
    writeln('2 - Ground Meat'),
    writeln('3 - Fish'),
    writeln('4 - Egg'),
    writeln('5 - Vegetables'),
    writeln('6 - Fruits'),
    writeln('7 - Dairy'),
    writeln('8 - Other'),

    ask_number('Enter choice', Choice),

    set_food_type(Choice),

    nl.


set_food_type(1) :-
    assertz(selected_food(chicken)).

set_food_type(2) :-
    assertz(selected_food(ground_meat)).

set_food_type(3) :-
    assertz(selected_food(fish)).

set_food_type(4) :-
    assertz(selected_food(egg)).

set_food_type(5) :-
    assertz(selected_food(vegetables)).

set_food_type(6) :-
    assertz(selected_food(fruits)).

set_food_type(7) :-
    assertz(selected_food(dairy)).

set_food_type(_) :-
    assertz(selected_food(other)).



% =========================================================
% HYGIENE QUESTIONS
% =========================================================

ask_hygiene_questions :-

    ask_yes_no(
        'Did you wash your hands before preparing food?',
        HandsBefore
    ),

    assertz(
        washed_hands_before_preparation(HandsBefore)
    ),

    ask_yes_no(
        'Did you handle raw meat, chicken or seafood?',
        RawFood
    ),

    assertz(
        handled_raw_food(RawFood)
    ),

    ask_yes_no(
        'Did you wash your hands after handling raw food?',
        HandsAfter
    ),

    assertz(
        washed_hands_after_raw_food(HandsAfter)
    ).



% =========================================================
% CROSS CONTAMINATION QUESTIONS
% =========================================================

ask_cross_contamination_questions :-

    nl,

    ask_yes_no(
        'Was the same cutting board used for raw food and ready-to-eat food?',
        SameBoard
    ),

    assertz(
        same_cutting_board(SameBoard)
    ),

    ask_yes_no(
        'Was the cutting board cleaned before reuse?',
        BoardCleaned
    ),

    assertz(
        cutting_board_cleaned(BoardCleaned)
    ),

    ask_yes_no(
        'Did raw food directly touch ready-to-eat food?',
        RawContact
    ),

    assertz(
        raw_food_touched_ready_food(RawContact)
    ).



% =========================================================
% COOKING QUESTIONS
% =========================================================

ask_cooking_questions :-

    selected_food(Food),

    (
        Food = chicken
        ;
        Food = ground_meat
        ;
        Food = fish
    ),

    !,

    nl,

    ask_number(
        'Enter measured cooking temperature in Celsius',
        Temperature
    ),

    assertz(
        cooking_temperature(Temperature)
    ).


ask_cooking_questions :-
    true.



% =========================================================
% STORAGE QUESTIONS
% =========================================================

ask_storage_questions :-

    nl,

    ask_number(
        'Enter refrigerator temperature in Celsius',
        FridgeTemperature
    ),

    assertz(
        refrigerator_temperature(FridgeTemperature)
    ),

    ask_number(
        'How many hours was the food left at room temperature?',
        Hours
    ),

    assertz(
        room_temperature_hours(Hours)
    ),

    ask_yes_no(
        'Was the environment very hot?',
        Hot
    ),

    assertz(
        hot_environment(Hot)
    ),

    ask_yes_no(
        'Was frozen food thawed on the kitchen counter?',
        Counter
    ),

    assertz(
        thawed_on_counter(Counter)
    ),

    ask_yes_no(
        'Was raw food stored above ready-to-eat food in the refrigerator?',
        RawAbove
    ),

    assertz(
        raw_food_stored_above_ready_food(RawAbove)
    ).



% =========================================================
% SPECIAL QUESTIONS
% =========================================================

ask_special_questions :-

    selected_food(Food),

    ask_produce_question(Food),
    ask_dairy_question(Food),
    ask_egg_question(Food),
    ask_chicken_question(Food),
    ask_leftovers_question.



% Produce

ask_produce_question(vegetables) :-

    ask_yes_no(
        'Were the vegetables washed before use?',
        Washed
    ),

    assertz(produce_washed(Washed)),

    !.


ask_produce_question(fruits) :-

    ask_yes_no(
        'Were the fruits washed before use?',
        Washed
    ),

    assertz(produce_washed(Washed)),

    !.


ask_produce_question(_) :-
    assertz(produce_washed(yes)).



% Dairy

ask_dairy_question(dairy) :-

    ask_yes_no(
        'Was the dairy product pasteurized?',
        Pasteurized
    ),

    assertz(pasteurized(Pasteurized)),

    !.


ask_dairy_question(_) :-
    assertz(pasteurized(yes)).



% Egg

ask_egg_question(egg) :-

    ask_yes_no(
        'Was the egg fully cooked?',
        Cooked
    ),

    assertz(egg_fully_cooked(Cooked)),

    !.


ask_egg_question(_) :-
    assertz(egg_fully_cooked(yes)).



% Chicken

ask_chicken_question(chicken) :-

    ask_yes_no(
        'Did you wash the raw chicken before cooking?',
        WashedChicken
    ),

    assertz(
        washed_raw_chicken(WashedChicken)
    ),

    !.


ask_chicken_question(_) :-
    assertz(washed_raw_chicken(no)).



% Leftovers

ask_leftovers_question :-

    nl,

    ask_yes_no(
        'Is this food being treated as leftovers?',
        LeftoverAnswer
    ),

    assertz(
        leftovers(LeftoverAnswer)
    ),

    ask_leftover_details(LeftoverAnswer).


ask_leftover_details(yes) :-

    ask_number(
        'Enter reheating temperature in Celsius',
        Temperature
    ),

    assertz(
        reheating_temperature(Temperature)
    ),

    ask_yes_no(
        'Were the leftovers refrigerated promptly?',
        Refrigerated
    ),

    assertz(
        refrigerated_leftovers_promptly(Refrigerated)
    ).


ask_leftover_details(no) :-

    assertz(reheating_temperature(100)),

    assertz(
        refrigerated_leftovers_promptly(yes)
    ).



% =========================================================
% INFERENCE ENGINE
% =========================================================

evaluate :-

    nl,

    writeln('=============================================='),
    writeln('                  RESULTS'),
    writeln('=============================================='),
    nl,

    findall(
        Rule,
        triggered_rule(Rule),
        Rules
    ),

    display_results(Rules).



% =========================================================
% RULE CHECKING
% =========================================================

triggered_rule(r01) :- rule_r01.
triggered_rule(r02) :- rule_r02.
triggered_rule(r03) :- rule_r03.
triggered_rule(r04) :- rule_r04.
triggered_rule(r05) :- rule_r05.
triggered_rule(r06) :- rule_r06.
triggered_rule(r07) :- rule_r07.
triggered_rule(r08) :- rule_r08.
triggered_rule(r09) :- rule_r09.
triggered_rule(r10) :- rule_r10.
triggered_rule(r11) :- rule_r11.
triggered_rule(r12) :- rule_r12.
triggered_rule(r13) :- rule_r13.
triggered_rule(r14) :- rule_r14.
triggered_rule(r15) :- rule_r15.
triggered_rule(r16) :- rule_r16.
triggered_rule(r17) :- rule_r17.
triggered_rule(r18) :- rule_r18.
triggered_rule(r19) :- rule_r19.
triggered_rule(r20) :- rule_r20.



% =========================================================
% DISPLAY RESULTS
% =========================================================

display_results([]) :-

    writeln('RESULT: No configured food-safety warnings were triggered.'),

    nl,

    writeln(
        'The entered conditions passed all checks implemented in the system.'
    ).


display_results(Rules) :-

    writeln('RESULT: FOOD-SAFETY WARNING(S) DETECTED'),

    nl,

    display_rule_list(Rules).


display_rule_list([]).


display_rule_list([Rule | Rest]) :-

    explain_rule(Rule),

    nl,

    display_rule_list(Rest).



% =========================================================
% EXPLANATION FACILITY
% =========================================================

explain_rule(r01) :-
    writeln('[R01] Handwashing risk'),
    writeln(
        'Reason: Raw food was handled and hands were not washed afterward.'
    ).


explain_rule(r02) :-
    writeln('[R02] Cutting-board cross-contamination risk'),
    writeln(
        'Reason: The same cutting board was reused without proper cleaning.'
    ).


explain_rule(r03) :-
    writeln('[R03] Direct cross-contamination risk'),
    writeln(
        'Reason: Raw food directly touched ready-to-eat food.'
    ).


explain_rule(r04) :-

    cooking_temperature(T),

    writeln('[R04] Chicken cooking-temperature warning'),

    format(
        'Reason: Chicken reached only ~w C. The configured minimum is 74 C.~n',
        [T]
    ).


explain_rule(r05) :-

    cooking_temperature(T),

    writeln('[R05] Ground-meat cooking-temperature warning'),

    format(
        'Reason: Ground meat reached only ~w C. The configured minimum is 71 C.~n',
        [T]
    ).


explain_rule(r06) :-

    cooking_temperature(T),

    writeln('[R06] Fish cooking-temperature warning'),

    format(
        'Reason: Fish reached only ~w C. The configured minimum is 63 C.~n',
        [T]
    ).


explain_rule(r07) :-

    refrigerator_temperature(T),

    writeln('[R07] Refrigerator-temperature warning'),

    format(
        'Reason: Refrigerator temperature is ~w C. The configured maximum is 4 C.~n',
        [T]
    ).


explain_rule(r08) :-

    room_temperature_hours(H),

    writeln('[R08] Room-temperature storage warning'),

    format(
        'Reason: Food remained at room temperature for ~w hours.~n',
        [H]
    ).


explain_rule(r09) :-
    writeln('[R09] Hot-environment warning'),
    writeln(
        'Reason: Food remained outside refrigeration too long in a hot environment.'
    ).


explain_rule(r10) :-
    writeln('[R10] Unwashed vegetables warning'),
    writeln(
        'Reason: Vegetables were not washed before use.'
    ).


explain_rule(r11) :-
    writeln('[R11] Unwashed fruit warning'),
    writeln(
        'Reason: Fruit was not washed before use.'
    ).


explain_rule(r12) :-
    writeln('[R12] Unpasteurized dairy warning'),
    writeln(
        'Reason: The dairy product was identified as unpasteurized.'
    ).


explain_rule(r13) :-

    reheating_temperature(T),

    writeln('[R13] Leftover reheating warning'),

    format(
        'Reason: Leftovers were reheated only to ~w C. The configured target is 74 C.~n',
        [T]
    ).


explain_rule(r14) :-
    writeln('[R14] Unsafe thawing warning'),
    writeln(
        'Reason: Frozen food was thawed on the kitchen counter.'
    ).


explain_rule(r15) :-
    writeln('[R15] Refrigerator cross-contamination warning'),
    writeln(
        'Reason: Raw food was stored above ready-to-eat food.'
    ).


explain_rule(r16) :-
    writeln('[R16] Handwashing-before-preparation warning'),
    writeln(
        'Reason: Hands were not washed before preparing food.'
    ).


explain_rule(r17) :-
    writeln('[R17] Raw chicken washing warning'),
    writeln(
        'Reason: Raw chicken was washed before cooking.'
    ).


explain_rule(r18) :-
    writeln('[R18] Leftover refrigeration warning'),
    writeln(
        'Reason: Leftovers were not refrigerated promptly.'
    ).


explain_rule(r19) :-
    writeln('[R19] Egg cooking warning'),
    writeln(
        'Reason: The egg was reported as not fully cooked.'
    ).


explain_rule(r20) :-
    writeln('[R20] Leftover room-temperature warning'),
    writeln(
        'Reason: Leftovers remained at room temperature for more than two hours.'
    ).