import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls 2.12
import Qt.labs.platform 1.1
import QtQuick 2.12
import QtQuick.Controls 2.12
Rectangle {

    id:root


    property bool isPress: false
    property string versionStr: "V-0-0-0"

    signal winMin();
    signal winMax();
    signal winClose();
    signal dragPosChange(var mx,var my);

    signal s_systemConfiguration();
    signal s_exit();
    signal s_about();
    signal s_help();

    property var pathMapping : {"system Configuration":"qrc:/images/systemConfig.png","exit system":"qrc:/images/exit.png","about":"qrc:/images/about.png","help":"qrc:/images/help.png"}

    Rectangle {
        anchors.fill: parent

        color: "#476BFD"
        Image {
            id: namew
            width: 130
            height: 22
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/images/iEagleCam.png"
        }

        Label{
            anchors.top: namew.bottom
            anchors.left: parent.left
            anchors.leftMargin: 25+130/2

            font.family: "arial"
            font.pointSize: 10
            color: "white"
            font.italic:true
            font.bold: true
            text: versionStr
        }


        MouseArea {
            id:mousearea
            property point clickPoint: "0,0"

            anchors.fill: parent
            acceptedButtons: Qt.LeftButton

            onPressed: {
                clickPoint  = Qt.point(mouse.x, mouse.y)
            }
            //双击过程会出现拖拉事件，导致窗口最大化到还原过程出现bug,因此禁掉
            //            onDoubleClicked: {
            //                enabled = false;
            //                winMax();
            //                enabled = true;

            //            }
            onPositionChanged: {

                var offset = Qt.point(mouse.x - clickPoint.x, mouse.y - clickPoint.y)

                dragPosChange(offset.x, offset.y)
            }
        }


        Row{

            anchors.right: windowAdjust.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            QmlImageButton{
                width: 36
                height: 36
                imgSourseHover: "qrc:/images/flush_enter.png"
                imgSourseNormal: "qrc:/images/flush.png"
                imgSoursePress: "qrc:/images/flush_enter.png"

            }
            QmlImageButton{
                width: 36
                height: 36
                imgSourseHover: "qrc:/images/msg_enter.png"
                imgSourseNormal: "qrc:/images/msg.png"
                imgSoursePress: "qrc:/images/msg_enter.png"

            }
            QmlImageButton{
                id:menuSys
                width: 36
                height: 36
                imgSourseHover: "qrc:/images/menu_enter.png"
                imgSourseNormal: "qrc:/images/menu.png"
                imgSoursePress: "qrc:/images/menu_enter.png"
                onClick: {
                    menu1.visible = true


                }
            }


            Menu {
                id: menu1
                x:menuSys.x + menuSys.width/2 - menu1.width/2
                y:menuSys.y+menuSys.height

                Action { text: qsTr("system Configuration"); checkable: true }
                Action { text: qsTr("about"); checkable: true; checked: true }
                Action { text: qsTr("help"); checkable: true; checked: true }
                Action { text: qsTr("exit system"); checkable: true; checked: true }


                topPadding: 2
                bottomPadding: 2

                delegate: MenuItem {
                    id: menuItem
                    implicitWidth: 140
                    implicitHeight: 40

                    indicator: Image {
                        id: name1
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 32
                        source: strToimg(menuItem.text)
                    }

                    contentItem: Text {
                        leftPadding: menuItem.indicator.width
                        rightPadding: menuItem.arrow.width
                        text: menuItem.text
                        font.pixelSize: 12
                        font.family: "PingFang-SC-Medium"
                        opacity: enabled ? 1.0 : 0.3
                        color: menuItem.highlighted ? "#ffffff" : "#000000"
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        implicitWidth: 140
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        color: menuItem.highlighted ? "#17abe3" : "transparent"
                    }

                    onTriggered: {

                        if(menuItem.text === "system Configuration")
                            s_systemConfiguration()
                        else if(menuItem.text === "exit system")
                            s_exit();

                    }
                }
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 40
                    color: "#ffffff"
                    //border.color: "#7dc5eb"
                    radius: 2
                }


            }

            Rectangle{
                width: 1
                height: 30
                color: "#4A4A4A"
            }


        }




        Row{
            id:windowAdjust
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing:10
            QmlImageButton{
                width: 36
                height: 36
                imgSourseHover: "qrc:/images/wMin_enter.png"
                imgSourseNormal: "qrc:/images/wMin.png"
                imgSoursePress: "qrc:/images/wMin_enter.png"
                onClick:winMin()
            }
            QmlImageButton{
                width: 36
                height: 36
                imgSourseHover: "qrc:/images/wMax_enter.png"
                imgSourseNormal: "qrc:/images/wMax.png"
                imgSoursePress: "qrc:/images/wMax_enter.png"
                onClick:winMax()

            }
            QmlImageButton{
                width: 36
                height: 36
                imgSourseHover: "qrc:/images/wClose_enter.png"
                imgSourseNormal: "qrc:/images/wClose.png"
                imgSoursePress: "qrc:/images/wClose_enter.png"
                onClick:winClose()


            }

        }

    }


    function strToimg(str){

        return pathMapping[str]

    }

}
