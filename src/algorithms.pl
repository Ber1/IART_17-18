/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- use_module(library(lists)).

/***********************************
A* ALGORITHM
***********************************/

average( List, Average ):- 
    sumlist( List, Sum ),
    length( List, Length ),
    Length > 0, 
    Average is ceiling(Sum / Length).

replace(I, L, E, K) :-
  nth0(I, L, _, R),
  nth0(I, K, E, R).

replaceAllLocais([],[]).
replaceAllLocais([local(X,Y,_)|T1], [local(X,Y,0)|T2]):-
        replaceAllLocais(T1,T2).

/*heuristica*/
h([Locais,Pontos],H):-
  findall(C1,(member(local(XL,YL,_),Locais),member(ponto(XP,YP,_),Pontos),C1 is abs(XL-XP)+abs(YL-YP)),Costs1),
  findall(C2,(member(local(XL2,YL2,_),Locais),local_final(XP2,YP2),C2 is abs(XL2-XP2)+abs(YL2-YP2)),Costs2),
  append(Costs1,Costs2,Costs),
  average(Costs,AverageCostOfATrip),
  findall(NPeople,member(local(_,_,NPeople),Locais),TotalPeople),
  sumlist( TotalPeople, SumTotalPeople ),
  capacidade_veiculos(VehiclesCapacity),
  NumberOfTrips is ceiling(SumTotalPeople/VehiclesCapacity),
  H is ceiling(AverageCostOfATrip*NumberOfTrips).

estado_final([Locais,Pontos]):-
        checkLocais(Locais),!,checkPontos(Pontos).

estado_final([Locais,Pontos]):-
        local_final(LFX,LFY),
        findall(1,(
                      member(ponto(XP,YP,_),Pontos),
                      (XP\==LFX;YP\==LFY),
                      member(local(XL,YL,_),Locais), 
                      C1 is abs(XL-XP)+abs(YL-YP),
                      C2 is abs(XL-LFX)+abs(YL-LFY),
                      C1<C2
                  ),Exists),
        length( Exists, Length ),
        Length ==0,
        replaceAllLocais(Locais,NewLocais),
        nl,write([NewLocais,Pontos]),nl,nl,
        write('Sendo que já não existem mais veículos em pontos estratégicos diferentes ou com menor custo de viagem que o local final podemos encerrar o algoritmo.\nAs viagens apartir deste momento serão sempre feitas entre o local final e as montanhas com pessoas por evacuar!'),
        nl,nl.
                           

checkLocais([]).
checkLocais([local(_,_,NP)|T]):- NP==0,checkLocais(T).

checkPontos([]).
checkPontos([ponto(_,_,NP)|T]):- NP==0, checkPontos(T).
  

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





sucessor(Locais,Pontos, NewE,local(XL,YL,NP),ponto(XP,YP,PP),PosLocal,PosPonto,C):-
        NP>0,
        capacidade_veiculos(CV),
        Capacity is CV-PP,
        NP>=Capacity,
        NewNP is NP-Capacity,
        replace(PosLocal,Locais,local(XL,YL,NewNP),NewLocais),
        local_final(LFX,LFY),
        replace(PosPonto,Pontos,ponto(LFX,LFY,0),NewPontos),
        NewE = [NewLocais,NewPontos],
        C is abs(XL-XP)+abs(YL-YP).

sucessor(Locais,Pontos, NewE,local(XL,YL,NP),ponto(XP,YP,PP),PosLocal,PosPonto,C):-
        NP>0,
        capacidade_veiculos(CV),
        Capacity is CV-PP,
        NP<Capacity,
        NewPP is PP+NP,
        replace(PosLocal,Locais,local(XL,YL,0),NewLocais),
        replace(PosPonto,Pontos,ponto(XL,YL,NewPP),NewPontos),
        NewE = [NewLocais,NewPontos],
        C is abs(XL-XP)+abs(YL-YP).

sucessor(Locais,Pontos, NewE,_,ponto(_,_,PP),_,PosPonto,C):-
        PP>0,
        local_final(LFX,LFY),
        replace(PosPonto,Pontos,ponto(LFX,LFY,0),NewPontos),
        NewE = [Locais,NewPontos],
        C is 0.



