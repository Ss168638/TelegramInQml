import QtQuick 2.0

Rectangle {
    id: leftScreen

    anchors{
        top: topBar.bottom
        left: parent.left
        bottom: parent.bottom
    }

    width: parent.width * 1/3
    color: "#17212b"

}
