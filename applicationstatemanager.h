#ifndef APPLICATIONSTATEMANAGER_H
#define APPLICATIONSTATEMANAGER_H

#include <QObject>

class ApplicationStateManager : public QObject
{
    Q_OBJECT

public:
    static ApplicationStateManager& instance();
    const QString &selectedAppointmentType() const;
    void setSelectedAppointmentType(const QString &newSelectedAppointmentType);

    const QString &selectedDoctor() const;
    void setSelectedDoctor(const QString &newSelectedDoctor);
    const QString &selectedDate() const;
    void setSelectedDate(const QString &newSelectedDate);
    const QString &selectedTime() const;
    void setSelectedTime(const QString &newSelectedTime);

signals:
    void selectedAppointmentTypeChanged();

    void selectedDoctorChanged();
    void selectedDateChanged();
    void selectedTimeChanged();

private:
    ApplicationStateManager();
    ApplicationStateManager(const ApplicationStateManager&);
    ApplicationStateManager& operator=(const ApplicationStateManager&);
    ~ApplicationStateManager();

    QString m_selectedAppointmentType;
    QString m_selectedDoctor;
    QString m_selectedDate;
    QString m_selectedTime;
    Q_PROPERTY(QString selectedAppointmentType READ selectedAppointmentType WRITE setSelectedAppointmentType NOTIFY selectedAppointmentTypeChanged)
    Q_PROPERTY(QString selectedDoctor READ selectedDoctor WRITE setSelectedDoctor NOTIFY selectedDoctorChanged)
    Q_PROPERTY(QString selectedDate READ selectedDate WRITE setSelectedDate NOTIFY selectedDateChanged)
    Q_PROPERTY(QString selectedTime READ selectedTime WRITE setSelectedTime NOTIFY selectedTimeChanged)
};

#endif // APPLICATIONSTATEMANAGER_H
