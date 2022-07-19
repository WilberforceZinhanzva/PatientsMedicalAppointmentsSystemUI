#ifndef APPOINTMENTSMODEL_H
#define APPOINTMENTSMODEL_H

#include <QAbstractListModel>


struct Appointment{
    QString id;
    QString appointmentType;
    QString appointmentStatus;
    QString doctor;
    int duration;
    QString date;


};

class AppointmentsModel : public QAbstractListModel
{
    Q_OBJECT

    enum RoleAppointment{
        IdRole = Qt::UserRole + 1, AppointmentTypeRole, AppointmentStatusRole, DoctorRole, DurationRole, DateRole
    };

public:
    explicit AppointmentsModel(QObject *parent = nullptr);
    ~AppointmentsModel();

    Q_INVOKABLE void fetchAppointments(const QString& key, const QString& value);
    Q_INVOKABLE void cancelAppointment(const QString& id);
    void clear();
    void updateAppointmentStatus(const QString& id, const QString& status);

private slots:
    void onAppointmentsFetched();
    void onAppointmentCancelled();

private:
    QVector<Appointment*>m_appointments;

    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;
};

#endif // APPOINTMENTSMODEL_H
