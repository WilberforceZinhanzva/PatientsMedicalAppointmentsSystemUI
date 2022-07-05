import QtQuick
import Qt5Compat.GraphicalEffects
import Theming 1.0

Item {
    id: root
    implicitWidth: 300
    implicitHeight: 40

    property alias title: _textTitle.text

    Rectangle{
        id: _rectangleBackground
        anchors.fill: parent
        color: Theme.baseColor
        radius: 5

        Text{
            id: _textTitle
            anchors.centerIn: parent
            font.family: Theme.primaryFont
            font.pixelSize: 11
            font.bold: true
            color : Theme.primaryColor

        }
    }
    DropShadow{
        anchors.fill: _rectangleBackground
        source: _rectangleBackground
        color: "#cccccc"
        verticalOffset: 0
        horizontalOffset: 0
        radius: 10
        transparentBorder: true
    }

}
