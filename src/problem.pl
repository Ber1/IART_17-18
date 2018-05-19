/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

%locais onde existem pessoas para evacuar
local_inicial(local(0,0,20)).
local_inicial(local(1,0,15)).
local_inicial(local(11,0,20)).
local_final(10,0).

:- dynamic estado_inicial/1.
:- dynamic estado_final/1.

capacidade_veiculos(5).

%ponto estratégicos
%local(Coordenada X, Coordenada Y, número de pessoas na carrinha)
ponto_estrategico(ponto(2,0,0)).
ponto_estrategico(ponto(3,0,0)).
ponto_estrategico(ponto(4,0,0)).
ponto_estrategico(ponto(5,0,0)).
ponto_estrategico(ponto(6,0,0)).
ponto_estrategico(ponto(7,0,0)).

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
        

        



        
        
        
     


