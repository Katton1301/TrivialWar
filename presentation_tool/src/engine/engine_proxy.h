#pragma once

#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <cstdlib>

#include <QtCore/QObject>
#include <QtCore/QString>

#include <string>

class TEngineProxy :    public QObject
{
    Q_OBJECT

    public : //methods
        //! constructor
        TEngineProxy( );

        //! destructor
        virtual ~TEngineProxy( );

    protected : //attributes
};

