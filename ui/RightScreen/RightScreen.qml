import QtQuick 2.0

Rectangle{
    id: rightScreen

    anchors{
        top: topBar.bottom
        right: parent.right
        bottom: parent.bottom
    }

    width: parent.width * 2/3
    color: "#0e1621"
}
