import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Rectangle {
    property alias myModel: myModel
    property int lastIndex: 0

    property int currentIndex: 0
    id: bar


    ListModel {
        id: myModel
    }

    Repeater {
        id: repeater
        model: myModel

        TabButton {
            property alias imageSource: image.source
            property alias textColor: text.color

            x:0
            y:index * 48
            width: bar.width
            height: 48

            contentItem:Text{
                id: text
                text: modelText
                font.family: "PingFang-SC-Medium"
                font.pixelSize: 14
                font.bold: true
                anchors.left: bg.left
                anchors.leftMargin: 48
                verticalAlignment: Text.AlignVCenter
                color: (model.index === bar.currentIndex) ? modelColorG : modelColor
            }
            background:Rectangle{
                id:bg
                width: bar.width
                height: 48
                color: (index ===currentIndex)?"#ffffff":"transparent"
                Image{
                    id: image
                    width: 32
                    height: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    source: (model.index === bar.currentIndex) ? modelSrcG : modelSrc
                }
            }
            onHoveredChanged: {
                if (model.index !== bar.currentIndex){
                    hovered ? text.color = modelColorG : text.color = modelColor
                    hovered ? image.source = modelSrcG : image.source = modelSrc
                }
            }
            onClicked: {
                currentIndex = index
                repeater.itemAt(bar.lastIndex).imageSource = myModel.get(bar.lastIndex).modelSrc;
                repeater.itemAt(bar.lastIndex).textColor = modelColor;

                image.source = modelSrcG;
                text.color = modelColorG;
                bar.lastIndex = model.index;
            }
        }
    }
}
