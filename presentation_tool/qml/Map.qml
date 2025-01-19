import QtQuick 2.15
Rectangle {
    id: pointId
    property int teamId: 0
    property int typeId: 0
    property int count: 0
    property bool isHide: false
    width: 30
    height: 30
    clip: true

    function setSize( width, height )
    {
        pointId.width = width
        pointId.height = height
    }
}
