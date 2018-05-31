# IART_17-18

## Objectivo
Determinar um plano de evacuação de um conjunto de turistas retidos numa montanha.

## Descrição
Pretende-se evacuar turistas que ficaram retidos numa montanha. 
Estão disponíveis veículos de transporte localizados em n pontos/locais estratégicos. 
É também conhecido o local do abrigo para onde devem ser evacuados os turistas. 
Os veículos possuem capacidade limitada e só existe um veículo em cada um dos n pontos estratégicos considerados.
O programa deve determinar o percurso ótimo para evacuar todos os turistas no menor tempo. 
O veículo de transporte pode não possuir capacidade suficiente para transportar todos os turistas que se encontram num determinado local, 
pelo que deve: o mesmo veículo efetuar mais que uma viagem; ou usar um segundo veículo.

## Como correr
Para correr o programa basta compilar o ficheiro solver.pl com o compilador sicstus, após isto basta chamar o predicado solve_problem.. 
Caso queiramos testar o tempo necessário ao cpu para resolver o problema em questão chamamos o predicado runtime(X). em que X é o tempo de execução em milisegundos.
Para resolver outros problemas em ficheiros com nome diferente ao “problem.pl” basta alterar o “:- reconsult(problem).” para “:- reconsult(nome do ficheiro).”.
