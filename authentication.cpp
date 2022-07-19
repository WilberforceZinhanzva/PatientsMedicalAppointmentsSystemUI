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

void Authentication::signUp(const QString &fullname, const QString &phone, const QString &email, const QString &address, const QString &username, const QString &password)
{

    emit signUpInProgress();

    QJsonObject object;
    object.insert("fullname",QJsonValue(fullname));
    object.insert("phone",QJsonValue(phone));
    object.insert("email",QJsonValue(email));
    object.insert("address",QJsonValue(address));
    object.insert("username",QJsonValue(username));
    object.insert("password",QJsonValue(password));

    QString url = QString("%1/registration/patients").arg(NetworkManager::instance().baseUrl());
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    QNetworkReply *reply = NetworkManager::instance().post(request,QJsonDocument(object).toJson());
    connect(reply, &QNetworkReply::finished, this, &Authentication::onSignUp);


}



void Authentication::bookAppointment(const QString &appointmentType, const QString &doctorId, const QString &dateAndTime,const QString &paymentMethod)
{
    emit bookingProgress();

    QJsonObject object;
    object.insert("appointmentType",appointmentType);
    object.insert("doctorId",doctorId);
    object.insert("appointmentDateAndTime",dateAndTime);
    object.insert("paymentType",paymentMethod);

    QString url = QString("%1/appointments").arg(NetworkManager::instance().baseUrl());
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    request.setRawHeader("authorization",QVariant(this->token()).toByteArray());
    QNetworkReply *reply = NetworkManager::instance().post(request,QJsonDocument(object).toJson());

    connect(reply, &QNetworkReply::finished, this, &Authentication::onBookAppointment );

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

        QJsonObject object = QJsonDocument::fromJson(reply->readAll()).object();
        this->setUserName(object.value("fullname").toString());

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

void Authentication::onSignUp()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if(!reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute) == 200){
        emit signUpSuccess();
    }else{
        emit signUpFailure();
        qDebug() << reply->errorString();
    }

    reply->deleteLater();
}

void Authentication::onBookAppointment()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if(!reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute) == 200){
        emit bookingSuccess();
        qDebug() << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    }else if(reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute)==409){
        Exception exception = NetworkManager::instance().fromJson(reply->readAll());
        qDebug() << exception.message;
    }else{
        qDebug() << reply->errorString();
        qDebug() << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
        emit bookingFailure();
    }
    reply->deleteLater();
}
