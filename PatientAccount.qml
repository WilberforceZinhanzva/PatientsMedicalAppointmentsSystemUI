import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Imagine
import Theming 1.0
import CollectionModels 1.0

Item {
    id: root
    anchors.fill: parent

    RowLayout{
        id: _layoutHeader
        height: 70
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        Rectangle{
            id: _rectangleLogo
            width: 200
            Layout.fillHeight: true
            color: Theme.primaryColor
            Layout.alignment: Qt.AlignLeft

            Text{
                anchors.centerIn: parent
                font.pixelSize: 17
                font.family: Theme.primaryFont
                textFormat: Text.RichText
                text: "<font>medi<strong>CAL</strong></font>"
                color: "white"
            }
        }
        ColumnLayout{
            id: _layoutLoggedUserInfo
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 10
            Text{
                id: _textPatientAccount
                text: "PATIENT ACCOUNT"
                font.pixelSize: 11
                font.family: Theme.primaryFont
                Layout.alignment: Qt.AlignLeft

            }
            Text{
                id: _textPatientName
                text: authentication.userName
                font.pixelSize: 11
                font.family: Theme.primaryFont

                font.bold: true
                color: Theme.primaryColor
                Layout.alignment: Qt.AlignLeft
            }
        }

        Item{Layout.fillWidth: true}

        Button{
            id: _buttonLogout
            icon.source:  "qrc:/icons/power-button.svg"
            icon.width: 15
            icon.height: 15
            icon.color: "white"
            text: "Logout"

            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignVCenter
            onClicked: pageNavigator.navigateToDefaultPage()
        }


    }

    Rectangle{
        id: _rectangleContentBackground
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: _layoutHeader.bottom
        color: "#F2F8FF"//Qt.rgba(29,122,255,0.5)

        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 20

            Text{
                id: _textTitle
                text: "Appointments"
                font.pixelSize: 20
                font.family: Theme.primaryFont
                Layout.alignment: Qt.AlignLeft
            }

            ListView{
                id: _listViewAppointments
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 10
                header: AppointmentsListHeader{

                }
                model: _appointmentsModel

                delegate: AppointmentsListDelegate{
                    id: _appointmentsListDelegate

                    Connections{
                        target: _appointmentsListDelegate
                        ignoreUnknownSignals: true
                        function onCancelAppointment(appointmentId){
                            _appointmentsModel.cancelAppointment(appointmentId)
                        }
                    }
                }
            }


        }
    }


    AppointmentsModel{
        id: _appointmentsModel
    }


    Component.onCompleted: {
        _appointmentsModel.fetchAppointments("All","")
    }





}
