#include "timeslotmodel.h"
#include "networkmanager.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include <QTime>

QString convertToTimeOfDay(const QString& time){
    QTime qTime = QTime::fromString(time,"HH:mm:ss");
    return QLocale("en_GB").toString(qTime,"hh:mm ap");
}


TimeSlotModel::TimeSlotModel(QObject *parent)
    : QAbstractListModel{parent}
{

}

TimeSlotModel::~TimeSlotModel()
{
    clear();
}

void TimeSlotModel::clear()
{
    foreach(const TimeSlot*  t , m_timeSlots){
        delete t;
    }
    m_timeSlots.clear();
}

void TimeSlotModel::fetchTimeSlots(const QString &appointmentType, const QString &doctor, const QString &date)
{
    QString url = QString("%1/time-slots/%2/%3/%4").arg(NetworkManager::instance().baseUrl()).arg(doctor).arg(date).arg(appointmentType);
    QNetworkRequest request(url);
    QNetworkReply *reply = NetworkManager::instance().get(request);
    connect(reply, &QNetworkReply::finished,this, &TimeSlotModel::onTimeSlotsFetched);
}

void TimeSlotModel::onTimeSlotsFetched()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if(!reply->error()){
        beginResetModel();
        clear();
        QJsonArray array = QJsonDocument::fromJson(reply->readAll()).array();
        foreach(const QJsonValue& v , array){
            QJsonObject object = v.toObject();
            TimeSlot *timeSlot = new TimeSlot();
            timeSlot->startTime = object.value("startTime").toString();
            timeSlot->endTime = object.value("endTime").toString();
            timeSlot->taken = object.value("taken").toBool();
            m_timeSlots.push_back(timeSlot);
        }
        endResetModel();
        setSize(m_timeSlots.size());
    }
    if(reply->error()){

        if(reply->attribute(QNetworkRequest::HttpStatusCodeAttribute) == 409){
            Exception exception = NetworkManager::instance().fromJson(reply->readAll());
            qDebug()<< exception.message;
        }else{
            qDebug() << reply->errorString();
        }

    }
    reply->deleteLater();

}

int TimeSlotModel::rowCount(const QModelIndex &parent) const
{
    return m_timeSlots.size();
}

QVariant TimeSlotModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();

    switch(role){
        case StartTimeRole:

        return convertToTimeOfDay(m_timeSlots.at(row)->startTime);
    case EndTimeRole:
        return convertToTimeOfDay(m_timeSlots.at(row)->endTime);
    case TakenRole:
        return m_timeSlots.at(row)->taken;

    }
    return QVariant();
}

QHash<int, QByteArray> TimeSlotModel::roleNames() const
{
    QHash<int,QByteArray> names;
    names.insert(TimeSlotRole::StartTimeRole,"startTime");
    names.insert(TimeSlotRole::EndTimeRole,"endTime");
    names.insert(TimeSlotRole::TakenRole,"taken");
    return names;
}

int TimeSlotModel::size() const
{
    return m_size;
}

void TimeSlotModel::setSize(int newSize)
{
    if (m_size == newSize)
        return;
    m_size = newSize;
    emit sizeChanged();
}



