import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.3
import QtQuick 2.1
import Qt.labs.settings 1.0

Rectangle {

    Component.onCompleted: {
        inputS.text = systemAttributes.screenshotFilePath
        inputR.text = systemAttributes.recordVedioFilePath
    }


    Column{

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 30
        anchors.leftMargin: 30
        Row{

            id:screenshotPath
            height: 50
            spacing: 10
            Label{
                id:labelS
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Screenshot Path")
            }

            TextField {
                id:inputS

                width: 270
                height: 34
                anchors.verticalCenter: parent.verticalCenter
                placeholderText: qsTr("")

            }

            QmlImageButton{

                width:26
                height:26
                anchors.verticalCenter: parent.verticalCenter
                imgSourseHover: "qrc:/images/fileopen.png"
                imgSourseNormal: "qrc:/images/fileopen.png"
                imgSoursePress: "qrc:/images/fileopen.png"

                onClick: {
                    fileDialog.pathname = labelS.text.toString();
                    fileDialog.folder = inputS.text.toString()
                    fileDialog.open();
                }
            }
        }


        Row{

            height: 50
            spacing: 10
            Label{
                id:labelR
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Recording   Path")
            }

            TextField {
                id:inputR
                anchors.verticalCenter: parent.verticalCenter
                width: 270
                placeholderText: qsTr("")
            }

            QmlImageButton{
                anchors.verticalCenter: parent.verticalCenter
                width:26
                height:26
                imgSourseHover: "qrc:/images/fileopen.png"
                imgSourseNormal: "qrc:/images/fileopen.png"
                imgSoursePress: "qrc:/images/fileopen.png"

                onClick: {
                    fileDialog.pathname = labelR.text.toString();
                    fileDialog.folder = inputR.text.toString()
                    fileDialog.open();

                }

            }

        }

        Row{

            height: 50
            spacing: 30


            Text {
                id: txtScreenShotFarmat
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("image format:")
                font.family: "Roboto-Medium"
                font.pointSize: 15
                color: "black"
            }

            MyComBox{
                id:screenShotFarmat
                width: 100
                height: txtScreenShotFarmat.height+10
                anchors.verticalCenter: parent.verticalCenter

                model: ["jpeg", "png"]

                Component.onCompleted: currentIndex = systemAttributes.screenshotFileFormat

                onCurrentTextChanged:
                    systemAttributes.setscreenshotFileFormat(currentIndex)

            }

        }

        Row{

            height: 50
            spacing: 30
            Text {
                id: name2
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Roboto-Medium"
                font.pointSize: 12
                text: qsTr("video duration:")
            }

            QmlSpinBox{
                id:spinbox
                Component.onCompleted: spinbox.value = systemAttributes.recordVedioTime
                to:30
                anchors.verticalCenter: parent.verticalCenter
                myColor: "gray"

                onValueChanged: {
                    systemAttributes.setrecordVedioTime(value)
                }
            }

            Text {
                id: name3
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Roboto-Medium"
                font.pointSize: 12
                text: qsTr("maximum duration is 30 minute")
            }


        }

    }
    FileDialog {
        id: fileDialog
        property string pathname:""
        title: "Please choose a file path"
        selectFolder:true
        selectMultiple: false
        //folder: shortcuts.home
        onAccepted: {
            if(pathname === labelS.text.toString()){

                var str = fileDialog.fileUrl.toString();
                inputS.text = str.replace('file:///','');
                systemAttributes.setscreenshotFilePath(inputS.text.toString())

            }else if(pathname === labelR.text.toString()){
                inputR.text = fileDialog.fileUrl.toString().replace('file:///','');
                systemAttributes.setrecordVedioFilePath(inputR.text.toString())
            }

        }
        onRejected: {


        }
    }



}

