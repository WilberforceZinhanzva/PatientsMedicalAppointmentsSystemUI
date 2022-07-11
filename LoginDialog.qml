import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Imagine
import Theming 1.0

Item
{
    id: root

    implicitWidth: 350
    implicitHeight: 400

    Rectangle{
        id: _rectanglebackground
        anchors.fill: parent
        color: "white"
        radius: 5

        ColumnLayout{
            id: _layoutMain
            anchors.fill: parent
            anchors.margins: 10

            Text{
                id: _textTitle
                text: "Account Sign In"
                Layout.alignment: Qt.AlignHCenter
                font.family: Theme.primaryFont
                font.pixelSize: 13
                color: "black"
            }

            TextField{
                id: _textFieldUsername
                Layout.fillWidth: true
                Layout.margins: 10
                font.pixelSize: 11
                font.family: Theme.primaryFont
                placeholderText: "Username"
            }
            TextField{
                id: _textFieldPassword
                Layout.fillWidth: true
                Layout.margins: 10
                font.pixelSize: 11
                font.family: Theme.primaryFont
                placeholderText: "Password"
                echoMode: TextField.Password
            }

            Item{Layout.fillHeight: true}

            Button{
                id: _buttonSubmit
                Layout.fillWidth: true
                Layout.margins: 10
                font.pixelSize: 11
                font.family: Theme.primaryFont
                text: "Sign In"
                enabled: _textFieldUsername.text.length > 0 && _textFieldPassword.text.length >0

                onClicked: {
                    if(authentication.authenticated){
                        pageNavigator.navigateToPage("PatientAccount.qml")
                        dialogsManager.closeDialog()
                    }else{
                        authentication.login(_textFieldUsername.text, _textFieldPassword.text)

                    }

                }
            }
        }
    }

    Connections{
        target: authentication

        function onAuthenticatedChanged(){
            if(authentication.authenticated){
                //Go TO Account
                pageNavigator.navigateToPage("PatientAccount.qml")
                dialogsManager.closeDialog()
            }
        }
    }

}
