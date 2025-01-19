#include <windows.h>
#include <QtGui>
#include <QSurfaceFormat>
#include "qml_window_controller.hpp"
#include <QMessageBox>
#include <iostream>
#include <string>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    TQML_WindowController window;
    int err = window.initWindow("TrivialWar");
    if(err < 0)
    {
        return err;
    }
    window.showWindow();
    int rc = a.exec();
    return rc;

}
