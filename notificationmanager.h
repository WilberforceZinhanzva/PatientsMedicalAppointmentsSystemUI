#ifndef NOTIFICATIONMANAGER_H
#define NOTIFICATIONMANAGER_H

#include <QObject>

class NotificationManager : public QObject
{
    Q_OBJECT


public:
    enum NotificationType{
        SUCCESS,INFORMATION,WARNING,ERROR
    };

    static NotificationManager& instance();

signals:
    void showNotification(const NotificationType& type, const QString& message);

private:
    NotificationManager();
    NotificationManager(const NotificationManager&);
    NotificationManager& operator=(const NotificationManager&);
    ~NotificationManager();

};

#endif // NOTIFICATIONMANAGER_H
