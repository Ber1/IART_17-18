/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
:- reconsult(algorithms).
:- reconsult(problem2).

:- dynamic estado_inicial/1.

/* Call this to solve the problem in question*/
solve_problem:-
        retractall(estado_inicial(_)),
        findall(LocalX,local_inicial(LocalX),Locais),
        findall(PontoX,ponto_estrategico(PontoX),Pontos),
        assert(estado_inicial([Locais, Pontos])),
        solve_astar(Sol),
        print_sol(Sol).

/* prints the solution to the problem in terminal*/       
print_sol([]).        
print_sol([H|T]):-write(H),nl,print_sol(T).

/* Call this to solve the problem in question and check it's runtime
* X -> Runtime
*/
runtime(X):-
  solve_problem,      
  statistics(runtime,A),
  X= 'Runtime':A.