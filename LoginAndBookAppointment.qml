import QtQuick
import QtQuick.Controls.Imagine
import QtQuick.Layouts
import Theming 1.0

Item {
    id: root

    implicitWidth: 350
    implicitHeight: 400

    Rectangle{
        id: _rectangleBackground
        anchors.fill: parent
        radius: 5
        color: "white"
        visible: !authentication.authenticated

        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 10

            Text{
                id: _textTitle
                text: "Login & Book Appointment"
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                Layout.topMargin: 20
                font.family: Theme.primaryFont
                font.pixelSize: 15
                color: "black"

            }

            TextField{
                id: _textFieldUsername
                Layout.fillWidth: true
                Layout.margins: 10
                placeholderText: "Username"
                font.family: Theme.primaryFont
                font.pixelSize: 11
            }
            TextField{
                id: _textFieldPassword
                Layout.fillWidth: true
                Layout.margins: 10
                placeholderText: "Password"
                font.family: Theme.primaryFont
                font.pixelSize: 11
                echoMode: TextField.Password

            }

            Item{Layout.fillHeight: true}

            Button{
                id: _buttonLogin
                Layout.fillWidth: true
                Layout.margins: 10
                text: "Login"
                font.family: Theme.primaryFont
                enabled: _textFieldUsername.text.length > 0 && _textFieldPassword.text.length > 0
                onClicked: {
                    authentication.login(_textFieldUsername.text, _textFieldPassword.text)
                }

            }
        }

    }





    Connections{
        target: authentication

        function onAuthenticatedChanged(){
            if(authentication.authenticated){
                dialogsManager.openDialog("BookAppointmentDialog.qml")
            }
        }
    }

}
