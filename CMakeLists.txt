cmake_minimum_required(VERSION 3.16)

project(PatientsMedicalAppointmentsSystem VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(PatientsMedicalAppointmentsSystem_SOURCES main.cpp authentication.cpp networkmanager.cpp doctormodel.cpp notificationmanager.cpp signalhandler.cpp applicationstatemanager.cpp timeslotmodel.cpp dialogsmanager.cpp pagenavigator.cpp appointmentsmodel.cpp)
set(PatientsMedicalAppointmentsSystem_HEADERS authentication.h networkmanager.h doctormodel.h notificationmanager.h signalhandler.h applicationstatemanager.h timeslotmodel.h dialogsmanager.h pagenavigator.h appointmentsmodel.h)
set(PatientsMedicalAppointmentsSystem_RESOURCES assets.qrc)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

QT6_ADD_RESOURCES(PatientsMedicalAppointmentsSystem_RESOURCES_RCC ${PatientsMedicalAppointmentsSystem_RESOURCES})

qt_add_executable(appPatientsMedicalAppointmentsSystem
   ${PatientsMedicalAppointmentsSystem_SOURCES}
   ${PatientsMedicalAppointmentsSystem_HEADERS}
   ${PatientsMedicalAppointmentsSystem_RESOURCES_RCC}
)

qt_add_qml_module(appPatientsMedicalAppointmentsSystem
    URI PatientsMedicalAppointmentsSystem
    VERSION 1.0
    QML_FILES main.qml Theme.qml Dashboard.qml TextButton.qml Services.qml AppointmentTypeCard.qml AppointmentScheduler.qml DoctorPicker.qml ComponentRefresherHeading.qml DatePicker.qml
    MonthHeading.qml MonthDate.qml TimePicker.qml TimeSlot.qml LoginAndBookAppointment.qml BookAppointmentDialog.qml LoginDialog.qml RegistrationDialog.qml PatientAccount.qml
    AppointmentsListHeader.qml AppointmentsListHeaderItem.qml AppointmentsListDelegate.qml AppointmentsModelItem.qml PaymentMethodPicker.qml
)

set_target_properties(appPatientsMedicalAppointmentsSystem PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appPatientsMedicalAppointmentsSystem
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appPatientsMedicalAppointmentsSystem
    PRIVATE Qt6::Quick)
