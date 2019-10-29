import QtQuick 2.12
import QtQuick.Controls 2.12

SpinBox {
    id: control

    property color myColor: "#476BFD"
    value: 50
    editable: true


    contentItem: TextInput {
        z: 2
        text: control.textFromValue(control.value, control.locale)

        font: control.font
        color: myColor
        selectionColor: myColor
        selectedTextColor: "#ffffff"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }

    up.indicator: Rectangle {
        x: control.mirrored ? 0 : parent.width - width
        height: parent.height
        implicitWidth: 26
        implicitHeight: 26
        color: control.up.pressed ? "#e4e4e4" : "#f6f6f6"
        border.color: enabled ? myColor : "#bdbebf"

        Text {
            text: "+"
            font.pixelSize: control.font.pixelSize * 2
            color: myColor
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    down.indicator: Rectangle {
        x: control.mirrored ? parent.width - width : 0
        height: parent.height
        implicitWidth: 26
        implicitHeight: 26
        color: control.down.pressed ? "#e4e4e4" : "#f6f6f6"
        border.color: enabled ? myColor : "#bdbebf"

        Text {
            text: "-"
            font.pixelSize: control.font.pixelSize * 2
            color: myColor
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    background: Rectangle {
        implicitWidth: 100
        border.color: "#bdbebf"
    }
}
