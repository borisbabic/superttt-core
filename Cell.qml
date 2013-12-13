import QtQuick 2.0
//individual cell
Rectangle{
    id:cell

    property int owner: 0                   //0 - nobody, 1 - playerone, 2- playertwo, 3 - the elusive Mr. Draw
    property string gradcolor: "white"      //color for playable cells
    property string gradstop: "white"       //color for playable cells

    function check (){                      // checks if small grid is done
        if ((smallRepeater.itemAt((index-index%3)).owner==smallRepeater.itemAt((index-index%3)+1).owner && smallRepeater.itemAt((index-index%3)+1).owner==smallRepeater.itemAt((index-index%3)+2).owner)||(smallRepeater.itemAt((index+3)%9).owner==game.player && smallRepeater.itemAt((index+6)%9).owner==smallRepeater.itemAt(index).owner)||((smallRepeater.itemAt(0).owner==game.player && smallRepeater.itemAt(4).owner==smallRepeater.itemAt(8).owner&& smallRepeater.itemAt(4).owner==game.player))||(smallRepeater.itemAt(2).owner==game.player && smallRepeater.itemAt(4).owner==smallRepeater.itemAt(6).owner && smallRepeater.itemAt(4).owner==game.player)){ // my frankenstein
                                            //it's alive
            smallGrid.owner=game.player     //if it's alive it means somebody won
            smallGrid.playability=9         //making the grid unplayable --- can't remember if necessary, probably is

            bigGrid.playability+=1          //filling up the big grid
            smallGrid.check()               //check if the big grid is finished
            for (var i=0;i<9;i++){          //changing all the items in the small grid to won
                smallRepeater.itemAt(i).state=(game.player==1 ? "WINNERONE":"WINNERTWO")
            }
        }

        else if (smallGrid.playability>8){  //this means it is a draw
            for (var i=0;i<9;i++){
                smallRepeater.itemAt(i).state="DRAW"
            }
            smallGrid.owner=3               //draw owner
            bigGrid.playability+=1
        }
    }
    function reset()                        //guess what this does
    {
        cell.state=""
        cell.owner=0
    }
    function makeMove(){
        cell.owner=game.player
        cell.state=(game.player==1 ? "PLAYERONE": "PLAYERTWO")
        smallGrid.playability+=1    //noting

        cell.check()                //checking if the small grid is over

        game.player=3-game.player
        status.state=(game.player==1 ? "PLAYERONE": "PLAYERTWO")

    }
    function nextMove(){            //regulates what cells can be clicked => where the next player can move
        bigGrid.nonClickable()      //first making everything nonClickable
        if(bigGrid.playability>8){  //checks if the game is over, don't need to make anything clickable if it is
            game.gameEnd()          //does stuff for game over: status change / score keeping / firstmove next game
        }

        else if (bigRepeater.itemAt(index).playability<9){
            bigRepeater.itemAt(index).clickable()
        }
        else {
            bigGrid.clickable()
        }
    }

    height: parent.width/3-3                //get a third of the space and leave a bit --- need to fix the issue this causes
    width: parent.height/3-3                //get a third of the space and leave a bit --- need to fix the issue this causes
    radius: 10                              //rounding a bit
    border.color: "black"                   //border makes it pop
    border.width: 1
    gradient: Gradient {                    //gradients, because why not
        GradientStop {
            position: 0.00;
            color: gradcolor;
        }
        GradientStop {
            position: 1.00;
            color: gradstop;
        }
    }


    MouseArea{                              //makes each cell clickable
        anchors.fill: parent
        onClicked: {
            if (cell.state==""){            // only if it's free
                cell.makeMove()             // can't really play if moves aren't made
                cell.nextMove()             // can't really play with no rules/one move
            }
        }
    }

    states: [
        State {
            name: "NEUTRAL"
            PropertyChanges {
                target: cell
                gradcolor:"grey"
                gradstop: "#ffffff"
                //border.color: "black"
            }
        },
        State{
            name:"PLAYERONE"
            PropertyChanges{
                target: cell
                gradcolor: game.playerOneColor
                gradstop: "#ffffff"
            }
        },
        State{
            name:"PLAYERTWO"
            PropertyChanges{
                target: cell
                gradcolor:game.playerTwoColor
                gradstop: "#ffffff"

            }
        },
        State{
            name:"WINNERONE"
            PropertyChanges {
                target: cell
                gradcolor: game.playerOneColor
                gradstop: game.playerOneColor
                radius: 0
                border.width:0
                //border.color: game.playerOneColor

            }
        },
        State{
            name:"WINNERTWO"
            PropertyChanges {
                target: cell
                gradstop: game.playerTwoColor
                gradcolor:game.playerTwoColor
                radius: 0
                border.width: 0
                //border.color:game.playerTwoColor
            }
        },
        State{
            name:"DRAW"
            PropertyChanges {
                target: cell
                gradstop: game.drawColor
                gradcolor: game.drawColor
                radius: 0
                //border.color: game.drawColor

            }
        }
    ]

    transitions:
        Transition {
            id: winnerTransition

            from: "*"
            to: "WINNERTWO,WINNERONE"

            ParallelAnimation {
                    id: winnerAnimation

                    ColorAnimation {target: cell; duration: 200}
                    NumberAnimation {properties: "border.width,radius"; duration: 500}
                }
        }
}
