#include "signalhandler.h"
#include "applicationstatemanager.h"
#include <QDebug>


SignalHandler &SignalHandler::instance()
{
    static SignalHandler signalHandler;
    return signalHandler;
}

void SignalHandler::selectAppointmentType(const QString &appointmentType)
{
    emit appointmentTypeSelected(appointmentType);
}

void SignalHandler::beginClearDateSelection()
{
    emit clearDateSelection();
}

void SignalHandler::onAppointmentTypeSelected(const QString &appointmentType)
{
    ApplicationStateManager::instance().setSelectedAppointmentType(appointmentType);
}

SignalHandler::SignalHandler()
{
    qDebug() << "Type changed";
    connect(this, &SignalHandler::appointmentTypeSelected, this, &SignalHandler::onAppointmentTypeSelected);
}

SignalHandler::SignalHandler(const SignalHandler &)
{

}

SignalHandler::~SignalHandler()
{

}
