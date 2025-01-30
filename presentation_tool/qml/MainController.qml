import QtQuick 2.15
import QtQuick.Controls 2.2
import com.ics.demo 1.0

Item {
    id: mainController
    //Controller properties
    property int columnsNumber: 3
    property int rowsNumber: 3
    property int mapSize: 500
    property double scaleRate: 1.0

    property var mapView;
    property var parentFlickable;


    function connectComponents( _mapView, _parentFlickable )
    {
        mapView = _mapView;
        parentFlickable = _parentFlickable;
    }    
    
    function initEngine()
    {
        gameWidget.gameDataRequest();
    }

    function initView(sizeLength)
    {
        mapSize = sizeLength;
        Qt.createQmlObject("
                import QtQuick 2.15
                GridView {
                    id: mapGrid
                    interactive: false
                    width: parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    boundsMovement: Flickable.StopAtBounds
                    boundsBehavior: Flickable.StopAtBounds
                    function getItemAt(index)
                    {
                        return itemAtIndex(index);
                    }
                    anchors.fill: parent
                    model: gameWidget.Map
                    delegate: Map { }
                }",
                mapView
            );
        updateView( );
    }

    function mapGrid()
    {
        return mapView.children[0];
    }

    function scale(rate)
    {
        var newScale = scaleRate * ( rate * 0.02 + 1);
        if(checkToChangeSize(newScale))
        {
            scaleRate = newScale;
            updateView();
        }
    }

    function checkToChangeSize(newScale)
    {
        var scaledMapSize = mapSize * newScale;
        if(scaledMapSize > parentFlickable.contentWidth || scaledMapSize > parentFlickable.contentHeight ) //check on large
        {
            return false;
        }
        if((scaledMapSize / columnsNumber + scaledMapSize / rowsNumber) < 50) //check on small
        {
            return false;
        }
        return true;
    }

    function updateView( )
    {
        var scaledMapSize = mapSize * scaleRate
        var cellLength = (scaledMapSize / columnsNumber + scaledMapSize / rowsNumber) / 2;
        mapGrid().contentWidth = mapSize;
        mapView.width = scaledMapSize;
        mapGrid().contentHeight = mapSize;
        mapView.height = scaledMapSize;
        mapGrid().cellWidth =  cellLength;
        mapGrid().cellHeight =  cellLength;
        for(var i = 0; i < columnsNumber; i++)
        {
            for(var j = 0; j < rowsNumber; j++)
            {
                mapGrid().getItemAt(i * rowsNumber +j).setView(cellLength, i % 2 == 0);
            }
        }
    }
    //End Controller methods

    //Main Model Class connected with c++
    GameWidget {
        id: gameWidget
    }
    //GameWidget slots
    Connections {
        target: gameWidget

        function onSendMatrixSize( _columnsNumber, _rowsNumber )
        {
            columnsNumber = _columnsNumber;
            rowsNumber = _rowsNumber;
        }
    }
}
