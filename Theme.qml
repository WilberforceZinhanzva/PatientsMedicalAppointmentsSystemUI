pragma Singleton
import QtQuick

Item {

    readonly property color primaryColor : "#1D7AFF"
    readonly property color secondaryColor : "#FF9A02"
    readonly property color baseColor: "white"

    readonly property alias primaryFont : font1.name

    FontLoader{
        id: font1
        source: "qrc:/fonts/WorkSans-VariableFont_wght.ttf"
    }


}
