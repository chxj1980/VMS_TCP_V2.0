import QtQuick 2.0
import QtQuick.Controls 2.5

Popup {
    id: root
    x: parent.width/2 - root.width/2
    y: parent.height/2 - root.height/2
    width: 300
    height: 180
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
            radius: 8
            color: "transparent"
            height: 40
            Image {
                id: img
                width: 32
                height: 32
                anchors.verticalCenter: parent.verticalCenter
                source: type>0?"qrc:/images/error.png":"qrc:/images/warn.png"
            }
            Text {

                text: type>0?"Error":"Warn"
                color: type>0?"red":"#e98f36"
                anchors.left: img.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.family: "PingFang-SC-Medium"
                font.pixelSize: 12
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

        Label {

            anchors.top: rectTitle.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 30
            width: 171
            height: 15
            text: str

        }

        Button {
            text: "ok"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            onClicked: {
                root.close()
            }
        }
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

