import QtQuick 2.15
import QtQuick.Controls 2.2
import com.ics.demo 1.0

Item {
    id: mainController
    //Controller properties
    property int columnsNumber: 3
    property int rowsNumber: 3
    property int cellWidth: 100
    property int cellHeight: 100

    property var mapView;


    function connectComponents( _mapView )
    {
        mapView = _mapView;
    }    
    
    function initEngine()
    {
        gameWidget.gameDataRequest();
    }

    function initView(width, height)
    {
        cellWidth = width / columnsNumber;
        cellHeight = height / rowsNumber;
        Qt.createQmlObject("
                import QtQuick 2.15
                GridView {
                    id: mapGrid
                    width: parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
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
        updateView( width, height );
    }

    function mapGrid()
    {
        return mapView.children[0];
    }

    function updateView( _width, _height )
    {
        mapGrid().width = _width;
        mapGrid().height = _height;
        mapGrid().cellWidth =  cellWidth;
        mapGrid().cellHeight = cellHeight;
        for(var i = 0; i < columnsNumber; i++)
        {
            for(var j = 0; j < rowsNumber; j++)
            {
                mapGrid().getItemAt(i * rowsNumber +j).setSize(cellWidth,cellHeight);
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
