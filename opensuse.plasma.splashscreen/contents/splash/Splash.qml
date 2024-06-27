import QtQuick
import org.kde.kirigami 2 as Kirigami

Rectangle {
    id: root
    color: "black"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Image {
            id: logo
            readonly property real size: Kirigami.Units.gridUnit * 8
            anchors.centerIn: parent
            asynchronous: true
            source: "images/opensuse.svg"
        }

        Image {
            id: busyIndicator
            y: parent.height - (parent.height - logo.y) / 2 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            source: "images/busywidget.svg"
            sourceSize.height: Kirigami.Units.gridUnit * 3
            sourceSize.width: Kirigami.Units.gridUnit * 3
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 800
                loops: Animation.Infinite
                running: Kirigami.Units.longDuration > 1
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: Kirigami.Units.veryLongDuration * 2
        easing.type: Easing.InOutQuad
    }
}
