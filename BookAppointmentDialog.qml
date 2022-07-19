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
            spacing: 10

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

            Item{Layout.fillHeight: true}

            Text{
                id: _textPaymentMethodSelection
                Layout.alignment: Qt.AlignHCenter
                text: "Choose Payment Method"
                font.family: Theme.primaryFont
                font.bold: true
                font.pixelSize: 10
            }

            RowLayout{
                id: _layoutPaymentOptions
                spacing: 10
                Layout.alignment: Qt.AlignHCenter

                PaymentMethodPicker{
                    id: _paymentMethodMedicalAid
                    label: "Medical Aid"
                }
                PaymentMethodPicker{
                    id: _paymentMethodOther
                    label: "Other"
                }
            }
            Item{Layout.fillHeight: true}

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
                        let dateAndTime = applicationStateManager.selectedDate.trim() + " "+applicationStateManager.selectedTime.trim()

                       authentication.bookAppointment(applicationStateManager.selectedAppointmentType,applicationStateManager.selectedDoctor,dateAndTime,applicationStateManager.selectedPaymentMethod)

                    }
                }
            }
        }




        Connections{
            target: _paymentMethodMedicalAid
            ignoreUnknownSignals: true
            function onClicked(name){
                _paymentMethodOther.state="normal"
                applicationStateManager.selectedPaymentMethod = "MEDICAL_AID"
            }
        }
        Connections{
            target: _paymentMethodOther
            ignoreUnknownSignals: true
            function onClicked(name){
                _paymentMethodMedicalAid.state="normal"
                applicationStateManager.selectedPaymentMethod = "CASH"
            }
        }
    }


    Connections{
        target: authentication
        ignoreUnknownSignals: true
        function onBookingProgress(){
           _textStatus.text = "Booking in progress...Please Wait!"
           _textStatus.visible = true
        }

        function onBookingSuccess(){
            _textStatus.text = "Success!"
            _textStatus.visible = false

            //OPEN PATIENT ACCOUNT
             dialogsManager.closeDialog()
            pageNavigator.navigateToPage("PatientAccount.qml")

        }
        function onBookingFailure(){
            _textStatus.text = "Booking Failed!"
            _textStatus.visible = true
        }

    }

}
