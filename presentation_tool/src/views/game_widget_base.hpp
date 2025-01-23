#pragma once

#include <iostream>
#include <vector>
#include <sstream>
#include <fstream>
#include <algorithm>
#include <ctime>

#include <QtWidgets/QWidget>
#include <QtCore/QString>

#include "./map_view.hpp"

class TGameWidgetBase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(MapView* Map READ Map NOTIFY MapChanged)

public:
    TGameWidgetBase();
    ~TGameWidgetBase();
    MapView* Map();


signals:
    void MapChanged();

    void sendMatrixSize( int columnsNumber, int rowsNumber );

public slots:

    void gameDataRequest( );

protected:
    void create();

    virtual void Init();
protected:
    MapView* m_map{};

};

