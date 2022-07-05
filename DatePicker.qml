import QtQuick
import QtQuick.Layouts 1.0
import QtQuick.Controls.Imagine

Item {
    id: root

    implicitWidth: 400
    implicitHeight: 400


    property date currentDate : new Date()
    property alias selectionColor: _componentRefresherHeading.selectionColor
    signal dateSelected(string date)

    ComponentRefresherHeading{
        id: _componentRefresherHeading

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        headingText: "Choose Date"
    }




        ListView{
            id: _listViewCurrentMonth
            width: 300
            anchors.top: _componentRefresherHeading.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            spacing: 20
            clip: true
            model: CalendarModel{
                from:  new Date()
                to: new Date(currentDate.setDate(currentDate.getDate() + 30))
            }
            delegate: ColumnLayout{
                width: _listViewCurrentMonth.width
                spacing: 10

                MonthHeading{
                    id: _monthHeading
                    title: _monthGrid.title
                    width: parent.width
                    Layout.topMargin: 10
                }

                DayOfWeekRow{
                    id: _dayOfWeekRow
                    locale: _monthGrid.locale
                    Layout.fillWidth: true
                }
                MonthGrid{
                    id: _monthGrid
                    month: model.month
                    year: model.year
                    locale: Qt.locale("en_US")
                    Layout.fillWidth: true

                     delegate:MonthDate{
                        width: 50
                        height: width
                        state: monthGridState(_monthGrid.month,model.date)
                        dayNumber: model.day
                        onClicked:{
                            dateSelected(model.date)

                        }
                    }
                }
            }
        }

        function monthGridState(gridMonth,gridDate){
            if(gridMonth != gridDate.getMonth()){
                return "disabled"
            }else if(gridDate < new Date()){
                return "invalid"
            }else{
                return "default"
            }
        }


}
