#ifndef TIMESLOTMODEL_H
#define TIMESLOTMODEL_H

#include <QAbstractListModel>
#include <QVector>


struct TimeSlot{
    QString startTime;
    QString endTime;
    bool taken;

};

class TimeSlotModel : public QAbstractListModel
{
    Q_OBJECT

    enum TimeSlotRole{
        StartTimeRole = Qt::UserRole,EndTimeRole,TakenRole
    };

public:
    explicit TimeSlotModel(QObject *parent = nullptr);
    ~TimeSlotModel();

    void clear();
    Q_INVOKABLE void fetchTimeSlots(const QString& appointmentType, const QString& doctor, const QString& date);

    int size() const;
    void setSize(int newSize);

signals:
    void sizeChanged();

private slots:
    void onTimeSlotsFetched();

private:
    QVector<TimeSlot*> m_timeSlots;
    int m_size = 0;
    Q_PROPERTY(int size READ size WRITE setSize NOTIFY sizeChanged)

    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;
};

#endif // TIMESLOTMODEL_H
