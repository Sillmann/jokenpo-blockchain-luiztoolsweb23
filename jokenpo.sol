/**
 *Submitted for verification at Etherscan.io on 2024-03-09
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract JoKenPo {

    // declaração de enumerador, para disponibilizar as opções possiveis do jogo
    enum Options { NONE, ROCK, PAPER, SCISSORS }

    // declaração do estado que utiliza o enumerador
    // private é utilizado para o jogador 2, não ver a opção do jogador 1
    // como padrao, é inicilializado com NOME ( jogador 1 ainda não jogou )
    Options private choice1 = Options.NONE;
    
    // guardar o endereço do jogador 1
    address private player1;

    // mensagens do jogo ( conseguir ver a situação do andamento do jogo )
    string public result = "";

    function update(string memory newResult) private {
      result = newResult;

      // limpar os estados
      player1 = address(0);
      choice1 = Options.NONE;        
    }

    function play(Options newChoice) public {
       // a jogada não pode ser NONE ( tem que ser uma opcao )
       require(newChoice != Options.NONE, "Invalid choice") ;

       // verificar se o player1 insistir em jogar novamente
       require(player1 != msg.sender, "Wait the another player.");

       // primeira jogada do player1
       if (choice1 == Options.NONE) {
         // guardar o endereço do player1
         player1 = msg.sender;
         // guarda a opção enviada pelo player1
         choice1 = newChoice;
         // atualizar andamento do jogo
         result = "Player 1 choose his/her option. Waiting player 2";
       }


       // verificar se player 1 vence
       else if (choice1 == Options.ROCK && newChoice == Options.SCISSORS) 
         update("Rock breaks scissors. Player 1 won.");
       else if (choice1 == Options.PAPER && newChoice == Options.ROCK) 
         update("Paper wraps rock. Player 1 won.");
       else if (choice1 == Options.SCISSORS && newChoice == Options.PAPER) 
         update("Scissors cuts paper. Player 1 won.");
       


       // verificar se player 2 vence
       else if (choice1 == Options.SCISSORS && newChoice == Options.ROCK) 
         update( "Rock breaks scissors. Player 2 won.");
      else if (choice1 == Options.ROCK && newChoice == Options.PAPER) 
         update("Paper wraps rock. Player 2 won.");
       else if (choice1 == Options.PAPER && newChoice == Options.SCISSORS) 
         update("Scissors cuts paper. Player 2 won.");



       // Para empate
       else 
         update("Draw game.");

    }
}
