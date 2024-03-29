/**Question1(All Test Cases Passed. SB)
Predicate Name: sum-up-numbers-simple
Parameters: L is list and N is a sum-up-numbers-simple
Return a Boolean
**/

sum-up-numbers-simple([], 0).  %Empty List with Sum 0
sum-up-numbers-simple([H|T], N) :- 
    number(H),
    sum-up-numbers-simple(T, Remainder),
    N is H + Remainder.

sum-up-numbers-simple([_|T], N) :-
    sum-up-numbers-simple(T, N).  %All other cases

/**Question2(All Test Cases Passed. SB)
Predicate Name: sum-up-numbers-general
Parameters: L is a list and N is the sum of all numbers in L
Return a Boolean
If the head is a number, use the same logic as question1
If the head is a list, add the predicate with head and the rest of list
Else, ignore the head value
**/

sum-up-numbers-general([], 0). %Empty list with sum 0
%If head is a list, then use the Predicate sum-up-numbers-simple on head and add 
sum-up-numbers-general([H|T], N) :-
    is_list(H),
    sum-up-numbers-general(T, Remainder),
    sum-up-numbers-general(H, HeadSum),
    N is Remainder + HeadSum.
%If the head is number
sum-up-numbers-general([H|T], N) :-
    number(H),
    sum-up-numbers-general(T, Remainder),
    N is Remainder + H.
%If head is non-numeric or not list
sum-up-numbers-general([_|T], N) :-
    sum-up-numbers-general(T, N).

/*
Question3:
PredicateName: min-above-min
Params: L1, L2
Output: Minimum element of L1 > Minimum element of L2
*/

min-above-min([A], [], A) :-
    number(A).

%If the second list is empty, return the min of first list
min-above-min(L1, L2, N) :-
    length(L2, 0),
    min-val(L1, N).
%If the head is a number and greater than min-val, use the predicate larger-num
min-above-min([H|T], L2, H) :-
    number(H),
    min-val(L2, MinL),
    MinL < H,
    larger-num(T, MinL, H, H).
%Else, the answer is the predicate with tail list
min-above-min([_|T], L2, Ans) :-
    min-above-min(T, L2, Ans).



/*Question4
PredicateName: common-unique-elements\
Parameters: L1, L2, N
Result: Boolean
*/

common-unique-elements([], _, []). %Rule Statement
common-unique-elements([H|T], L2, [H|Tail]) :- %If member and only unique in list, add to the result list
    not(is-member(H, T)),
    is-member(H, L2),
    common-unique-elements(T, L2, Tail).

common-unique-elements([H|T], L2, ConcatList) :- %If the head is a list
    is_list(H),
    common-unique-elements(H, L2, Nested),
    common-unique-elements(T, L2, Tail),
    append(Nested, Tail, ConcatList). %append the nested list with the tail list

common-unique-elements([_|T], L2, Tail) :-   %If not, ignore the head
    common-unique-elements(T, L2, Tail).

/*Helper functions(Handles for nested lists)
PredicateName: is-member
Parameters: N is a number and L is a list
Return a boolean
*/

is-member(X, [X|_]). %Rule Statement
is-member(X, [K|Z]) :-
    is_list(K), %If K is a list, check the presence of X in K too.
    is-member(X, K); %Or Statement
    is-member(X,Z).  
is-member(X, [_|Z]) :-
    is-member(X, Z). %If does not match with head, look at list

/*
PredicateName: min-val
Parameters: L is a list
Output: smallest element of L
*/

min-val([B], B) :-
    number(B).
%If the first element is less than the second element,pass into recursion
min-val([H, K|T], M) :-
    number(H),
    number(K),
    H =< K,
    min-val([H|T], M).
%If second element is less than the first element
min-val([H, K|T], M) :-
    number(H),
    number(K),
    K < H,
    min-val([K|T], M).

%If the second element is non-numeric
min-val([H, _|T], M) :-
    number(H),
    min-val([H|T], M).
%Else, skip the head(non-numeric)
min-val([_|T], M) :-
    min-val(T, M).

/*
PredicateName: larger-num
Params: A list(L), a number(constant) , another number within list
Output: Returns the number greater than the constant
*/

larger-num([], _, Num, Num). 
%If the head is greater than const and less than num, set as target

larger-num([H|T], Const, Num, H) :-
    number(H),
    H > Const,
    H < Num,
    larger-num(T, Const, H, H).
%Else, ans is the result of predicate with tail of list
larger-num([_|T], Const, Num, Ans) :-
    larger-num(T, Const, Num, Ans).
