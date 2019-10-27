import QtQuick 2.0
import XVideo 1.0
import QtQuick.Controls 1.4
Rectangle {

    signal doubleClick(bool isFullScreen);
    signal click();
    signal s_showToastMsg(string str)
    signal s_deleteObject()

    property string mip: ""
    property string mport: ""
    property string mID: ""
    property string mAcc: ""
    property string mPwd: ""
    property bool mIsUpdateStreamData: false
    property bool mIsPlayAudio: false
    property bool mIsSelected: false
    property bool mIsRecordVedio: false
    property bool mIsShowWait: false

    border.color: mIsSelected?"red":"white"
    border.width: 2
    onMIsPlayAudioChanged: if(mIsPlayAudio)video.funPlayAudio(mXVideoPlayAudio)

    XVideo{
        id:video
        anchors.fill: parent
        anchors.margins: 2

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents:true

            onClicked: click();

            onDoubleClicked: doubleClick(true);

        }

        Image {
            id: img_delete
            x:parent.x + parent.width - img_delete.width
            visible:  (mIsUpdateStreamData && mIsSelected) ? true:false
            source: "qrc:/images/img_delete.png"

            MouseArea{
                anchors.fill: parent
                enabled: true

                onClicked:mIsShowWait = false;


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

            visible: mIsUpdateStreamData
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

            BorderImage{

                id:btnstop

                width: 40
                height: 40
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/stop.png"

            }

            BorderImage{
                id:btnRecordVideo
                width: 34
                height: 34
                anchors.left: btnstop.right
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
            visible: !mIsUpdateStreamData
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

            console.debug("onSignal_videoDataUpdate")
            mIsShowWait = false;
            mIsUpdateStreamData = true;
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
        mIsUpdateStreamData = false;
        video.funUpdateTcpPar(mip,mport,mAcc,mPwd,mID)
    }
}



