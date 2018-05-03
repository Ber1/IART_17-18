/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- reconsult(algorithms).


solve_problem(Sol):-
        retractall(estado_final(_)),
        retractall(estado_inicial(_)),
        findall(LocalX,local_inicial(LocalX),Locais),
        findall(PontoX,ponto_estrategico(PontoX),Pontos),
        assert(estado_inicial([Locais, Pontos])),
        findall(LocalX, (local_inicial(local(X,Y,_)),LocalX= local(X,Y,0)),Locais_final),
        findall(PontoX, (ponto_estrategico(_), PontoX= ponto(_,_,0)),Pontos_final),
        assert(estado_final([Locais_final, Pontos_final])),
        solve_astar(Sol).
        

