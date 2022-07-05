import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Theming 1.0

Item {
    id: root

    anchors.fill: parent

//Top Bar

    Item{
        id: _itemTopBar
        height: 35
        anchors.top: root.top
        anchors.left: root.left
        anchors.right: root.right

        RowLayout{
            id: _layoutTopBarLayout
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 10
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Text{
                id: _textApplicationName
                text: "<font>medi<strong><font color="+Theme.primaryColor+">CAL</font></strong></font>"
                font.family: Theme.primaryFont
                font.pixelSize: 25
                textFormat: Text.RichText
            }

            Item{
                id:_spacer
                Layout.fillWidth: true

            }

            TextButton{
                id: _textButtonSignUp
                buttonText: "Sign Up"
                textPosition: "right"
            }
            TextButton{
                id: _textButtonSignIn
                buttonText: "Sign In"
                textPosition: "right"
                onClicked: {
                    dialogsManager.openDialog("LoginDialog.qml")
                }
            }

        }
    }

//StackView

    StackView{
        id: _stackView
        anchors.top: _itemTopBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        initialItem: "Services.qml"


    }


    Connections{
        target: _stackView.currentItem
        ignoreUnknownSignals: true
        function onNavigate(page){
            switch(page){
            case "scheduler":
                _stackView.push("AppointmentScheduler.qml")
            }
        }
    }




}
