import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
Rectangle {

    id:root
    visible: false



    ConfigTabbar{
        id: bar
        height: parent.height
        width: 300
        color:"#bfbfbf"
        z:1
        Component.onCompleted: {
            myModel.append({ "modelText": qsTr("General configuration"), "modelColor": "#000000", "modelColorG": "#476BFD", "modelSrc": "qrc:/images/config_common.png", "modelSrcG": "qrc:/images/config_common_g.png"})
            myModel.append({ "modelText": qsTr("Local configuration"), "modelColor": "#000000", "modelColorG": "#476BFD", "modelSrc": "qrc:/images/config_location.png", "modelSrcG": "qrc:/images/config_location_g.png"})
        }
    }

    SwipeView {
        id: view
        z:0
        height: parent.height
        width: parent.width - bar.width
        anchors.left: bar.right
        currentIndex: bar.currentIndex

        ConfigGeneral{
            id:configerneral


        }

        ConfigVedio{

        }
    }

    QmlButton{
        id:btnCancel
        width: 100
        height: 40
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 30
        anchors.rightMargin: 30
        text: qsTr("cancel")
        onClicked: root.visible = false
    }
    QmlButton{
        id:btnSave
        width: 100
        height: 40
        anchors.right: btnCancel.left
        anchors.bottom: btnCancel.bottom
        anchors.rightMargin: 20
        text: qsTr("save")
        onClicked: {
            root.visible = false
        }
    }



}
