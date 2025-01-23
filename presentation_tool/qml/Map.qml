import QtQuick 2.15
Rectangle {
    id: pointId
    property int teamId: 0
    property int typeId: 0
    property int count: 0
    property bool isHide: false

    width: 50
    height: 50
    color: "blue"
    clip: true

    function setSize( width, height )
    {
        pointId.implicitWidth = width;
        pointId.implicitHeight = height;
        pointId.width = width;
        pointId.height = height;
    }
}
