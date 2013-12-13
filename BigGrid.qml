import QtQuick 2.0
//big game grid (3x3 of 3x3s)
Grid{
    id:bigGrid

    property int playability: 0         //basically number of moves made. too lazy to give it a better name
    property int owner :0               //0 - nobody, 1 - playerone, 2- playertwo, 3 - draw

    function nonClickable(){            //makes everything unclickable/playable
        for (var i=0; i < 9; i++ ){
            bigRepeater.itemAt(i).nonClickable()    //makes each small grid unclickable/unplayable
        }
    }
    function clickable(){               //makes everthing clickable/playable
        for (var j=0; j < 9; j++ ){
            bigRepeater.itemAt(j).clickable()       //makes each small grid clickable/playable
        }
    }
    function reset (){                  //I have no idea what this does
        game.player=game.firstMove
        bigGrid.playability=0
        bigGrid.owner=0
        status.state=(game.player==1 ? "PLAYERONE" : "PLAYERTWO")
        for (var j=0; j < 9; j++ ){
            bigRepeater.itemAt(j).reset()   //resets each small grid
        }
    }

    //making it a square
    height:{return (parent.height<parent.width?parent.height:parent.width) }
    width:{return (parent.height<parent.width?parent.height:parent.width) }
    anchors.centerIn: parent
    columns: 3

    Repeater{
        id:bigRepeater
        model: 9
        SmallGrid{id: smallGrid} //here be small grids
    }
}
