import QtQuick
import QtQuick.Layouts
import Theming 1.0

Item {
    id: root


    signal navigate(string page)


    ColumnLayout{
        id: _layoutMainLayout
        anchors.top: root.top
        anchors.left: root.left
        anchors.right: root.right
        anchors.bottom: root.bottom

        Text{
            id: _textTitleText1
            text: "Welcome"
            font.family: Theme.primaryFont
            font.pixelSize: 30
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
            color: Theme.primaryColor
            Layout.topMargin: 50
        }
        Text{
            id: _textTitleText2
            font.family: Theme.primaryFont
            font.pixelSize: 12
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: 400
            Layout.topMargin: 20
            wrapMode: Text.WordWrap
            text: "Your health is most important to us, therefore we are here to provide you with the best medical help possible through the providence of our time and highly qualified doctors. Your health is our concern!"
            horizontalAlignment: Qt.AlignHCenter
        }

        Text{
            id: _textTitleText3
            text: "Choose an appointment below"
            font.family: Theme.primaryFont
            font.pixelSize: 12
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
        }
        Item{
            id: _spacer1
            Layout.fillHeight: true
        }

        GridLayout{
            id: _layoutAppointmentTypesLayout
            Layout.alignment: Qt.AlignHCenter
            columns:3
            rowSpacing: 10
            columnSpacing: 10

            AppointmentTypeCard{
                id: _appointmentTypeCardConsultation
                appointmentTypeName: "Consulation"
                imageSource: "qrc:/images/consultancy.jpeg"
                onClicked: {
                    navigate("scheduler")
                    signalHandler.selectAppointmentType("consultancy")


                }

            }
            AppointmentTypeCard{
                id: _appointmentTypeCardOptical
                appointmentTypeName: "Optician"
                imageSource: "qrc:/images/optics.jpeg"
                onClicked: {
                    navigate("scheduler")
                    signalHandler.selectAppointmentType("optics")

                }
            }
            AppointmentTypeCard{
                id: _appointmentTypeCardDental
                appointmentTypeName: "Dental"
                imageSource: "qrc:/images/dental.jpg"
                onClicked: {
                    navigate("scheduler")
                    signalHandler.selectAppointmentType("dental")


                }
            }
            AppointmentTypeCard{
                id: _appointmentTypeCardSurgery
                Layout.columnSpan: 3
                Layout.alignment: Qt.AlignHCenter
                appointmentTypeName: "Surgery"
                imageSource: "qrc:/images/surgery.jpeg"
                onClicked: {
                    navigate("scheduler")
                    signalHandler.selectAppointmentType("surgery")


                }
            }
        }

        Item{
            id: _spacer2
            Layout.fillHeight: true
        }
    }

}
