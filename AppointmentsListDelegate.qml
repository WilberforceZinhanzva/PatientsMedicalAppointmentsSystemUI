import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: root
    width: _rectangleBackground.width
    height: 50

    opacity: model.AppointmentStatus ==="Cancelled"? 0.5 : 1

    signal cancelAppointment(string appointmentId)

    Rectangle{
        id: _rectangleBackground
        width: Math.max(_layout.width,root.parent.width)
        height: parent.height
        color: "white"
        radius: 3


        RowLayout{
            id: _layout
            anchors.verticalCenter: parent.verticalCenter

            RowLayout{
                id: _layoutIndex
                width: 150
                Layout.minimumWidth: width
                Layout.maximumWidth: width
                Layout.alignment: Qt.AlignVCenter

                Image{
                    id: _imageIcon
                    Layout.alignment: Qt.AlignVCenter
                    width: 20
                    height: 20
                    source : "qrc:/icons/draggable-dots.svg"
                }

                Item{
                    id: _rectangleIndexBox
                    width: 25
                    height: 25
                    Rectangle{
                        id: _rectangle
                        anchors.fill: parent
                        radius: 3
                        color: model.index % 2 == 0 ? Qt.lighter(Theme.primaryColor) : Qt.lighter(Theme.secondaryColor)

                        Text{
                            anchors.centerIn: parent
                            text: model.index + 1
                            font.family: Theme.primaryFont
                            font.pixelSize: 11
                            font.bold: true
                            color: model.index % 2 == 0 ? Theme.primaryColor : Theme.secondaryColor
                        }

                    }

                }
            }

            AppointmentsModelItem{
                id: _modelItemDoctor
                Layout.minimumWidth: width
                label: model.Doctor
            }
            AppointmentsModelItem{
                id: _modelItemAppointmentType
                Layout.minimumWidth: width
                label: model.AppointmentType
            }
            AppointmentsModelItem{
                id: _modelItemAppointmentDate
                Layout.minimumWidth: width
                label: model.Date
            }
            AppointmentsModelItem{
                id: _modelItemDuration
                Layout.minimumWidth: width
                label: model.Duration + " minutes"
            }
            AppointmentsModelItem{
                id: _modelItemStatus
                Layout.minimumWidth: width
                label: model.AppointmentStatus
            }

            Item{
                id: _itemCancelAppointmentButton
                width: 150
                height: 35
                Layout.alignment: Qt.AlignVCenter
                visible: model.AppointmentStatus !== "Cancelled"
                Rectangle{
                    id: _rectangleButtonBackground
                    anchors.fill: parent
                    radius: width/2
                    color: "white"

                    Text{
                        anchors.centerIn: parent
                        color: Theme.primaryColor
                        font.family: Theme.secondaryColor
                        font.pixelSize: 11
                        text: "Cancel Appointment"

                    }

                }
                DropShadow{
                    anchors.fill: _rectangleButtonBackground
                    source: _rectangleButtonBackground
                    color: "#cccccc"
                    radius: 10
                    verticalOffset: 0
                    horizontalOffset: 0
                    transparentBorder: true
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: cancelAppointment(model.Id)
                }

            }

        }
    }
    DropShadow{
        anchors.fill: _rectangleBackground
        source: _rectangleBackground
        radius: 10
        color: "#cccccc"
        verticalOffset: 0
        horizontalOffset: 0
        transparentBorder: true
    }

}
