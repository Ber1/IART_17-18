/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

%locais onde existem pessoas para evacuar
local_inicial(local(0,0,20)).
%estado inicial
%local(Coordenada X, Coordenada Y, número de pessoas)
estado_inicial(local(10,0,0)).

%estado final
%local(Coordenada X, Coordenada Y, número de pessoas)
estado_final(local(10,0,20)).

capacidade_veiculos(5).

%ponto estratégicos
%local(Coordenada X, Coordenada Y, número de pessoas que podem ser evacuadas numa viagem)
ponto_estrategico(ponto(1,0)).
ponto_estrategico(ponto(2,0)).
ponto_estrategico(ponto(3,0)).
ponto_estrategico(ponto(4,0)).
ponto_estrategico(ponto(5,0)).
ponto_estrategico(ponto(6,0)).

%sucessor pontos     
sucessor(local(X,Y,N), local(X,Y,NN),ponto(PX,PY),C,LP) :-
        \+ member(ponto(PX,PY),LP),
        local_inicial(local(LX,LY,_)),
        C is (abs(PX-LX)+abs(PY-LY)),
        capacidade_veiculos(Capacidade),
        NN is N+Capacidade.

sucessor_ponto_final(local(X,Y,N), local(X,Y,NN),C) :-
        local_inicial(local(LX,LY,_)),
        C is (abs(X-LX)+abs(Y-LY)),
        capacidade_veiculos(Capacidade),
        NN is N+Capacidade.



        
        
        
     

