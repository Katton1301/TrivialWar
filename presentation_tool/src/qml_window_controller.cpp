#include"qml_window_controller.hpp"
#include <QMessageBox>

TQML_WindowController::TQML_WindowController()
{

}

int TQML_WindowController::initWindow(std::string const & windowName)
{
    // Register our component type with QML.
    qRegisterMetaType<MapView*>("MapView*");
    qmlRegisterType<TGameWidget>("com.ics.demo", 1, 0, "GameWidget");

    m_component = new QQmlComponent(&m_engine);


    QObject::connect(&m_engine, SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));
    m_component->loadUrl(QUrl("qml/Main.qml"));

    if (!m_component->isReady() )
    {
        QMessageBox boxWarning;
        std::cout << m_component->errorString().toStdString().c_str() << std::endl;
        boxWarning.setText( m_component->errorString() );
        boxWarning.exec();
        return -1;
    }

    QObject *topLevel = m_component->create();
    m_window = qobject_cast<QQuickWindow *>(topLevel);

    QSurfaceFormat surfaceFormat = m_window->requestedFormat();
    m_window->setFormat(surfaceFormat);

    QMetaObject::invokeMethod(topLevel, "intializeGame", Q_ARG(QVariant, windowName.c_str()));
    return 0;
}

void TQML_WindowController::showWindow()
{
    m_window->show();
}
