/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */


/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */

%montanhas onde existem pessoas para evacuar
%local(Coordenada X, Coordenada Y, n�mero de turistas por evacuar)
local_inicial(local(0,1,17)).
local_inicial(local(1,2,23)).

/*local de abrigo*/
%local_final(Coordenada X, Coordenada Y)
local_final(10,1).

%capacidade dos v�iculos utilizados para evacuar turistas
capacidade_veiculos(5).

%ponto estrat�gicos
%local(Coordenada X, Coordenada Y, n�mero de pessoas na carrinha)
ponto_estrategico(ponto(2,1,0)).
ponto_estrategico(ponto(3,2,0)).
ponto_estrategico(ponto(4,3,0)).
ponto_estrategico(ponto(5,4,0)).
ponto_estrategico(ponto(6,1,0)).
ponto_estrategico(ponto(7,2,0)).

ponto_estrategico(ponto(1,2,0)).
ponto_estrategico(ponto(2,3,0)).
ponto_estrategico(ponto(3,4,0)).
ponto_estrategico(ponto(4,4,0)).
ponto_estrategico(ponto(1,6,0)).
ponto_estrategico(ponto(2,7,0)).


        

        



        
        
        
     


