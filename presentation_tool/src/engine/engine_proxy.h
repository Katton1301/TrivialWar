#pragma once

#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <cstdlib>

#include <QtCore/QObject>
#include <QtCore/QString>

#include <game_controller.hpp>

#include <string>

class TEngineProxy : public QObject
{
    Q_OBJECT

    public : //methods
        //! constructor
        TEngineProxy( );

        //! destructor
        virtual ~TEngineProxy( );

    protected : //attributes

    std::shared_ptr< TGameController > m_gameController = nullptr;
};

