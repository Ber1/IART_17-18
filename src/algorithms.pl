/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(lists)).
:- reconsult(problem).

/***********************************
A* ALGORITHM
***********************************/
/*

h(local(_,_,N),H):-
  estado_final(local(_,_,Nf)),
  H is Nf-N.

astar([ (_,_,[E-P|Cam]) |_],[E-P|Cam],_):-
  estado_final(E).


astar([(F,G,[E-OldPonto|Can])|R],Sol,LP):-
    write(E - F:G),nl,
    append([OldPonto],LP,NewLP),
    findall((F2,G2,[E2-Ponto|[E-OldPonto|Can]]),(ponto_estrategico(Ponto),sucessor(E,E2,Ponto,C,NewLP),G2 is G+C,h(E2,H2),F2 is G2+H2), Ls),
    sucessor_final(Ls,NewLS,LP,G,[E-OldPonto|Can]),
    append(R,NewLS,L2),
    sort(L2,L2ord),
    astar(L2ord,Sol,NewLP).

sucessor_final(Ls,Ls,[],_). 
sucessor_final(Ls,NewLS,_,G,[E-OldPonto|Can]):-
        sucessor_ponto_final(E,E2,C),G2 is G+C,h(E2,H2),F2 is G2+H2,
        estado_final(local(X,Y,_)),
        append(Ls,[(F2,G2,[E2-ponto(X,Y)|[E-OldPonto|Can]])],NewLS).


solve_astar(Sol):-
  estado_inicial(Ei),h(Ei,Hi),
  astar([(Hi,0,[Ei-''])],Sol,[]).
*/
average( List, Average ):- 
    sumlist( List, Sum ),
    length( List, Length ),
    Length > 0, 
    Average is Sum / Length.

replace(I, L, E, K) :-
  nth0(I, L, _, R),
  nth0(I, K, E, R).

/*heuristica*/
h([Locais,Pontos],H):-
  findall(C,(member(local(XL,YL,_),Locais),member(ponto(XP,YP,_),Pontos),C is abs(XL-XP)+abs(YL-YP)),Costs1),
  findall(C,(member(local(XL,YL,_),Locais),local_final(XP,YP),C is abs(XL-XP)+abs(YL-YP)),Costs2),
  append(Costs1,Costs2,Costs),
  average(Costs,AverageCostOfATrip),
  findall(NPeople,member(local(_,_,NPeople),Locais),TotalPeople),
  sumlist( TotalPeople, SumTotalPeople ),
  capacidade_veiculos(VehiclesCapacity),
  NumberOfTrips is SumTotalPeople/VehiclesCapacity,
  H is AverageCostOfATrip*NumberOfTrips.
  
  

/*caso base*/
astar([ (_,_,[E|Cam]) |_],[E|Cam]):-
  estado_final(E).

astar([(_,G,[[Locais,Pontos]|Can])|R],Sol):-
    findall((F2,G2,[E2|[[Locais,Pontos]|Can]]),
            (nth0(PosLocal,Locais,Local),nth0(PosPonto,Pontos,Ponto),
             sucessor(Locais,Pontos,E2,Local,Ponto,PosLocal,PosPonto,C),
             G2 is G+C,h(E2,H2),F2 is G2+H2), 
            Ls),
    append(R,Ls,L2),
    sort(L2,L2ord),
    astar(L2ord,Sol).


solve_astar(Sol):-
  estado_inicial(Ei),h(Ei,Hi),
  astar([(Hi,0,[Ei])],Sol).
/***********************************
BFS ALGORITHM
***********************************/


bfs([[E|Cam]|_],[E|Cam]):-
  estado_final(E).

bfs([[E|Cam]|R],Sol):-
  findall([E2|[E|Cam]],sucessor(E,E2),Ls),
  append(R,Ls,L2),
  bfs(L2,Sol).


solve_bfs(Sol):-
  estado_inicial(Ei),
  bfs([[Ei]],Sol).

/***********************************
DFS ALGORITHM
***********************************/
dfs(E,_,[E]):-estado_final(E).

dfs(E,Visited,[E|Es]):-
  sucessor(E,E2), \+ member(E2,Visited),
  dfs(E2,[E2|Visited],Es).

solve_dfs(Sol):-
  estado_inicial(Ei),
  dfs(Ei,[Ei],Sol).



/***********************************
ITERATIVE DEEPNING ALGORITHM
***********************************/
s(a, b).
s(b, c).
s(c, d).
s(a, d).

goal(d).

/* Solution is the inverse list of the visited node 
           from the start node Node and a goal node
           if it is TRUE that:

   path/3 predicate is TRUE (Solution is the inverse list 
           from the start node Node and a GoalNode)
           and it is TRUE that GoalNode is a goal 
*/
depth_first_iterative_deepening(Node, Solution) :- 
    path(Node, GoalNode, Solution),
    goal(GoalNode).

/* Path/3 predicate generate, for the given initial node, 
           all the possibles acyclic paths of increasing
           length
*/

/* BASE CASE: The shorter path from a node X to itself is Path=[X] */
path(Node, Node, [Node]).

/* GENERAL CASE: If I have to go from a start node X 
           to an end node Y and X != Y
   [LastNode|Path] is the path from FirstNode and LastNode 
           if it is TRUE that:

   1) Path is the path from FirstNode and OneButLast node
   2) Exist an edge from OneButLast and LastNode
   3) I have yet never visited LastNode
*/
path(FirstNode, LastNode, [LastNode|Path]) :- 
    path(FirstNode, OneButLast, Path),
    s(OneButLast, LastNode),
    \+(member(LastNode, Path)).




