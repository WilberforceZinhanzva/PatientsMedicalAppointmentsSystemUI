import QtQuick
import CollectionModels 1.0
import QtQuick.Controls

Item {

    id: root

    implicitWidth: 600
    implicitHeight: 400

    signal timeSelected(string time)

    property alias selectionColor: _componentRefresherHeading.selectionColor

    ComponentRefresherHeading{
        id: _componentRefresherHeading
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        headingText: "Choose Time"
    }

    ButtonGroup{
        id: _buttonGroup
    }

    GridView{
        id: _gridView
        width: cellWidth*2
        anchors.top: _componentRefresherHeading.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        cellWidth: 210
        cellHeight: 70
        clip: true

        model: _timeSlotModel
        delegate: TimeSlot{
            timeRange: model.startTime + " - "+ model.endTime
            onClicked: {
                timeSelected(model.startTime)
            }


            Component.onCompleted: setButtonGroup(_buttonGroup)
        }


    }



    TimeSlotModel{
        id: _timeSlotModel
    }


    function fetchTimeSlots(doctor,date,appointmentType){
        _timeSlotModel.fetchTimeSlots(appointmentType,doctor,date)
    }

}
