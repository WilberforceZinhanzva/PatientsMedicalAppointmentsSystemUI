import QtQuick
import QtQuick.Layouts
import Theming 1.0
import QtQuick.Controls

Item {
    id: root

    implicitWidth: 300
    implicitHeight: 50
    state: "default"

    property alias headingText: _textHeading.text
    property color borderColor: "#cccccc"
    property color selectionColor: "#cccccc"

    Rectangle{
        id: _rectangleBackground
        color: "#cccccc"
        anchors.fill: parent



        RowLayout{
            id: _rowLayout
            anchors.fill: parent

            Item{Layout.fillWidth: true}

            Rectangle{
                id: _rectangleRefresherBackground
                width: 30
                height: width
                radius: width/2
                border.width: 2
                border.color: borderColor
                color: selectionColor
                Layout.alignment: Qt.AlignVCenter

               BusyIndicator{
                   id: _busyIndicator
                   running: false
                    width: 25
                    height: 25
                   anchors.centerIn: parent


               }

            }


            Text{
                id: _textHeading
                font.family: Theme.primaryFont
                font.pixelSize: 13
                color: "black"
                Layout.alignment: Qt.AlignVCenter
            }

            Item{Layout.fillWidth: true}
        }


    }

    states: [
        State{
            name: "default"

            PropertyChanges{
                target: root
                borderColor: "#cccccc"
            }
            PropertyChanges {
                target: _busyIndicator
                running: false

            }
        },
        State{
            name: "loading"
            PropertyChanges{
                target: root
                borderColor: Theme.secondaryColor
            }
            PropertyChanges {
                target: _busyIndicator
                running: true

            }
        },
        State{
            name: "active"
            PropertyChanges{
                target: root
                borderColor: Theme.primaryColor
            }
            PropertyChanges {
                target: _busyIndicator
                running: false

            }
        }

    ]




}
