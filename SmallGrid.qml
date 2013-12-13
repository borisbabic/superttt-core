import QtQuick 2.0
//small game grid - each 3x3
Grid{
    id:smallGrid

    property int owner: 0                   //0 - nobody, 1 - playerone, 2- playertwo, 3 - draw
    property int playability: 0             //basically number of moves made. too lazy to give it a better name

    function check (){                      //checks if bigGrid is finished / if the game is over
        if ((bigRepeater.itemAt((index-index%3)).owner==bigRepeater.itemAt((index-index%3)+1).owner && bigRepeater.itemAt((index-index%3)+1).owner==bigRepeater.itemAt((index-index%3)+2).owner)||(bigRepeater.itemAt((index+3)%9).owner==game.player && bigRepeater.itemAt((index+6)%9).owner==bigRepeater.itemAt(index).owner)||(bigRepeater.itemAt(0).owner==game.player && bigRepeater.itemAt(4).owner==bigRepeater.itemAt(8).owner&& bigRepeater.itemAt(4).owner==game.player)||(bigRepeater.itemAt(2).owner==game.player && bigRepeater.itemAt(4).owner==bigRepeater.itemAt(6).owner && bigRepeater.itemAt(4).owner==game.player))
        {                                   //long condition is ugly but who cares
            bigGrid.owner=game.player
            bigGrid.playability=9
        }
        else if (bigGrid.playability==9) bigGrid.owner=3; //for draws
    }
    function nonClickable(){                //makes all the cells in it nonClickable/non playable
        for (var i=0; i < 9; i++ ){
            if(smallRepeater.itemAt(i).state==""){
                smallRepeater.itemAt(i).state="NEUTRAL"
            }
        }
    }
    function clickable(){                   //makes all the cells in it clickable/playable
        for (var j=0; j < 9; j++ ){
            if(smallRepeater.itemAt(j).state=="NEUTRAL"){
                smallRepeater.itemAt(j).state=""
            }
        }
    }
    function reset(){                       //guess what this does
        smallGrid.playability=0
        smallGrid.owner=0
        for (var j=0; j < 9; j++ ){
            smallRepeater.itemAt(j).reset() //resets the individual cells
        }
    }

    height: parent.width/3
    width: parent.height/3
    columns: 3

    Repeater{           //Make the cells
        id: smallRepeater
        model: 9        //Hoping TicTacToe has nine cells
        Cell{id: cell}  //Here be cells
    }



}
