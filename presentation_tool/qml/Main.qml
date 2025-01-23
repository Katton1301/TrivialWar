import QtQuick 2.15
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id: mainApp
    width: 1280
    height: 800

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
        mainController.initView(mapRectangle.width, mapRectangle.height);
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
        Rectangle {
            id: mainRectangle
            width: parent.width
            height: parent.height
            color: "gray"
            anchors.top: parent.top
            anchors.verticalCenter: parent.verticalCenter
            Rectangle {
                id: mapRectangle
                width: parent.width
                height: parent.height
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    
    //end Main Visual Object
}
