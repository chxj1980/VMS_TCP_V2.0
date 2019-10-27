import QtQuick 2.0

Rectangle{
    property bool isDown : false
    property string mArea: ""
    property string mDeviceID: ""

    property var mymodel
    property color backColor: "#eeeeee"

    width: parent.width
    height: isDown?(42 + load.height):42


    signal s_doubleClick(string did,string acc,string pwd,string ip,string port);

    Rectangle{
        id:listHead
        width: parent.width
        height: 42

        color: backColor
        Text {
            id: txt
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Roboto-Medium"
            font.pointSize: 12
            text: qsTr(mArea) + "("+mymodel.count+")"
        }


        Image {
            id: image
            width: 16
            height: 16
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            visible: true
            source: "qrc:/images/arrow.png"

            MouseArea{
                anchors.fill: parent

                hoverEnabled: true
                onEntered: image.source  = "qrc:/images/arrow_enter.png"
                onExited: image.source = "qrc:/images/arrow.png"

                onClicked:{

                    if (rotationAnimation.running === true)

                        return;


                    rotationAnimation.start();

                }
            }
        }




        RotationAnimation{
            id: rotationAnimation
            target: image
            from: 0
            to: 90
            duration: 100
            onStopped: {
                if (isDown === false)
                {

                    rotationAnimation.from = 90;
                    rotationAnimation.to = 0;
                }
                else
                {
                    rotationAnimation.from = 0;
                    rotationAnimation.to = 90;
                }
                isDown = !isDown;
            }
        }
    }

    Loader{

        id:load
        anchors.top: listHead.bottom
        anchors.left: listHead.left
        sourceComponent: isDown?listcmp:null
    }

    Component{
        id:listcmp
        ListView{
            id:listDe
            model: mymodel
            height:contentHeight
            width: listHead.width
            delegate:
                Rectangle{
                width: parent.width
                color:"white"
                height: 38
                Text {
                id: name
                text: qsTr(did)
                font.family: "Roboto-Medium"
                font.pointSize: 10
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                }

                Image {
                    id: img
                    width:20
                    height: 20
                    anchors.right:parent.right
                    anchors.rightMargin: 100
                    anchors.verticalCenter: parent.verticalCenter
                    source:isOnline?"qrc:/images/device_online.png":"qrc:/images/device_offline.png"
                }

                Text {
                    id: name1
                    text: isOnline ? qsTr("online"):qsTr("offline")
                    font.family: "Roboto-Medium"
                    font.pointSize: 10
                    anchors.left: img.right
                    color: isOnline ? "green":"red"
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea{
                    anchors.fill: parent

                    hoverEnabled: true
                    onEntered: {
                        color = "gray"
                    }
                    onExited: {
                        color = "white"
                    }


                    onDoubleClicked: {

                        s_doubleClick(did,account,password,ip,port)
                    }
                }

            }
        }

    }

}
