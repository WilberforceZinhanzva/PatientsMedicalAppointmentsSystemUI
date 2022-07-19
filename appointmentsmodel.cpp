#include "appointmentsmodel.h"
#include "networkmanager.h"
#include "authentication.h"
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

AppointmentsModel::AppointmentsModel(QObject *parent)
    : QAbstractListModel{parent}
{

}

AppointmentsModel::~AppointmentsModel()
{
    clear();
}

void AppointmentsModel::fetchAppointments(const QString &key, const QString &value)
{

    QString url = QString("%1/appointments?key=%2&searchValue=%3").arg(NetworkManager::instance().baseUrl()).arg(key).arg(value);
    QNetworkRequest request(url);
    request.setRawHeader("Authorization",QVariant(Authentication::instance().token()).toByteArray());
    QNetworkReply* reply = NetworkManager::instance().get(request);
    connect(reply, &QNetworkReply::finished, this, &AppointmentsModel::onAppointmentsFetched);
}

void AppointmentsModel::cancelAppointment(const QString &id)
{
    QString url = QString("%1/appointments/%2/cancel/cancelled_by_patient/").arg(NetworkManager::instance().baseUrl()).arg(id);
    QNetworkRequest request(url);
    request.setRawHeader("Authorization",QVariant(Authentication::instance().token()).toByteArray());
    QNetworkReply *reply = NetworkManager::instance().sendCustomRequest(request,"PUT");
    connect(reply, &QNetworkReply::finished,this,&AppointmentsModel::onAppointmentCancelled);

}




void AppointmentsModel::clear()
{
    for(const Appointment* a : m_appointments){
        delete a;
    }
    m_appointments.clear();
}

void AppointmentsModel::updateAppointmentStatus(const QString &id, const QString &status)
{
    int row =0;
    for(Appointment *a : m_appointments){
        if(a->id == id){
            a->appointmentStatus = status;
            QModelIndex index = createIndex(row,0);
            emit dataChanged(index,index);
            break;
        }
        row++;
    }
}

void AppointmentsModel::onAppointmentsFetched()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if(!reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute)==200){
        QJsonArray array = QJsonDocument::fromJson(reply->readAll()).array();

        beginResetModel();
        clear();
        for(const QJsonValue& v : array){

            QJsonObject a = v.toObject();
            Appointment *appointment = new Appointment;
            appointment->id = a.value("id").toString();
            appointment->appointmentStatus = a.value("appointmentStatus").toString();
            appointment->appointmentType = a.value("appointmentType").toObject().value("name").toString();
            appointment->date = a.value("appointmentTime").toObject().value("date").toString();
            appointment->duration = a.value("appointmentTime").toObject().value("duration").toInt();
            appointment->doctor = a.value("doctor").toObject().value("fullname").toString();

            m_appointments.push_back(appointment);
        }
        endResetModel();

    }else{
        qDebug() << reply->errorString();
    }

}

void AppointmentsModel::onAppointmentCancelled()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());

    if(!reply->error() && reply->attribute(QNetworkRequest::HttpStatusCodeAttribute)==200){
        QJsonObject object = QJsonDocument::fromJson(reply->readAll()).object();
        QString id = object.value("id").toString();
        QString appointmentStatus = object.value("appointmentStatus").toString();
        updateAppointmentStatus(id,appointmentStatus);
    }else{
        qDebug() << reply->error();
    }

    reply->deleteLater();
}

int AppointmentsModel::rowCount(const QModelIndex &parent) const
{
    return m_appointments.size();
}

QVariant AppointmentsModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();

    switch(role){
        case IdRole:
        return m_appointments.at(row)->id;
    case AppointmentTypeRole:
        return m_appointments.at(row)->appointmentType;
    case AppointmentStatusRole:
        return m_appointments.at(row)->appointmentStatus;
    case DoctorRole:
        return m_appointments.at(row)->doctor;
    case DurationRole:
        return m_appointments.at(row)->duration;
    case DateRole:
        return m_appointments.at(row)->date;
    }
    return QVariant();
}

QHash<int, QByteArray> AppointmentsModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names.insert(IdRole,"Id");
    names.insert(AppointmentTypeRole, "AppointmentType");
    names.insert(AppointmentStatusRole,"AppointmentStatus");
    names.insert(DoctorRole, "Doctor");
    names.insert(DurationRole,"Duration");
    names.insert(DateRole,"Date");
    return names;
}
