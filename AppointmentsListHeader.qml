import QtQuick
import QtQuick.Layouts

Item {
    id: root
    width: _rectangleBackground.width
    height: 50

    Rectangle{
        id: _rectangleBackground
        width: Math.max(_layout.width,root.parent.width)
        height: parent.height
        color: "transparent"


        RowLayout{
            id: _layout
            anchors.verticalCenter: parent.verticalCenter

            Item{
                id: _itemIndex
                width: 150
                Layout.minimumWidth: width
                Layout.maximumWidth: width
                Layout.alignment: Qt.AlignVCenter

            }
            AppointmentsListHeaderItem{
                id: _headerItemDoctor
                label: "Doctor"
                Layout.minimumWidth: width
            }
            AppointmentsListHeaderItem{
                id: _headerItemAppointmentType
                label: "Appointment Type"
                Layout.minimumWidth: width
            }
            AppointmentsListHeaderItem{
                id: _headerItemAppointmentDate
                label: "Appointment Date"
                Layout.minimumWidth: width
            }
            AppointmentsListHeaderItem{
                id: _headerItemAppointmentDuration
                label: "Duration"
                Layout.minimumWidth: width
            }
            AppointmentsListHeaderItem{
                id: _headerItemAppointmentStatus
                label: "Status"
                Layout.minimumWidth: width
            }
        }
    }





}
