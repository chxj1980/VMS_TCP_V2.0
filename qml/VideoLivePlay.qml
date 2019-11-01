import QtQuick 2.0
import XVideo 1.0
import QtQuick.Controls 1.4
import QtQuick 2.12
import QtQuick.Controls 2.12
Rectangle {
    id:root

    signal doubleClick(bool isFullScreen);
    signal click();
    signal s_showToastMsg(string str)
    signal s_deleteObject()
    signal s_mediaInfo(var map)
    signal s_deviceInfo(var map)

    property string mip: ""
    property string mport: ""
    property string mID: ""
    property string mAcc: ""
    property string mPwd: ""
    property bool mIsUpdateFinished: false
    property bool mIsPlayAudio: false
    property bool mIsSelected: false
    property bool mIsRecordVedio: false
    property bool mIsShowWait: false


    //qrc:/images/mediaInfo.png qrc:/images/deviceInfo.png

    border.color: mIsSelected?"red":"white"
    border.width: 2
    onMIsPlayAudioChanged: if(mIsPlayAudio)video.funPlayAudio(mXVideoPlayAudio)
    Menu {
        id: menu1

        property var pathMapping : {"device infomation":"qrc:/images/deviceInfo.png","media infomation":"qrc:/images/mediaInfo.png"}

        Action { text: qsTr("device infomation"); checkable: true }
        Action { text: qsTr("media infomation"); checkable: true; checked: true }
        //        Action { text: qsTr("about"); checkable: true; checked: true }
        //        Action { text: qsTr("help"); checkable: true; checked: true }

        topPadding: 2
        bottomPadding: 2

        delegate: MenuItem {
            id: menuItem
            implicitWidth: 140
            implicitHeight: 40

            indicator: Image {
                id: name1
                anchors.verticalCenter: parent.verticalCenter
                width: 24
                height: 24
                source: strToimg(menuItem.text)
            }

            contentItem: Text {
                leftPadding: menuItem.indicator.width
                rightPadding: menuItem.arrow.width
                text: menuItem.text
                font.pixelSize: 10
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
                color: menuItem.highlighted ? "#8a8a8a" : "transparent"
            }

            onTriggered: {

                if(menuItem.text === "device infomation")
                    s_deviceInfo(video.deviceInfo)
                else if(menuItem.text === "media infomation")
                    s_mediaInfo(video.mediaInfo)
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

    XVideo{
        id:video
        anchors.fill: parent
        anchors.margins: 2
        shotScreenPath:systemAttributes.screenshotFilePath
        recordScreenPath:systemAttributes.recordVedioFilePath

        onShotScreenPathChanged:funSetShotScrennFilePath(recordScreenPath);

        onRecordScreenPathChanged:funSetRecordingFilePath(recordScreenPath)

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents:true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked:{

                if (mouse.button == Qt.RightButton) { // 右键菜单

                    if(!mIsUpdateFinished)
                        return
                    menu1.x = root.x
                    menu1.y = root.y
                    menu1.popup();

                }else if(mouse.button == Qt.LeftButton)
                    click();
            }

            onDoubleClicked: doubleClick(true);
        }

        Image {
            id: img_delete
            x:parent.x + parent.width - img_delete.width
            visible:  (mIsUpdateFinished && mIsSelected) ? true:false
            source: "qrc:/images/img_delete.png"

            MouseArea{
                anchors.fill: parent
                enabled: true

                onClicked:{

                    mIsUpdateFinished = false
                    mIsShowWait = false;


                }

                onDoubleClicked: {

                }

            }
        }

        Rectangle{
            id:rectRecord
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height > 5*50?50:0
            width: parent.width-8
            visible: mIsUpdateFinished
            opacity: 0

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                    if(mIsSelected)
                        rectRecord.state = "show"
                onExited:
                    if(mIsSelected)
                        rectRecord.state = "hide"
            }

            states: [
                State {
                    name: "show"; PropertyChanges { target: rectRecord; opacity: 1 }
                },
                State {
                    name: "hide"; PropertyChanges { target: rectRecord;  opacity: 0 }
                }]

            transitions: Transition {
                PropertyAnimation  {properties: "opacity"; duration: 600; easing.type: Easing.Linear  }
            }

            //            BorderImage{

            //                id:btnstop

            //                width: 40
            //                height: 40
            //                anchors.left: parent.left
            //                anchors.leftMargin: 30
            //                anchors.verticalCenter: parent.verticalCenter
            //                source: "qrc:/images/stop.png"
            //            }

            BorderImage{
                id:btnRecordVideo
                width: 34
                height: 34
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                source: mIsRecordVedio?"qrc:/images/recordVideo_ing.png":"qrc:/images/recordVideo_start.png"

                MouseArea{
                    anchors.fill: parent
                    enabled: true
                    onClicked:delayFun(500,recordBtnClickFun);
                }
            }

            BorderImage{
                id:btnScreenShot
                width: 34
                height: 34
                anchors.left: btnRecordVideo.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/screenshot.png"

                MouseArea{
                    anchors.fill: parent

                    enabled: true
                    onClicked: delayFun(100,screenShotBtnClick);
                }
            }
        }
        Rectangle{
            id:screenBlack
            anchors.fill: parent
            visible: !mIsUpdateFinished
            color: "black"

            QmlWaitingEllipsis{

                visible: mIsShowWait
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                mNumPt:6
                mStrShow: qsTr("Please wait to get the video")
            }


        }

        Rectangle{
            id:screenShotMask
            anchors.fill: parent
            color: "white"
            opacity: 0

            SequentialAnimation {

                id:animationOpacity
                NumberAnimation { target: screenShotMask; property: "opacity"; to: 0.5; duration: 100 }
                NumberAnimation { target: screenShotMask; property: "opacity"; to: 0; duration: 100 }
            }
            function startAnimation(){
                animationOpacity.start();
            }
        }


        onSignal_loginStatus: {


            s_showToastMsg(msg);

        }

        onSignal_videoDataUpdate: {

            console.debug("onSignal_videoDataUpdate"+isSucc)

            if(isSucc){

                mIsUpdateFinished = true
                mIsShowWait = false;

            }else{

            }
        }
    }



    Timer{
        id:delayTimer

        triggeredOnStart:false

        repeat:false

        function setTimeOut(delayTime,fun){
            timer.interval = delayTime;
            timer.repeat = false;
            timer.triggered.connect(fun);
            timer.triggered.connect(function release(){
                timer.triggered.disconnect(fun);
                timer.triggered.disconnect(release);
            })
            timer.start();
        }
    }



    function delayFun(delay,fun1){


        delayTimer.setTimeOut(delay,fun1)

    }


    function recordBtnClickFun(){


        console.debug("recordBtnClickFun        ----"+mIsRecordVedio)
        if(!mIsRecordVedio){

            s_showToastMsg("start record");
            mIsRecordVedio = true;

        }else{
            s_showToastMsg("end record");
            mIsRecordVedio = false;

        }

        video.funRecordVedio(mIsRecordVedio);
    }

    function screenShotBtnClick(){

        screenShotMask.startAnimation();
        video.funScreenShot();
    }

    function updatePar(){

        mIsShowWait = true;
        mIsUpdateFinished = false


        video.funUpdateTcpPar(mip,mport,mAcc,mPwd,mID)

        //        delayFun(5000,function f(){

        //            if(mIsUpdateFinished == false){

        //                mIsShowWait = false;
        //                s_showToastMsg("wait timeout");
        //            }
        //        })

    }
}



