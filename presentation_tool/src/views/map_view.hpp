#pragma once

#include <QString>
#include <QColor>
#include <QDebug>
#include <QAbstractListModel>
#include <vector>

// Create an Item so we have something to put in the model:
struct Item {
    int teamId;
    int type;
    int count;
    bool hide;
};

class MapView : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MapView(QObject *parent = nullptr) : QAbstractListModel(parent)
    {
    }

    // enum DataRoles for QAbstractListModel:
    enum DataRoles {
        TeemIdRole = Qt::UserRole + 1,
        TypeRole,
        CountRole,
        HideRole,
    };

    // PushBackRow() method for QAbstractListModel:
    void addData(Item const & row) {
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_mapList.push_back(row);
        endInsertRows();
    }

    // PushBackRow() method for QAbstractListModel:
    void changeItem(uint32_t i, Item const & item)
    {
        m_mapList.at(i) = item;
    }

    int rowCount([[maybe_unused]]const QModelIndex &parent = QModelIndex()) const override
    {
        return m_mapList.size();
    }

    // data() required for QAbstractListModel:
    QVariant data(const QModelIndex & index, int role) const override
    {
        if (
            !index.isValid() ||
            index.row() < 0 || static_cast<uint32_t>(index.row()) >= m_mapList.size()
        )
        {
            return QVariant();
        }

        Item modelEntry = m_mapList[index.row()];
        if (role == TeemIdRole) {return modelEntry.teamId;}
        if (role == TypeRole) {return modelEntry.type;}
        if (role == CountRole) {return modelEntry.count;}
        if (role == HideRole) {return modelEntry.hide;}
        return QVariant();
    }

    // roleNames() method for QAbstractListModel:
    QHash<int,QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[TeemIdRole] = "Id";
        roles[TypeRole] = "Type";
        roles[CountRole] = "Count";
        roles[HideRole] = "IsHide";
        return roles;
    }

private:
    // Below are the model items:
    std::vector< Item >  m_mapList;
};

