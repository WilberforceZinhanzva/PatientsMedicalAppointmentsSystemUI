import QtQuick
import QtQuick.Controls
import Theming 1.0

ApplicationWindow {
    id: _applicationWindow
    width: 640
    height: 480
    visible: true
    visibility: Qt.WindowFullScreen
    title: qsTr("Medical Systems")
    background: Rectangle{
        color: Theme.baseColor
    }

    Item{
        id: _itemWrapper
        anchors.fill: parent

        Loader{
            id: _loader
            anchors.fill: parent
            anchors.bottomMargin: 20
            source: "Dashboard.qml"
        }

        Text{
            id: _textCopyright
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 5
            text: "\u00A9 nimblecode softwares"
            font.family: Theme.primaryFont
            font.pixelSize: 9
        }

        Rectangle{
            id: _rectangleOverlay
            anchors.fill: parent
            color: Qt.rgba(0,0,0,0.7)
            visible: dialogsManager.visible

            MouseArea{
                anchors.fill: parent
                onClicked: dialogsManager.closeDialog()
            }

            Loader{
                id: _loaderDialogsLoader
                anchors.centerIn: parent
                source: dialogsManager.dialogFile
            }



        }



    }

}
