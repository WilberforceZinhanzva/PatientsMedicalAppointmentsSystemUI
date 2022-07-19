import QtQuick
import Theming 1.0
import Qt5Compat.GraphicalEffects

Item {
    id: root

    width: 110
    height: 40
    state: "normal"

    property alias label: _text.text
    signal clicked(string name)

    Rectangle{
        id: _rectangleBackground
        anchors.fill: parent
        radius: 10
        color: "white"

        Text{
            id: _text
            anchors.centerIn: parent
            font.pixelSize: 10
            font.family: Theme.primaryFont
        }

        Behavior on color{
            ColorAnimation{duration: 200}
        }
    }

    DropShadow{
        anchors.fill: _rectangleBackground
        source: _rectangleBackground
        color: "#cccccc"
        radius: 10
        transparentBorder: true
    }

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
            if(root.state !== "selected"){
                root.state = "hovered"
            }
        }
        onExited: {
            if(root.state !== "selected"){
                root.state = "normal"
            }
        }

        onClicked: {
            root.clicked(root.label)
            if(root.state !== "selected"){
                root.state = "selected"
            }
        }
    }

    states:[
        State{
            name: "normal"
            PropertyChanges{
                target:  _rectangleBackground
                color: "white"
            }
            PropertyChanges{
                target: _text
                color: "black"
            }
        },
        State{
            name: "hovered"
            PropertyChanges{
                target:  _rectangleBackground
                color: "#cccccc"
            }
            PropertyChanges{
                target: _text
                color: "black"
            }
        },
        State{
            name: "selected"
            PropertyChanges{
                target:  _rectangleBackground
                color: Theme.primaryColor
            }
            PropertyChanges{
                target: _text
                color: "white"
            }
        }

    ]

}
