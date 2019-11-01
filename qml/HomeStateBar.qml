import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 2.1
import TimeLine 1.0
Rectangle{
    id:stateBar

    property int isRecord: 0

    property int multiScreenNum: 2//2：代表2X2
    color: "white"

    signal s_multiScreenNumChange(var num);


    onMultiScreenNumChanged: {
        //console.debug("home stateBar 屏幕发生变化:"+multiScreenNum);
        s_multiScreenNumChange(multiScreenNum)

        bar.setSelectItem(multiScreenNum-1);
    }


//    QmlImageButton{
//        id:btnFullScreen


//        width: 36
//        height: 36
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.right: parent.right
//        anchors.rightMargin: 20
//        imgSourseNormal: "qrc:/images/fullscreen.png"
//        imgSourseHover: "qrc:/images/fullscreen_enter.png"
//        imgSoursePress: "qrc:/images/fullscreen_enter.png"
//    }



    QmlImageTarBar{
        id: bar
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 30

        Component.onCompleted: {
            myModel.append({ "modelSrc": "qrc:/images/screen1.png", "modelSrcHover": "qrc:/images/screen1_enter.png", "modelSrcPress": "qrc:/images/screen1_select.png"})
            myModel.append({ "modelSrc": "qrc:/images/screen4.png", "modelSrcHover": "qrc:/images/screen4_enter.png", "modelSrcPress": "qrc:/images/screen4_select.png"})
            myModel.append({ "modelSrc": "qrc:/images/screen9.png", "modelSrcHover": "qrc:/images/screen9_enter.png", "modelSrcPress": "qrc:/images/screen9_select.png"})
            myModel.append({ "modelSrc": "qrc:/images/screen16.png", "modelSrcHover": "qrc:/images/screen16_enter.png", "modelSrcPress": "qrc:/images/screen16_select.png"})
            //  myModel.append({ "modelSrc": "qrc:/images/screenMultiBig.png", "modelSrcHover": "qrc:/images/screenMultiBig_enter.png", "modelSrcPress": "qrc:/images/screenMultiBig_select.png"})

            bar.setSelectItem(multiScreenNum-1);
        }

        onCurrentIndexChanged: {

            //console.debug("onCurrentIndexChanged   " + currentIndex)


            multiScreenNum = currentIndex+1;


            // multiScreen(currentIndex + 1);

        }

    }






//    Slider {
//        id: voiveSlider
//        value: 0.5
//        anchors.right: parent.right
//        anchors.rightMargin: 376
//        anchors.verticalCenter: parent.verticalCenter
//        background: Rectangle {
//            x: voiveSlider.leftPadding
//            y: voiveSlider.topPadding + voiveSlider.availableHeight / 2 - height / 2
//            implicitWidth: 100
//            implicitHeight: 4
//            width: voiveSlider.availableWidth
//            height: implicitHeight
//            radius: 2
//            color: "#EEEEEE"

//            Rectangle {
//                width: voiveSlider.visualPosition * parent.width
//                height: parent.height
//                color: "#476BFD"
//                radius: 2
//            }
//        }

//        handle: Rectangle {
//            x: voiveSlider.leftPadding + voiveSlider.visualPosition * (voiveSlider.availableWidth - width)
//            y: voiveSlider.topPadding + voiveSlider.availableHeight / 2 - height / 2
//            implicitWidth: 10
//            implicitHeight: 10
//            radius: 13
//            color: voiveSlider.pressed ? "#efefef" : "#FFFFFF"
//            border.color: "#BDBDBD"
//        }
//    }


//    QmlImageButton{
//        width: 34
//        height: 34
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.right: voiveSlider.left
//        anchors.rightMargin: 5
//        imgSourseNormal: "qrc:/images/voice.png"
//        imgSourseHover: "qrc:/images/voice.png"
//        imgSoursePress: "qrc:/images/voice.png"
//    }

    Rectangle{
        id:rectTimeline
        anchors.right: bar.left
        width: parent.width - bar.width - 300
        height: parent.height*2/3

        TimeLine{

            id:timeline
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width -20
            height: parent.height


            onWidthChanged: {
                console.debug("onWidthChanged   "+timeline.height)

                setCoordinateOriginX(0)
                setCoordinateOriginY(timeline.height)

            }
            onHeightChanged: {

                setScalePixHeight((height-20),(height-20)/2,(height-20)/4)
            }

            Component.onCompleted: {


                console.debug("onWidthChanged   "+timeline.height)
                var timeperPix = timeline.width/24*3600
                setUnitScale(timeperPix)

            }

        }
    }





    function setSelectItem(multiScreenNum){
        bar.setSelectItem(multiScreenNum-1);
    }



}
