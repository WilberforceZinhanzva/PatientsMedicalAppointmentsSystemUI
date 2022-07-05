#include "networkmanager.h"
#include <QJsonDocument>
#include <QJsonObject>


NetworkManager &NetworkManager::instance()
{
    static NetworkManager networkManager;
    return networkManager;
}



NetworkManager::NetworkManager()
{

}

NetworkManager::NetworkManager(const NetworkManager &)
{

}

NetworkManager::~NetworkManager()
{

}

const QString &NetworkManager::pureBaseurl() const
{
    return m_pureBaseurl;
}

void NetworkManager::setPureBaseurl(const QString &newPureBaseurl)
{
    if (m_pureBaseurl == newPureBaseurl)
        return;
    m_pureBaseurl = newPureBaseurl;
    emit pureBaseurlChanged();
}

const QString &NetworkManager::baseUrl() const
{
    return m_baseUrl;
}

void NetworkManager::setBaseUrl(const QString &newBaseUrl)
{
    m_baseUrl = newBaseUrl;
}

Exception NetworkManager::fromJson(const QByteArray &jsonResponse)
{
    QJsonObject object = QJsonDocument::fromJson(jsonResponse).object();
    Exception exception;
    exception.message = object.value("message").toString();
    exception.status = object.value("httpStatus").toString();
    exception.timestamp = object.value("timeStamp").toString();
    return exception;
}
