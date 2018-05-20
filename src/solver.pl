/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- reconsult(algorithms).
:- reconsult(problem).

:- dynamic estado_inicial/1.


solve_problem:-
        retractall(estado_inicial(_)),
        findall(LocalX,local_inicial(LocalX),Locais),
        findall(PontoX,ponto_estrategico(PontoX),Pontos),
        assert(estado_inicial([Locais, Pontos])),
        solve_astar(Sol),
        print_sol(Sol).
       
print_sol([]).        
print_sol([H|T]):-write(H),nl,print_sol(T).