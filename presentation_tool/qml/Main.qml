import QtQuick 2.15
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id: mainApp
    width: 1280
    height: 800
    property int globalWidth: mainApp.width * 2
    property int globalHeight: mainApp.height * 2
    property int mapSize: 100

    //Controller methods
    function intializeGame(name)
    {
        mainApp.title = name;
        mainController.connectComponents( mapRectangle );
        mainController.initEngine();
        updateView();
    }

    function updateView()
    {
        mapSize = Math.min(mainApp.width, mainApp.height);
        mapRectangle.width = mapSize;
        mapRectangle.height = mapSize;
        mainController.initView(mapSize, );
    }

    MainController {
        id:mainController
    }

    //Main Visual Object
    Rectangle {
        id: mainWindow
        width: parent.width
        height: parent.height

        color: "lightgray"
        Flickable {
            id: mainRectangle
            width: parent.width
            height: parent.height
            contentWidth: globalWidth
            contentHeight: globalHeight
            anchors.top: parent.top
            contentX: (contentWidth - width) / 2
            contentY: (contentHeight - height) / 2
            anchors.verticalCenter: parent.verticalCenter;
            boundsMovement: Flickable.StopAtBounds
            boundsBehavior: Flickable.DragOverBounds
            focus: true
            WheelHandler {
                onWheel: (wheel)=> {
                    if (wheel.angleDelta.y !== 0) {
                        mainController.scale(wheel.angleDelta.y / 120);
                    }
                }
            }

            Image {
                id: back
                anchors.fill: parent
                source: "../resources/space.jpg"
                z: -1
            }

            Rectangle {
                id: mapRectangle
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    
    //end Main Visual Object
}
