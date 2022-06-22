import QtQuick
import QtQuick.Controls
import Theming 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    visibility: Qt.WindowFullScreen
    title: qsTr("Medical Systems")
    background: Rectangle{
        color: Theme.baseColor
    }


    Loader{
        id: _loader
        anchors.fill: parent
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
}
