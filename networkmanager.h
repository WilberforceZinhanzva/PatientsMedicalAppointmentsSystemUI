#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QNetworkAccessManager>

struct Exception{
    QString message;
    QString status;
    QString timestamp;
};

class NetworkManager : public QNetworkAccessManager
{
    Q_OBJECT

public:
    static NetworkManager& instance();

    const QString &baseUrl() const;
    void setBaseUrl(const QString &newBaseUrl);

    Exception fromJson(const QByteArray& jsonResponse);

    const QString &pureBaseurl() const;
    void setPureBaseurl(const QString &newPureBaseurl);

signals:
    void pureBaseurlChanged();

private:
    NetworkManager();
    NetworkManager(const NetworkManager&);
    ~NetworkManager();
    NetworkManager& operator=(const NetworkManager&);

    QString m_baseUrl = "http://localhost:8080/api/v1";
    QString m_pureBaseurl = "http://localhost:8080";
    Q_PROPERTY(QString pureBaseurl READ pureBaseurl WRITE setPureBaseurl NOTIFY pureBaseurlChanged)
};

#endif // NETWORKMANAGER_H
