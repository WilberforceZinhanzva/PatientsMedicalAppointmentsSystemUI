import QtQuick
import QtQuick.Layouts
import CollectionModels 1.0
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Imagine

Item {
    id: root

    implicitWidth: 300
    implicitHeight: 600

    property alias selectionColor: _componentRefresherHeading.selectionColor
    signal doctorSelected(string doctorId)

    ComponentRefresherHeading{
        id: _componentRefresherHeading
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        headingText: "Choose Doctor"
    }

    ButtonGroup{id: _buttonGroup}

    ListView{
        id: _listView
        anchors.top: _componentRefresherHeading.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: _doctorModel.size > 0
        model: _doctorModel
        spacing: 10
        delegate: Item{
            width: ListView.view.width
            height: 50

            Rectangle{
                id: _rectangleDoctorPad
                anchors.fill:parent
                color: Theme.baseColor
                radius: 5
                RowLayout{
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    RadioButton{
                        id: _radioButton
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        ButtonGroup.group: _buttonGroup
                        onCheckedChanged: {
                            if(_radioButton.checked){
                                doctorSelected(model.Id)
                            }
                        }
                    }
                    Text{
                        id: _textDoctorName
                        text: "Dr "+ model.Fullname
                        font.family: Theme.primaryFont
                        color: "black"
                        font.pixelSize: 11
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        Layout.leftMargin: 10
                    }
                    Item{
                        Layout.fillWidth: true
                    }
                }
            }
            DropShadow{
                anchors.fill: _rectangleDoctorPad
                source: _rectangleDoctorPad
                color: "#cccccc"
                radius: 5
                transparentBorder: true
                verticalOffset: 0
                horizontalOffset: 0
            }
        }

    }


    Rectangle{
        id: _rectanglePlaceholder
        anchors.top: _componentRefresherHeading.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "transparent"
        visible: _doctorModel.size > 0 ? false: true
        Text{
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: Theme.primaryFont
            font.pixelSize: 11
            text: "No Doctors Available"
            color: "#cccccc"
        }

    }

    DoctorModel{
        id: _doctorModel
    }

    Connections{
        target: applicationStateManager
        ignoreUnknownSignals: true

        function onSelectedAppointmentTypeChanged(){
            _doctorModel.fetchDoctorsByAppointmentType(applicationStateManager.selectedAppointmentType)
        }
    }





}
