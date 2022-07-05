#include "doctormodel.h"
#include "networkmanager.h"
#include "notificationmanager.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>




DoctorModel::DoctorModel()
{

}

void DoctorModel::fetchDoctorsByAppointmentType(const QString &appointmentType)
{
    this->setAccessingNetwork(true);
    QString url = QString("%1/doctors/%2/%3").arg(NetworkManager::instance().baseUrl()).arg("TypeOfAppointment").arg(appointmentType);
    QNetworkRequest request(url);
    QNetworkReply* reply = NetworkManager::instance().get(request);
    connect(reply, &QNetworkReply::finished,this,&DoctorModel::onDoctorsFetchedByAppointmentType);
}

void DoctorModel::clear()
{
    foreach(const Doctor* doc , m_doctors){
        delete doc;
    }
    m_doctors.clear();

}

void DoctorModel::onDoctorsFetchedByAppointmentType()
{
    QNetworkReply * reply = qobject_cast<QNetworkReply*>(sender());
    if(reply->error()){
        qDebug() << reply->errorString();
        emit NotificationManager::instance().showNotification(NotificationManager::ERROR,reply->errorString());

    }else if(reply->attribute(QNetworkRequest::HttpStatusCodeAttribute) == 409){
        Exception exception = NetworkManager::instance().fromJson(reply->readAll());
        emit NotificationManager::instance().showNotification(NotificationManager::ERROR, exception.message);

        qDebug()<< exception.message;

    }else{
        beginResetModel();
        clear();
        QJsonArray doctorsArray = QJsonDocument::fromJson(reply->readAll()).array();
        foreach(const QJsonValue& value, doctorsArray){
            QJsonObject object = value.toObject();

            Doctor *doc = new Doctor();
            doc->id = object.value("id").toString();
            doc->fullname = object.value("fullname").toString();
            doc->active = object.value("active").toBool();
            m_doctors.push_back(doc);

        }
        endResetModel();
        qDebug()<< "Fetched doctors successfully!";
    }
    this->setAccessingNetwork(false);
    reply->deleteLater();

    this->setSize(m_doctors.size());

}

int DoctorModel::size() const
{
    return m_size;
}

void DoctorModel::setSize(int newSize)
{
    if (m_size == newSize)
        return;
    m_size = newSize;
    emit sizeChanged();
}

bool DoctorModel::accessingNetwork() const
{
    return m_accessingNetwork;
}

void DoctorModel::setAccessingNetwork(bool newAccessingNetwork)
{
    if (m_accessingNetwork == newAccessingNetwork)
        return;
    m_accessingNetwork = newAccessingNetwork;
    emit accessingNetworkChanged();
}

int DoctorModel::rowCount(const QModelIndex &parent) const
{
    return m_doctors.size();
}

QVariant DoctorModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    switch(role){
        case DoctorRole::IdRole:
        return m_doctors.at(row)->id;
    case DoctorRole::FullnameRole:
        return m_doctors.at(row)->fullname;
    case DoctorRole::ActiveRole:
        return m_doctors.at(row)->active;
    }
    return QVariant();
}

QHash<int, QByteArray> DoctorModel::roleNames() const
{
    QHash<int,QByteArray> names;
    names.insert(DoctorRole::IdRole,"Id");
    names.insert(DoctorRole::FullnameRole,"Fullname");
    names.insert(DoctorRole::ActiveRole,"Active");
    return names;
}
