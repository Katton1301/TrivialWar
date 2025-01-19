#include "game_widget_base.hpp"


TGameWidgetBase::TGameWidgetBase()
{
    //create();
}

TGameWidgetBase::~TGameWidgetBase()
{

}

MapView* TGameWidgetBase::Map()
{
    return m_map;
}

void TGameWidgetBase::create()
{
}

void TGameWidgetBase::Init()
{
    m_map = new MapView();
}
