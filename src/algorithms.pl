/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(lists)).
:- reconsult(problem).

/***********************************
A* ALGORITHM
***********************************/

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

