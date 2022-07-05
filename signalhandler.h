#ifndef SIGNALHANDLER_H
#define SIGNALHANDLER_H

#include <QObject>

class SignalHandler : public QObject
{
    Q_OBJECT

public:
    static SignalHandler& instance();

    Q_INVOKABLE void selectAppointmentType(const QString& appointmentType);
    Q_INVOKABLE void beginClearDateSelection();

signals:
    void appointmentTypeSelected(const QString& appointmentType);
    void clearDateSelection();

private slots:
    void onAppointmentTypeSelected(const QString& appintmentType);
private:
    SignalHandler();
    SignalHandler(const SignalHandler&);
    SignalHandler& operator=(const SignalHandler&);
    ~SignalHandler();
};

#endif // SIGNALHANDLER_H
