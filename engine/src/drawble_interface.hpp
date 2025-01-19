#pragma once

struct IDrawable
{
    virtual ~IDrawable() = default;
    virtual bool isVisible() = 0;
};