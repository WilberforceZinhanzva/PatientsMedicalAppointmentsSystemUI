#include "notificationmanager.h"


NotificationManager &NotificationManager::instance()
{
    static NotificationManager notificationManager;
    return notificationManager;
}



NotificationManager::NotificationManager()
{

}

NotificationManager::NotificationManager(const NotificationManager &)
{

}

NotificationManager::~NotificationManager()
{

}
