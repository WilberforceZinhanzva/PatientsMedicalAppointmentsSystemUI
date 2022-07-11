import QtQuick
import Theming 1.0
import QtQuick.Layouts

Item {
    id: root

    implicitWidth: 350
    implicitHeight: 400

    Rectangle{
        id: _rectangleBackground
        anchors.fill: parent
        color: "white"
        radius: 5

        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 10

            Text{
                id: _textTitle
                text: "<font>Hi <strong>"+ authentication.userName + "</strong> you can go ahead and book your appointment</font>"
                font.family: Theme.primaryFont
                color: "black"
                font.pixelSize: 14
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 300
                wrapMode: Text.WordWrap
                horizontalAlignment: Qt.AlignHCenter
                textFormat: Text.RichText
            }

            Text{
                id: _textStatus
                visible: false
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle{
                id: _rectangleButton
                Layout.fillWidth: true
                Layout.margins: 20
                height: 35
                radius: width/2
                color: Theme.primaryColor

                Text{
                    id: _textButtonText
                    text: "Book Appointment"
                    color: "white"
                    anchors.centerIn: parent
                    font.family: Theme.primaryFont
                    font.pixelSize: 11
                }

                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked:{
                        let dateAndTime = applicationStateManager.selectedDate + " "+applicationStateManager.selectedTime

                       authentication.bookAppointment(applicationStateManager.selectedAppointmentType,applicationStateManager.selectedDoctor,dateAndTime)

                    }
                }
            }
        }


        Connections{
            target: applicationStateManager
            ignoreUnknownSignals: true
            function onBookingProgress(){
               _textStatus.text = "Booking in progress...Please Wait!"
               _textStatus.visible = true
            }

            function onBookingSuccess(){
                _textStatus.text = "Success!"
                _textStatus.visible = false

                //OPEN PATIENT ACCOUNT
            }
            function onBookingFailure(){
                _textStatus.text = "Booking Failed!"
                _textStatus.visible = true
            }

        }

    }

}
