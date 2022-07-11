import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Imagine
import Qt5Compat.GraphicalEffects
import Theming 1.0

Item {
    id: root

    implicitWidth: 200
    implicitHeight: 60

    signal clicked()


    property alias timeRange : _textTimeRange.text

    Rectangle{
        id: _rectangleBackground
        anchors.fill:parent
        anchors.margins: 10
        radius: 5
        color: Theme.baseColor



        RowLayout{
            anchors.fill: parent
            anchors.margins: 10


            RadioButton{
                id: _radioButton
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

            }
            Item{Layout.fillWidth: true}
            Text{
                id: _textTimeRange
                font.family: Theme.primaryFont
                font.pixelSize: 11
                font.bold: true

            }
            Item{Layout.fillWidth: true}



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

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            _radioButton.checked = true
            root.clicked()
        }
    }




    function setButtonGroup(buttonGroup){
        _radioButton.ButtonGroup.group = buttonGroup
    }




}
