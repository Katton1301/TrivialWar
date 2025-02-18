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
    Init();
}

void TGameWidgetBase::Init()
{
    m_map = new MapView();
    for(uint32_t i = 0; i < 9; ++i)
    {
        Item item;
        item.id = i;
        item.count = i;
        item.teamId = i;
        item.type = 0;

        m_map->addData(item);
    }
}

void TGameWidgetBase::gameDataRequest( )
{
    emit sendMatrixSize( 3, 3 );
}


void TGameWidgetBase::cellClicked( int _cellId )
{
    std::cout << _cellId << std::endl;
}
