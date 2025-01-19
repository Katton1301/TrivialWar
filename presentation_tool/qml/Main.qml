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
        updateView();
    }

    function updateView()
    {
    }
    //end Main Visual Object
}
