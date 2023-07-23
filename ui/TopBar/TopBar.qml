import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQml 2.12

Rectangle {
    id: topBar

    //signals
    signal resizeWindow()
    signal minimizeWindow()


    anchors{
        top: parent.top
        left: parent.left
        right: parent.right
    }
    color: "#1f2936"
    height: parent.height / 28

    CustomButton{
        id: closeButton
        anchors{
            top: parent.top
            right: parent.right
        }

        imageUrl: "qrc:/ui/assests/cross_white.png"
        width: 20
        height: parent.height
        hoverEnable: false

        HoverHandler{
            id: hoverHandler
            acceptedDevices: PointerDevice.mouse
        }

        states:[
            State{
                name: "hovered"
                when: hoverHandler.hovered
                PropertyChanges{
                    target: closeButton
                    color: "red"
                    imageUrl: "qrc:/ui/assests/cross_gray.png"
                }
            }
        ]

        onClicked: Qt.quit()
    }

    CustomButton{
        id: maxMinButton

        anchors{
            top: parent.top
            right: closeButton.left
        }

        width: 20
        height: parent.height
        hoverEnable: true
        imageUrl: "qrc:/ui/assests/maximize_gray.png"

        state: "Windowed"
        states: [
            State{
                name: "maximized"
                PropertyChanges {
                    target: maxMinButton
                    imageUrl: "qrc:/ui/assests/mimimize_gray.png"
                }
            },
            State{
                name: "Windowed"
                PropertyChanges{
                    target: maxMinButton
                    imageUrl: "qrc:/ui/assests/maximize_gray.png"
                }
            }

        ]
        onClicked: {
            resizeWindow()
            state = (state === "maximized") ? state = "Windowed" : state = "maximized"
        }

        onHoverStarted: {
            maxMinButton.color = "gray"
        }

        onHoverStoped: {
            maxMinButton.color = "transparent"
        }


    }


    CustomButton{
        id: minimizeButton
        anchors{
            top: parent.top
            right: maxMinButton.left
        }

        width: 20
        height: parent.height
        hoverEnable: true
        imageUrl: "qrc:/ui/assests/hide_gray.png"

        onClicked: minimizeWindow()

        onHoverStarted: {
            minimizeButton.color = "gray"
        }

        onHoverStoped: {
            minimizeButton.color = "transparent"
        }
    }

    MouseArea{
        id: iMouseArea
        property int prevX: 0
        property int prevY: 0
        anchors{
            top: parent.top
            left: parent.left
            right: minimizeButton.left
        }
        height: parent.height

        onPressed: {prevX=mouse.x; prevY=mouse.y}
        onPositionChanged:{
            var deltaX = mouse.x - prevX;
            root.x += deltaX;
            prevX = mouse.x - deltaX;

            var deltaY = mouse.y - prevY
            root.y += deltaY;
            prevY = mouse.y - deltaY;
        }
    }
}
