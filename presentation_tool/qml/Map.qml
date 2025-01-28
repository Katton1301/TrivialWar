import QtQuick 2.15
Rectangle {
    id: pointId
    property int teamId: 0
    property int typeId: 0
    property int count: 0
    property bool isHide: false
    property int length: 100
    property bool parity: true

    color: "transparent"

    width: 50
    height: 50
    clip: true

    function setView( _length, _parity )
    {
        length = _length;
        parity = _parity;
        updateView();

    }

    function updateView()
    {
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
            // get context to draw with
            var ctx = getContext("2d")
            var sideLength = width / 2;
            var offset = (1 - (Math.sqrt(3) / 2)) * sideLength;
            // setup the stroke
            ctx.lineWidth = 2
            ctx.strokeStyle = "white"
            // setup the fill
            ctx.fillStyle = "blue"
            // begin a new path to draw
            ctx.beginPath()
            // top-left start point
            ctx.moveTo(sideLength / 2, offset)
            // upper line
            ctx.lineTo(3 * sideLength / 2, offset)
            // upper right line
            ctx.lineTo(sideLength * 2, sideLength)
            // bottom right line
            ctx.lineTo(3 * sideLength / 2, 2 * sideLength - offset)
            // bottom line
            ctx.lineTo(sideLength / 2, 2 * sideLength - offset)
            // bottom left line
            ctx.lineTo(0, sideLength)
            // top left line
            ctx.lineTo(sideLength / 2, offset)
            // left line through path closing
            ctx.closePath()
            // fill using fill style
            ctx.fill()
            // stroke using line width and stroke style
            ctx.stroke()
        }
    }
}
