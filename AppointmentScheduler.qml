import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Imagine
import Theming 1.0
import Qt5Compat.GraphicalEffects

Item {
    id: root

    property string selectedAppointmentType
    property string selectedDate
    property string selectedDoctor
    property string selectedTime

    signal selectionMade()


    ScrollView{
        id: _scrollView
        width: root.width
        height: root.height
        contentWidth: _completePage.width
        contentHeight: _completePage.height

        //[NEW]

        Item{
            id: _completePage
            implicitWidth: Math.max(childrenRect.width, root.width)
            height: childrenRect.height


            //[Top Image]
            Image{
                id:_image
                width: 120
                height: 120
                anchors.horizontalCenter: parent.horizontalCenter
                source: fetchImage()
                layer.enabled: true
                layer.effect: OpacityMask{
                    maskSource: Item{
                        width: _image.width
                        height: _image.height
                        Rectangle{
                            anchors.fill:parent
                            width: parent.width
                            height: parent.height
                            radius: width/2
                        }
                    }
                }
            }

            //[Compobox]

            ComboBox{
                id: _comboboxAppointmentTypes
                anchors.top: _image.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                model: ["Consultancy","Surgery","Optics","Dental"]
                currentIndex: getCurrentIndex()
                font.family: Theme.primaryFont
                font.pixelSize: 11
                onCurrentIndexChanged: {
                    switch(currentIndex){
                    case 0:
                        signalHandler.selectAppointmentType("consultancy");
                        break;
                    case 1:
                        signalHandler.selectAppointmentType("surgery");
                        break;
                    case 2:
                        signalHandler.selectAppointmentType("optics");
                        break;
                    case 3:
                        signalHandler.selectAppointmentType("dental");
                        break;
                    }
                }

                function getCurrentIndex(){
                    switch(root.selectedAppointmentType){
                    case "consultancy":
                        return 0;
                    case "surgery":
                        return 1;
                    case "optics":
                        return 2;
                    case "dental":
                        return 3;
                    default:
                        return 0;
                    }
                }
            }

            //[Title Text]
            Text{
                id: _textTitle
                anchors.top: _comboboxAppointmentTypes.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<font>You are about to make an appointment for <font color='#FF9A02'><strong>"+ selectedAppointmentType.toLocaleUpperCase()+"</strong></font>. Complete your appointment by choosing a doctor, date and time below.</font>"
                width: 350
                wrapMode: Text.WordWrap
                font.family: Theme.primaryFont
                font.pixelSize: 11
                color: "black"
                textFormat: Text.RichText
                horizontalAlignment: Qt.AlignHCenter

            }
            RowLayout{
                id: _rowLayout
                anchors.top: _textTitle.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter




                DoctorPicker{
                    id: _doctorPicker
                    Layout.minimumHeight: parent.height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    selectionColor: selectedDoctor.length > 0 ? Theme.primaryColor : "#cccccc"

                }


                DatePicker{
                    id: _datePicker
                    Layout.minimumHeight: parent.height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    selectionColor: selectedDate.length >0 ? Theme.primaryColor : "#cccccc"

                }

                TimePicker{
                    id: _timePicker
                    width: 600
                    Layout.minimumHeight: parent.height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    selectionColor: selectedTime.length > 0 ? Theme.primaryColor : "#cccccc"
                }
            }

            Rectangle{
                id: _rectangleBase

                height: 100
                anchors.top: _rowLayout.bottom
                anchors.left: _rowLayout.left
                anchors.right: _rowLayout.right
                anchors.topMargin: 10
                color: Theme.primaryColor

                RowLayout{
                    id: _rowLayoutBase
                    anchors.fill: parent
                    anchors.margins: 10

                    Text{
                        id: _textSummary
                        text: "Your "+ selectedAppointmentType + " appointment on "+ selectedDate + " is now ready"
                        font.family: Theme.primaryFont
                        font.pixelSize: 15
                        font.bold: true
                        color: "white"
                        wrapMode: Text.WordWrap
                        Layout.maximumWidth: 350
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft


                    }

                    Rectangle{
                        id: _rectangleSubmitButton
                        width: 210
                        height: 35
                        radius: width/2
                        color: "white"
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                        Text{
                            anchors.centerIn: parent
                            text: authentication.authenticated ? "Book Appointment":"Sign In & Book Appointment"
                            font.pixelSize: 12
                            font.bold: true
                            font.family: Theme.primaryFont
                            color: Theme.primaryFont



                        }

                        MouseArea{
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if(authentication.authenticated){
                                    dialogsManager.openDialog("BookAppointmentDialog.qml")
                                }else{
                                     dialogsManager.openDialog("LoginAndBookAppointment.qml")
                                }


                            }
                        }
                    }

                }

            }




        }



    }

    onSelectedAppointmentTypeChanged: {
        applicationStateManager.selectedAppointmentType = root.selectedAppointmentType
         selectionMade()
    }
    onSelectedDateChanged: {
        applicationStateManager.selectedDate = root.selectedDate
        selectionMade()
    }
    onSelectedDoctorChanged: {
        applicationStateManager.selectedDoctor = root.selectedDoctor
        selectionMade()
    }
    onSelectedTimeChanged: {
        applicationStateManager.selectedTime = root.selectedTime
    }

    onSelectionMade: {
        if(root.selectedAppointmentType.length > 0 && root.selectedDate.length > 0 && root.selectedDoctor.length > 0){
            _timePicker.fetchTimeSlots(root.selectedDoctor,root.selectedDate,root.selectedAppointmentType)
        }
    }




    Connections{
        target: signalHandler

        function onAppointmentTypeSelected(appointmentType){
            root.selectedAppointmentType = appointmentType
        }
    }

    Connections{
        target: _doctorPicker
        ignoreUnknownSignals: true

        function onDoctorSelected(doctorId){
            root.selectedDoctor = doctorId
        }
    }

    Connections{
        target: _datePicker
        ignoreUnknownSignals: true

        function onDateSelected(date){

            let tempDate = new Date(date)
            let year = tempDate.getFullYear()
            let month = tempDate.getMonth() + 1
            let day = tempDate.getDate();

            root.selectedDate = formatDateDigit(day) + "-"+ formatDateDigit(month)+"-"+year

        }
    }

    Connections{
        target: _timePicker
        ignoreUnknownSignals: true

        function onTimeSelected(time){
            if(time.endsWith("am")){
                let tempTime = time.substring(0,time.lastIndexOf("am"))
                root.selectedTime = tempTime.trim()
            }
            else if(time.endsWith("pm")){
                let tempTime = time.substring(0,time.lastIndexOf("pm"))

                let frontPart = tempTime.substring(0,tempTime.lastIndexOf(":"));
                if(frontPart.startsWith("0")){
                    frontPart = frontPart.substring(1,frontPart.length);
                }

                let backPart = tempTime.substring(tempTime.lastIndexOf(":"), tempTime.length)
                let timeValueIn24Hr = Number(frontPart) + 12;
                let timeValueIn24HrString = timeValueIn24Hr + "";
                if(timeValueIn24Hr == 24){
                    timeValueIn24HrString = "00";
                }

                root.selectedTime = timeValueIn24HrString + backPart
                root.selectedTime.trim();
            }
            console.log("SELCTED TIME "+ root.selectedTime)
        }
    }

    function fetchImage(){
        switch(root.selectedAppointmentType){
        case "dental":
            return "qrc:/images/dental.jpg";
        case "optics":
            return "qrc:/images/optics.jpeg";
        case "consultancy":
            return "qrc:/images/consultancy.jpeg";
        case "surgery":
            return "qrc:/images/surgery.jpeg";
        default:
            return "";

        }
    }

    function formatDateDigit(digit){
        digit+=""
        if(digit.length < 2){
            return "0"+digit
        }
        return digit
    }

}
