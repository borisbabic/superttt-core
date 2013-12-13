import QtQuick 2.0
//contain game/match wide variables and functions/methods
Item{
    id: game

    property string playerOneColor: "blue"      //Currently unchangable in app
    property string playerTwoColor: "red"       //Currently unchangable in app
    property string drawColor: "grey"           //Currently unchangable in app
    property string playerOne: "Player 1"       //Currently unchangable in app
    property string playerTwo: "Player 2"       //Currently unchangable in app
    property int firstMove: 1                   //player with the first move (in the next game) - changes after completed game
    property variant score: [0,0,0]             //Total score [P1,P2,draw] --- Currently unused, only calculated, future prep
    property int player: 1                      //current player to move

    function reset()                            //resets the match (not the game) --- Currently unused, future prep
    {
        game.score=[0,0,0]
        game.firstMove=1
        bigGrid.reset()                         //reset the game
    }
    function gameEnd(){                         //does stuff when the game is over
        game.firstMove=3-game.firstMove         //first move next game
        game.score[bigGrid.owner-1]+=1
        switch (bigGrid.owner){                  //appropriate status
        case 1: status.state="WINNERONE"
            break
        case 2: status.state="WINNERTWO"
            break
        case 3: status.state="DRAW"
        }
    }
}
