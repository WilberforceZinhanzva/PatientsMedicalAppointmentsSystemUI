import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Imagine
import Theming 1.0

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
                font.pixelSize: 20
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



}
