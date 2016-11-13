# ULA_VHDL
======================
THIS README IS NOT FINISHED
======================

Digital Systems assignment.

Desgin and implementation of a test module and a ULA on VHDL. The project was implemented on a FPGA Spartan-3 XC3S700A-FG484 chip.
The  report of the project is currently avaliable in brazilian portuguese only..

  This project contains the source code for a devide that implements a Arithmetic Logi Unit and a interface for testing its funcitonality.
  The device is capable of processing two 4-bit inputs with one of 4 logic operations(AND,OR,XOR,NOT) and 4 arithmetic operations(Increment, sum, subtraction, sum with carry). It has one output for returning the  result of the operation. The input values are generated dynamically by a  input generation module. The device operates with a 6 second cicle: 2 seconds for presenting each input vector and 2 secons for presenting the result.
    The project was implemented on a Xilinx development board, with a FPGA Spartan-3 XC3S700A-FG484  chip. For this test,  LEDs  were configured to return the system inputs and outputs. Switch buttons controled the ALU operations and pushbuttons  controled  the inputs.


    Esse projeto contém o código fonte para um dispositivo que implementa uma Unidade-Lógico-Aritmética e um sistema de interface para testes.
O dispositivo descrito neste documento é capaz de receber dois vetores de 4 bits e processá-los com 4 operações lógicas (AND, OR, XOR, NOT) e 4 operações aritméticas (incremento,  soma, subtração, soma com carry). O resultado é apresentado através de um vetor de saída de 4 bits. Os valores de entrada são gerados de forma dinâmica através de um módulo gerador de entradas. O dispositivo segue um ciclo de 6 segundos: 2 segundos de apresentação do primeiro vetor de entrada; 2 segundos para apresentação do segundo vetor de entrada; 2 segundos para apresentação do resultado calculado pela ULA, correspondente à operação selecionada.
O projeto foi desenvolvido sintetizado e implementado através da interface ISE da empresa Xilinx; simulado no simulador ISim, integrado com a ISE; e testado em hardware através de uma placa de desenvolvimento da Xilinx  com um chip FPGA Spartan-3 XC3S700A-FG484. 
Para o teste  em hardware, os LEDs da placa de desenvolvimento foram configurados para apresentar os resultados do sistema, enquanto as chaves da placa (switches) controlavam a operação realizada pela ULA e os botões de pressão (pushbuttons), em conjunto com uma chave de placa, controlavam as entradas.
O desenvolvimento dos módulos que compõem o dispositivo são detalhadamente apresentados na seção 2 e os resultados das simulações estão descritos na seção 3. O projeto foi desenvolvido em VHDL. Todos arquivos que implementam os módulos descritos estão referenciados no texto e disponíveis no apêndice deste documento. Os nomes utilizados no código fonte para a implementação de cada parte do módulo serão apresentados na descrição de cada módulo em parênteses, diretamente após o seu significado ( i.e. [...] a saída do módulo é composta pelo resultado da operação (sinal_resultado) e também[...] ) ou diretamente no texto.
