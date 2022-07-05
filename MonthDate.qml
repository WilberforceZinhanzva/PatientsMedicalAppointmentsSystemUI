import QtQuick
import Qt5Compat.GraphicalEffects
import Theming 1.0


Item {
    id: root

    implicitWidth: 50
    implicitHeight: implicitWidth
    state: "default"

    property alias dayNumber: _textDate.text
    property bool selectable: false

    signal clicked()




    Rectangle{
        id: _rectangleBackground
        anchors.fill: parent
        radius: 5

        Text{
            id: _textDate
            anchors.centerIn: parent
            font.family: Theme.primaryFont
            font.pixelSize: 11
            font.bold: true
        }
    }
    DropShadow{
        anchors.fill: _rectangleBackground
        source: _rectangleBackground
        color: "#cccccc"
        radius: 10
        verticalOffset: 0
        horizontalOffset: 0
        transparentBorder: true
    }


    states:[
        State{
            name: "default"
            PropertyChanges {
                target: _rectangleBackground
                color: Theme.baseColor

            }
            PropertyChanges {
                target: _textDate
                color: "black"

            }
            PropertyChanges{
                target: root
                selectable: true
            }
        },
        State{
            name: "disabled"
            PropertyChanges {
                target: _rectangleBackground
                color: "#cccccc"

            }
            PropertyChanges {
                target: _textDate
                color: "gray"

            }
            PropertyChanges{
                target: root
                selectable: false
            }
        },
        State{
            name: "invalid"
            PropertyChanges {
                target: _rectangleBackground
                color: Qt.lighter("red")

            }
            PropertyChanges {
                target: _textDate
                color: "black"

            }
            PropertyChanges{
                target: root
                selectable: false
            }
        },
        State{
            name: "chosen"
            PropertyChanges {
                target: _rectangleBackground
                color: Theme.primaryColor

            }
            PropertyChanges {
                target: _textDate
                color: "white"

            }
            PropertyChanges{
                target: root
                selectable: false
            }
        }


    ]

    Behavior on scale{
        NumberAnimation{
            duration: 300
            easing.type: Easing.InOutSine
        }
    }


    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: root.scale = 1.2
        onExited: root.scale = 1
        onClicked: {
            if(root.selectable){
                signalHandler.beginClearDateSelection()
                root.state = "chosen"
                root.clicked()
            }

        }

    }

    Connections{
        target: signalHandler
        ignoreUnknownSignals: true

        function onClearDateSelection(){

            if(root.state == "chosen"){
                root.state = "default"
            }


        }
    }

    function toolTipText(){
        switch(root.state){
        case "default":
            return "Make an appointment on this date"
        case "disabled":
            return "This date is not present in this Month"

        default:
            return "You cannot make an appointment on this date"
        }
    }

}
