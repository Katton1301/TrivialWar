import QtQuick 2.15
Rectangle {
    id: pointId
    //c++ types
    //Id - uniq cell id
    //TeemId - team id, define color end game logic
    //Type - cell type, which form
    //Count - cell value
    //IsHide - cell is invisible or not;

    property int length: 100
    property bool parity: true
    property string colorStr: "blue"
    property var mainController;
    property int borderWidth: 2


    color: "transparent"

    width: 50
    height: 50
    clip: true

    function init( _mainController )
    {
        mainController = _mainController;
        updateColor();
    }

    function updateColor()
    {
        if(TeemId === 0)
        {
            colorStr = "gray";
        }
        if(TeemId === 1)
        {
            colorStr = "blue";
        }
    }

    function setView( _length, _parity )
    {
        length = _length;
        parity = _parity;
        updateView();
    }

    function updateView()
    {
        updateColor();
        pointId.implicitWidth = length;
        pointId.implicitHeight = length;
        pointId.width = length;
        pointId.height = length;
        hexagonId.width = pointId.width / 2;
        hexagonId.height = pointId.height / 2;
        if(parity)
        {
            hexagonId.anchors.left = pointId.left;
        }
        else
        {
            hexagonId.anchors.right = pointId.right;
        }
    }

    Canvas {
        id: hexagonId
        anchors.verticalCenter: parent.verticalCenter
        // canvas size
        width: 50; height: 50
        // handler to override for drawing
        onPaint: {
            var ctx = getContext("2d")
            if(Type === 0) //draw hexagon
            {
                // get context to draw with
                var sideLength = width / 2;
                var offsetY = (1 - (Math.sqrt(3) / 2)) * sideLength + borderWidth;
                var offsetX = borderWidth;
                // setup the stroke
                ctx.lineWidth = borderWidth
                ctx.strokeStyle = "white"
                // setup the fill
                ctx.fillStyle = colorStr
                // begin a new path to draw
                ctx.beginPath()
                // top-left start point
                ctx.moveTo(sideLength / 2, offsetY)
                // upper line
                ctx.lineTo(3 * sideLength / 2,  offsetY)
                // upper right line
                ctx.lineTo(sideLength * 2 - offsetX, sideLength)
                // bottom right line
                ctx.lineTo(3 * sideLength / 2, 2 * sideLength - offsetY)
                // bottom line
                ctx.lineTo(sideLength / 2, 2 * sideLength - offsetY)
                // bottom left line
                ctx.lineTo(offsetX, sideLength)
                // top left line
                ctx.lineTo(sideLength / 2, offsetY)
                // left line through path closing
                ctx.closePath()
                // fill using fill style
                ctx.fill()
                // stroke using line width and stroke style
                ctx.stroke()
            }


        }
    }

    MouseArea {
        anchors.fill: hexagonId
        hoverEnabled: true
        onClicked:
        {
            mainController.cellClicked(Id);
        }
        onEntered:
        {
            borderWidth = 4;
            hexagonId.requestPaint()
        }
        onExited:
        {
            borderWidth = 2;
            hexagonId.requestPaint()
        }
    }
}
