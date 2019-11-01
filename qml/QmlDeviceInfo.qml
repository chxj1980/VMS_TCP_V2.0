import QtQuick 2.0
import QtQuick.Controls 2.5

Popup {
    id: root


    property string serip:""
    property string serport:""
    property string did:""
    property string serAcc:""
    property string serPwd:""

    x: parent.width/2 - root.width/2
    y: parent.height/2 - root.height/2
    width: 500
    height: infoRow.height + rectTitle.height +btn.height + 50
    modal: true
    focus: true
    property string str: ""
    property int type: 0//0：警告 1：错误   //f4ea2a ff0000
    //设置窗口关闭方式为按“Esc”键关闭


    closePolicy: Popup.OnEscape
    //设置窗口的背景控件，不设置的话Popup的边框会显示出来
    background: rect

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "#ffffff"
        opacity: 1
        radius: 2

        Rectangle{
            width: parent.width
            height: 2
            color: type>0?"red":"#e98f36"
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.left: parent.left
            radius: 1
        }

        //设置标题栏区域为拖拽区域

        Rectangle{
            id:rectTitle
            anchors.top: parent.top
            width: parent.width
            height: 40
            radius: 8
            color: "transparent"

            Text {

                text: qsTr("Device infomation")
                color: "#1296db"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family: "PingFang-SC-Medium"
                font.pixelSize: 15
                font.bold: true
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
            MouseArea {
                property point clickPoint: "0,0"

                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onPressed: {
                    clickPoint  = Qt.point(mouse.x, mouse.y)
                }
                onPositionChanged: {
                    var offset = Qt.point(mouse.x - clickPoint.x, mouse.y - clickPoint.y)
                    setDlgPoint(offset.x, offset.y)
                }
            }
        }

        Column{
            id:infoRow
            anchors.top: rectTitle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 50
            spacing: 20
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelip.width + txtIp.width + 20
                height: labelip.height
                Label{
                    id:labelDid
                    text: qsTr("device did:")
                }
                Label {
                    id: txtDid
                    anchors.left: labelDid.right
                    anchors.leftMargin: 20
                    text: did
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelip.width + txtIp.width + 20
                height: labelip.height
                Label{
                    id:labelip
                    text: qsTr("server ip:")
                }
                Label {
                    id: txtIp
                    anchors.left: labelip.right
                    anchors.leftMargin: 20
                    text: serip
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelip.width + txtIp.width + 20
                height: labelip.height
                Label{
                    id:labelport
                    text: qsTr("server port:")
                }
                Label {
                    id: txtport
                    anchors.left: labelport.right
                    anchors.leftMargin: 20
                    text: serport
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelip.width + txtIp.width + 20
                height: labelip.height
                Label{
                    id:labelAcc
                    text: qsTr("server Account:")
                }
                Label {
                    id: txtAcc
                    anchors.left: labelAcc.right
                    anchors.leftMargin: 20
                    text: serAcc
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelip.width + txtIp.width + 20
                height: labelip.height
                Label{
                    id:labelPwd
                    text: qsTr("server password:")
                }
                Label {
                    id: txtPwd
                    anchors.left: labelPwd.right
                    anchors.leftMargin: 20
                    text: serPwd
                }
            }



        }
        QmlButton{
            id:btn
            width: 100
            height: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: "ok"
            onClicked: root.close();
        }
        function setDlgPoint(dlgX ,dlgY)
        {
            //设置窗口拖拽不能超过父窗口
            if(root.x + dlgX < 0)
            {
                root.x = 0
            }
            else if(root.x + dlgX > root.parent.width - root.width)
            {
                root.x = root.parent.width - root.width
            }
            else
            {
                root.x = root.x + dlgX
            }
            if(root.y + dlgY < 0)
            {
                root.y = 0
            }
            else if(root.y + dlgY > root.parent.height - root.height)
            {
                root.y = root.parent.height - root.height
            }
            else
            {
                root.y = root.y + dlgY
            }
        }
    }

}
