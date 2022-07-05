#include "authentication.h"
#include "networkmanager.h"
#include <QHttpPart>
#include <QHttpMultiPart>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>

Authentication &Authentication::instance()
{
    static Authentication authentication;
    return authentication;
}

void Authentication::login(const QString &username, const QString &password)
{

   QJsonObject object;
   object.insert("username",QJsonValue(username));
   object.insert("password",QJsonValue(password));

   QJsonDocument document(object);

    QString url = QString("%1/login").arg(NetworkManager::instance().pureBaseurl());
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    QNetworkReply *reply = NetworkManager::instance().post(request,document.toJson());


    connect(reply, &QNetworkReply::finished, this, &Authentication::onLogin);

}

Authentication::Authentication()
{

}

Authentication::Authentication(const Authentication &)
{

}

Authentication::~Authentication()
{

}

const QString &Authentication::token() const
{
    return m_token;
}

void Authentication::setToken(const QString &newToken)
{
    if (m_token == newToken)
        return;
    m_token = newToken;
    emit tokenChanged();
}

const QString &Authentication::userName() const
{
    return m_userName;
}

void Authentication::setUserName(const QString &newUserName)
{
    if (m_userName == newUserName)
        return;
    m_userName = newUserName;
    emit userNameChanged();
}

bool Authentication::authenticated() const
{
    return m_authenticated;
}

void Authentication::setAuthenticated(bool newAuthenticated)
{
    if (m_authenticated == newAuthenticated)
        return;
    m_authenticated = newAuthenticated;
    emit authenticatedChanged();
}

void Authentication::onLogin()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if(!reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute)==200){
        QString token = reply->rawHeader("authorization");
        if(!token.isEmpty()){
            this->setToken(token);
            this->setAuthenticated(true);
        }
    }
    else if(reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute)==403){
        qDebug() << reply->errorString();
    }
    else if(reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute)==401){
        Exception exception = NetworkManager::instance().fromJson(reply->readAll());
        qDebug() << exception.message << "401 Error";
    }
    else{
       qDebug() << reply->errorString();

    }



}
