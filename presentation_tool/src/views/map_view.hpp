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

class MapView : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit MapView(QObject *parent = nullptr) : QAbstractTableModel(parent)
    {
    }

    // enum DataRoles for QAbstractTableModel:
    enum DataRoles {
        TeemIdRole = Qt::UserRole + 1,
        TypeRole,
        CountRole,
        HideRole,
    };

    // PushBackRow() method for QAbstractTableModel:
    void PushBackRow(std::vector<Item> const & row) {
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_mapMatrix.push_back(row);
        endInsertRows();
    }

    void PushBackColumn(std::vector<Item> const & column) {
        beginInsertColumns(QModelIndex(), columnCount(), columnCount());
        for(uint32_t noCol = 0; noCol < static_cast<uint32_t>(columnCount()); ++noCol)
        {
            m_mapMatrix.at(noCol).push_back(column.at(noCol));
        }
        endInsertColumns();
    }

    // PushBackRow() method for QAbstractTableModel:
    void changeItem(uint32_t row, uint32_t column, Item const & item)
    {
        m_mapMatrix.at(row).at(column) = item;
    }

    int rowCount([[maybe_unused]]const QModelIndex &parent = QModelIndex()) const override
    {
        return m_mapMatrix.size();
    }

    int columnCount([[maybe_unused]]const QModelIndex &parent = QModelIndex()) const override
    {
        return m_mapMatrix.at(0).size();
    }

    // data() required for QAbstractListModel:
    QVariant data(const QModelIndex & index, int role) const override
    {
        if (
            !index.isValid() ||
            index.row() < 0 || static_cast<uint32_t>(index.row()) >= m_mapMatrix.size() ||
            index.column() < 0 || static_cast<uint32_t>(index.column()) >= m_mapMatrix.at(0).size()
        )
        {
            return QVariant();
        }

        Item modelEntry = m_mapMatrix[index.row()][index.column()];
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
    std::vector< std::vector< Item > >  m_mapMatrix;
};

