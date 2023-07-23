import QtQuick 2.12

Rectangle{
    id: customButton

    //properties
    property string imageUrl: ""
    property bool hoverEnable: false

    //signals
    signal clicked()
    signal hoverStarted()
    signal hoverStoped()


    width: 100
    height: 100

    color: "transparent"

    Image{
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: imageUrl
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onClicked: customButton.clicked()
        hoverEnabled: hoverEnable
        onEntered: customButton.hoverStarted()
        onExited: customButton.hoverStoped()
    }

}
