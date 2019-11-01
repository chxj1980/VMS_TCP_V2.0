import QtQuick 2.0
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.4
Popup {
    id: root
    x: parent.width/2 - root.width/2
    y: parent.height/2 - root.height/2
    width: 344
    height: 345
    modal: true
    focus: true
    //设置窗口关闭方式为按“Esc”键关闭
    closePolicy: Popup.NoAutoClose
    //设置窗口的背景控件，不设置的话Popup的边框会显示出来
    background: rect

    signal s_modifyPwd(string newpwd1,string oldpwd1)

    signal s_showToast(var str1)

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "white"

        radius: 8

        Rectangle{
            width: parent.width-4
            height: 2
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.left: parent.left
            color: "#e6e6e6"
            anchors.leftMargin: 2
            radius: 8
        }

        //设置标题栏区域为拖拽区域
        Rectangle{
            id:rectTitle
            width: parent.width
            height: 50
            color: "#476BFD"
            anchors.top: parent.top
            Image {
                id: img
                width: 32
                height: 32
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/modifyPwd.png"
            }

            Text {
                id:title
                text: qsTr("modify password")
                anchors.left: img.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
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

            Image {
                id: img1
                width: 32
                height: 32
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                source: "qrc:/images/wClose.png"

                MouseArea{
                    anchors.fill: parent
                    onClicked: root.close();
                }
            }
        }


        Column{
            id:txtInput
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: rectTitle.bottom
            anchors.topMargin: 15
            spacing: 10

            Text {
                id: txtOldPwd
                color: "#9B9B9B"
                text: qsTr("old password:")
            }
            TextField {

                id:input1
                width: 270
                height: 34
                placeholderText: qsTr("enter old password")
                text:""
            }
            Text {
                id: txtnewPwd
                color: "#9B9B9B"
                text: qsTr("new password:")
            }

            TextField {

                id:input2
                width: 270
                height: 34
                placeholderText: qsTr("enter new password")
            }

            Text {
                id: txtpwdConfirm
                color: "#9B9B9B"
                text: qsTr("confirm:")
            }
            TextField {

                id:input3
                width: 270
                height: 34
                placeholderText: qsTr("enter new password")
            }
        }

        QmlButton {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100
            height: 40
            text: qsTr("ok")
            onClicked: {

                var oldpwd = input1.text.replace(/ /g,"").toString();
                var newpwd = input2.text.replace(/ /g,"").toString();
                var newpwdConfirm = input3.text.replace(/ /g,"").toString();

                if(oldpwd == "" || newpwd == ""|| newpwdConfirm == ""){

                    tip.type = 1;
                    tip.str = qsTr("Input can not be empty")
                    tip.open();
                    return;
                }


                if(newpwd !== newpwdConfirm){
                    tip.type = 1;
                    tip.str = qsTr("Inconsistent input password")
                    tip.open();
                    return;
                }
                s_modifyPwd(oldpwd,newpwd)

            }
        }


        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 4
            verticalOffset: 4
            color:"#80000000"
        }
    }

    QmlDialogTip{
        id:tip

    }

    function modifyCallback(isSuc,str){

        if(isSuc){
            tip.type = 0
            tip.str = str
            tip.open();
            root.close();
        }else{
            tip.type = 1
            tip.str = str
            tip.open();

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

