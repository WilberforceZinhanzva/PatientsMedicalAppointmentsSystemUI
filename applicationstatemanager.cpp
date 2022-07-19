#include "applicationstatemanager.h"


ApplicationStateManager &ApplicationStateManager::instance()
{
    static ApplicationStateManager applicationStateManager;
    return applicationStateManager;
}

ApplicationStateManager::ApplicationStateManager()
{

}

ApplicationStateManager::ApplicationStateManager(const ApplicationStateManager &)
{

}

ApplicationStateManager::~ApplicationStateManager()
{

}

const QString &ApplicationStateManager::selectedPaymentMethod() const
{
    return m_selectedPaymentMethod;
}

void ApplicationStateManager::setSelectedPaymentMethod(const QString &newSelectedPaymentMethod)
{
    if (m_selectedPaymentMethod == newSelectedPaymentMethod)
        return;
    m_selectedPaymentMethod = newSelectedPaymentMethod;
    emit selectedPaymentMethodChanged();
}



const QString &ApplicationStateManager::selectedDoctor() const
{
    return m_selectedDoctor;
}

void ApplicationStateManager::setSelectedDoctor(const QString &newSelectedDoctor)
{
    if (m_selectedDoctor == newSelectedDoctor)
        return;
    m_selectedDoctor = newSelectedDoctor;
    emit selectedDoctorChanged();
}

const QString &ApplicationStateManager::selectedDate() const
{
    return m_selectedDate;
}

void ApplicationStateManager::setSelectedDate(const QString &newSelectedDate)
{
    if (m_selectedDate == newSelectedDate)
        return;
    m_selectedDate = newSelectedDate;
    emit selectedDateChanged();
}

const QString &ApplicationStateManager::selectedTime() const
{
    return m_selectedTime;
}

void ApplicationStateManager::setSelectedTime(const QString &newSelectedTime)
{
    if (m_selectedTime == newSelectedTime)
        return;
    m_selectedTime = newSelectedTime;
    emit selectedTimeChanged();
}

const QString &ApplicationStateManager::selectedAppointmentType() const
{
    return m_selectedAppointmentType;
}

void ApplicationStateManager::setSelectedAppointmentType(const QString &newSelectedAppointmentType)
{
//    if (m_selectedAppointmentType == newSelectedAppointmentType)
//        return;
    m_selectedAppointmentType = newSelectedAppointmentType;
    emit selectedAppointmentTypeChanged();
}
