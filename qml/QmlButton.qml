import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Button{

    property color colorNor: "#476BFD"
    property color colorPressed:"#aa476BFD"
    property int mRadius: 10
    style:ButtonStyle{

        background: Rectangle {
            width: 360
            height: 50
            radius: mRadius
            color: control.pressed?colorPressed:colorNor
        }
        label: Text {
            id: txt
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text:control.text
            color: "#ffffff"
        }

    }

}
