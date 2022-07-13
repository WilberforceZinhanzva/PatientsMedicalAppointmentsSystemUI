#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStyleHints>
//[MODELS]
#include "doctormodel.h"
#include "timeslotmodel.h"
#include "appointmentsmodel.h"
//[UTILS]
#include "signalhandler.h"
#include "applicationstatemanager.h"
#include "authentication.h"
#include "dialogsmanager.h"
#include "pagenavigator.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);



    qmlRegisterSingletonType(QUrl("qrc:/PatientsMedicalAppointmentsSystem/Theme.qml"),"Theming",1,0,"Theme");
    qmlRegisterType<DoctorModel>("CollectionModels",1,0,"DoctorModel");
    qmlRegisterType<TimeSlotModel>("CollectionModels",1,0,"TimeSlotModel");
    qmlRegisterType<AppointmentsModel>("CollectionModels",1,0,"AppointmentsModel");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/PatientsMedicalAppointmentsSystem/main.qml"_qs);

    engine.rootContext()->setContextProperty("authentication",&Authentication::instance());
    engine.rootContext()->setContextProperty("signalHandler", &SignalHandler::instance());
    engine.rootContext()->setContextProperty("applicationStateManager", &ApplicationStateManager::instance());
    engine.rootContext()->setContextProperty("dialogsManager",&DialogsManager::instance());
    engine.rootContext()->setContextProperty("pageNavigator",&PageNavigator::instance());
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
