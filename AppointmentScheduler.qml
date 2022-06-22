import QtQuick
import QtQuick.Layouts
import Theming 1.0
import Qt5Compat.GraphicalEffects

Item {
    id: root

    ColumnLayout{
        id: _layoutMain
        anchors.fill: parent
        anchors.margins: 10

        Item{
            id: _itemBackButton
            width: 30
            height: 30
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Rectangle{
                id: _rectangleBackButton
               anchors.fill: parent
                radius: width/2
                color: Theme.baseColor
            }
            DropShadow{
                anchors.fill: _rectangleBackButton
                source: _rectangleBackButton
                color: "#cccccc"
                radius: 8
                transparentBorder: true

            }
        }


    }

}
