#pragma once
#include "views/main_view.h"
#include <QQmlComponent>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QApplication>

class TQML_WindowController
{
public:
    TQML_WindowController();
    ~TQML_WindowController() = default;

    int initWindow(std::string const & windowName);
    void showWindow();
private:
    QQmlApplicationEngine m_engine;
    QQmlComponent *m_component = nullptr;
    QQuickWindow * m_window = nullptr;

};
