import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {


    Rectangle{
        id:label_login
        color: "#d3dfc1"
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 100
        height:32

        Text {
            id: name
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            anchors.left: parent.left
            text: qsTr("Login configuration")
            font.pixelSize: 12
            font.bold: true

        }
    }

    Row{

        id:config_login
        anchors.top: label_login.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
       // width: label_login.width

        height: 50
        spacing: 50
        QmlCheck {
            id:checkboxAlogin

            anchors.verticalCenter: parent.verticalCenter
            checked: false
            text: qsTr("login automatically")
        }

        QmlCheck {
            id:checkboxAboot

            anchors.verticalCenter: parent.verticalCenter
            checked: false
            text: qsTr("boot automatically")
        }

        QmlCheck {
            id:checkboxReset

            anchors.verticalCenter: parent.verticalCenter
            checked: false
            text: qsTr("reset")
        }


    }

    Rectangle{
        id:label_other
        color: "#d3dfc1"
        anchors.top: config_login.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 100
        height:32

        Text {
            id: name1
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            anchors.left: parent.left
            text: qsTr("Other configuration")
            font.pixelSize: 12
            font.bold: true

        }
    }

    Row{

        height: 50
        spacing: 50
        anchors.top: label_other.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        QmlCheck {
            id:checkboxLockScreen

            anchors.verticalCenter: parent.verticalCenter
            checked: false
            text: qsTr("automatic lock screen")
        }

        Rectangle{

            anchors.verticalCenter: parent.verticalCenter
            width: name2.width + spinbox.width + name3.width
            height: 30

            Text {
                id: name2
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Roboto-Medium"
                font.pointSize: 12
                text: qsTr("waiting time:")
            }

            QmlSpinBox{
                id:spinbox
                anchors.left: name2.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                myColor: "gray"
            }

            Text {
                id: name3
                anchors.left: spinbox.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Roboto-Medium"
                font.pointSize: 12
                text: qsTr("(0~30)minute")
            }
        }




    }



}
