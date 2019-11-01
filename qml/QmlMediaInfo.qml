import QtQuick 2.0
import QtQuick.Controls 2.5

Popup {
    id: root

    property int fps:0
    property int rcmode:0
    property string did:""
    property int frametype:0
    property string staty0:""
    property int mwidth:0
    property int mheight:0

    property int samplerate:0
    property int prenum:0
    property int bitwidth:0
    property int soundmode:0


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

                text: qsTr("Media infomation")
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
            width:parent.width
            spacing: 8

            Label{
                text: qsTr("Vedio infomation:")
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelfps.width + txtfps.width + 20
                height: labelfps.height
                Label{
                    id:labelfps
                    text: qsTr("fps:")
                }
                Label {
                    id: txtfps
                    anchors.left: labelfps.right
                    anchors.leftMargin: 20
                    text: fps
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelrcmode.width + txtrcmode.width + 20
                height: labelrcmode.height
                Label{
                    id:labelrcmode
                    text: qsTr("rcmode:")
                }
                Label {
                    id: txtrcmode
                    anchors.left: labelrcmode.right
                    anchors.leftMargin: 20
                    text: rcmode
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelframetype.width + txtframetype.width + 20
                height: labelframetype.height
                Label{
                    id:labelframetype
                    text: qsTr("frametype:")
                }
                Label {
                    id: txtframetype
                    anchors.left: labelframetype.right
                    anchors.leftMargin: 20
                    text: frametype
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelstaty0.width + txtstaty0.width + 20
                height: labelstaty0.height
                Label{
                    id:labelstaty0
                    text: qsTr("staty0:")
                }
                Label {
                    id: txtstaty0
                    anchors.left: labelstaty0.right
                    anchors.leftMargin: 20
                    text: staty0
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelwidth.width + txtwidth.width + 20
                height: labelwidth.height
                Label{
                    id:labelwidth
                    text: qsTr("width:")
                }
                Label {
                    id: txtwidth
                    anchors.left: labelwidth.right
                    anchors.leftMargin: 20
                    text: mwidth
                }
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelheight.width + txtheight.width + 20
                height: labelheight.height
                Label{
                    id:labelheight
                    text: qsTr("height:")
                }
                Label {
                    id: txtheight
                    anchors.left: labelheight.right
                    anchors.leftMargin: 20
                    text: mheight
                }
            }
            Label{

                font.bold: true
                text:"Audio infomation"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelsamplerate.width + txtsamplerate.width + 20
                height: labelsamplerate.height
                Label{
                    id:labelsamplerate
                    text: qsTr("samplerate:")
                }
                Label {
                    id: txtsamplerate
                    anchors.left: labelsamplerate.right
                    anchors.leftMargin: 20
                    text: samplerate
                }
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelprenum.width + txtprenum.width + 20
                height: labelprenum.height
                Label{
                    id:labelprenum
                    text: qsTr("prenum:")
                }
                Label {
                    id: txtprenum
                    anchors.left: labelprenum.right
                    anchors.leftMargin: 20
                    text: prenum
                }
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelbitwidth.width + txtbitwidth.width + 20
                height: labelbitwidth.height
                Label{
                    id:labelbitwidth
                    text: qsTr("bitwidth:")
                }
                Label {
                    id: txtbitwidth
                    anchors.left: labelbitwidth.right
                    anchors.leftMargin: 20
                    text: bitwidth
                }
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                width: labelsoundmode.width + txtsoundmode.width + 20
                height: labelsoundmode.height
                Label{
                    id:labelsoundmode
                    text: qsTr("soundmode:")
                }
                Label {
                    id: txtsoundmode
                    anchors.left: labelsoundmode.right
                    anchors.leftMargin: 20
                    text: soundmode
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
