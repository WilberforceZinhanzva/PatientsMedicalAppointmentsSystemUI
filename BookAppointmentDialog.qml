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
                text: "Book This Appointment"
                font.family: Theme.primaryFont
                color: "black"
                font.pixelSize: 14
                Layout.alignment: Qt.AlignHCenter
            }
        }

    }

}
