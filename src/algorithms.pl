/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

:- reconsult(problem).

/***********************************
A* ALGORITHM
***********************************/

/*heuristica*/
h(local(_,_,N),H):-
  estado_final(local(_,_,Nf)),
  H is Nf-N.

/*caso base*/
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




