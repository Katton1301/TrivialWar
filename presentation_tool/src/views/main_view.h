#pragma once
#include "../engine/engine_proxy.h"
#include"game_widget_base.hpp"

#include <iostream>
#include <QtWidgets/QWidget>
class TGameWidget : public TGameWidgetBase
{
    Q_OBJECT
public:
    TGameWidget();
    ~TGameWidget() = default;
};

