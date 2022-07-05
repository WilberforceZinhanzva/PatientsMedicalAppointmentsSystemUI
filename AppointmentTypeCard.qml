import QtQuick
import QtQuick.Layouts
import Theming 1.0
import Qt5Compat.GraphicalEffects

Item {
    id: root

    implicitWidth: 250
    implicitHeight: 90


    property alias appointmentTypeName : _textAppointmentType.text
    property alias imageSource: _image.source
    property bool hovered: false

    signal clicked()

    Rectangle{
        id: _rectangleBackground
        anchors.fill: parent
        color: Theme.baseColor
        radius: 10
         clip: true

        RowLayout{
            id: _layout
            anchors.fill: parent
            Image{
                id: _image
                width: 80
                height: 80
                Layout.maximumHeight: 80
                Layout.maximumWidth: 80
                Layout.minimumHeight: 80
                Layout.minimumWidth: 80
                Layout.leftMargin: 10
                fillMode: Image.PreserveAspectCrop
                Layout.alignment: Qt.AlignVCenter
                sourceSize.width: 80
                sourceSize.height: 80


            }
            Item{Layout.fillWidth: true}
            Text{
                id: _textAppointmentType
                font.family: Theme.primaryFont
                font.pixelSize: 15
                color: hovered ? Theme.primaryColor : "black"
                Layout.alignment: Qt.AlignVCenter

            }

            Item{Layout.fillWidth: true}
        }
    }
    DropShadow{
        anchors.fill: _rectangleBackground
        source: _rectangleBackground
        color: "#cccccc"
        verticalOffset: 0
        radius: 10
        transparentBorder: true
    }


    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.clicked()

    }

}
