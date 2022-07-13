import QtQuick
import Theming 1.0

Item {
    id: root
    width: 150
    height: parent.height

    property alias label : _text.text

    Text{
        id: _text
        font.pixelSize: 11
        font.family: Theme.primaryFont
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

}
