import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Imagine
import Theming 1.0

Item {
    id: root

    implicitWidth: 350
    implicitHeight: 400

    function canRegister(){
        return _textFieldAddress.text.length > 0 &&
                _textFieldEmail.text.length > 0 &&
                _textFieldFullname.text.length >0 &&
                _textFieldPhone.text.length > 0 &&
                _textFieldUsername.text.length > 0 &&
                _textFieldPassord.text.length > 0 &&
                _textFieldConfirmPassword.text.length >0 &&
                (_textFieldPassord.text === _textFieldConfirmPassword.text)
    }

    Rectangle{
        id: _rectangleBackground
        anchors.fill:parent
        color: "white"
        radius: 5


        ColumnLayout{
            id: _layoutMain
            anchors.fill: parent
            anchors.margins: 10


            Text {
                id: _textTitle
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 20
                text: "Register"
                font.family: Theme.primaryFont
                font.pixelSize: 14
                color: "black"
            }

            TextField{
                id: _textFieldFullname
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                font.family: Theme.primaryFont
                font.pixelSize: 11
                placeholderText: "Fullname"
            }
            TextField{
                id: _textFieldEmail
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                font.family: Theme.primaryFont
                font.pixelSize: 11
                placeholderText: "Email"
            }
            TextField{
                id: _textFieldPhone
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                font.family: Theme.primaryFont
                font.pixelSize: 11
                placeholderText: "Phone"
            }
            TextField{
                id: _textFieldAddress
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                font.family: Theme.primaryFont
                font.pixelSize: 11
                placeholderText: "Address"
            }
            TextField{
                id: _textFieldUsername
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                font.family: Theme.primaryFont
                font.pixelSize: 11
                placeholderText: "Username"
            }
            TextField{
                id: _textFieldPassord
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                font.family: Theme.primaryFont
                font.pixelSize: 11
                placeholderText: "Password"
                echoMode: TextField.Password
            }
            TextField{
                id: _textFieldConfirmPassword
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                font.family: Theme.primaryFont
                font.pixelSize: 11
                placeholderText: "Confirm Password"
                echoMode: TextField.Password
            }

            Item{Layout.fillWidth: true}
            Text{
                id: _textSignUpProgress
                Layout.alignment: Qt.AlignHCenter
                text: "Processing...Please Wait!"
                font.family: Theme.primaryFont
                font.pixelSize: 10
                color: Theme.secondaryColor
                visible: false
            }

            Item{Layout.fillWidth: true}

            Button{
                id: _buttonSubmit
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                text: "Submit"
                enabled: canRegister()
                onClicked: {
                    authentication.signUp(_textFieldFullname.text,_textFieldPhone.text, _textFieldEmail.text, _textFieldAddress.text, _textFieldUsername.text,_textFieldPassord.text)
                }
            }



        }
    }


    Connections{
        target: authentication
        ignoreUnknownSignals: true

        function onSignUpInProgress(){
            _textSignUpProgress.visible = true
        }
        function onSignUpSuccess(){
            _textSignUpProgress.visible = false
            dialogsManager.closeDialog()
        }
        function onSignUpFailure(){
            _textSignUpProgress.text ="Failed to register!"
        }
    }

}
