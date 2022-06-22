import QtQuick
import Theming 1.0

Item {
    id: root
    implicitWidth: Math.max(60, _textButtonText.width + 20)
    implicitHeight: 30

    property alias buttonText: _textButtonText.text
    property bool hovered: false
    property string textPosition : "center"

    signal clicked()

    Text{
        id: _textButtonText
        font.pixelSize: 11
        font.family: Theme.primaryFont
        color: hovered ? Theme.primaryColor:"black"
        anchors.verticalCenter: root.verticalCenter

    }

    Component.onCompleted: {
        switch(textPosition){
            case "left":{
                _textButtonText.anchors.left = root.left
            }break;
            case "center":{
                _textButtonText.anchors.horizontalCenter = root.horizontalCenter
            }break;
            case "right":{
                _textButtonText.anchors.right = root.right
            }break;

        }
    }


    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: root.hovered=true
        onExited: root.hovered=false
        onClicked: root.clicked()
    }







}
