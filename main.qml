import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml 2.12
import "ui/TopBar"
import "ui/LeftScreen"
import "ui/RightScreen"

Window {
    id: root
    width: 640
    height: 480
    x: 200
    y: 20
    visible: true
    flags: Qt.FramelessWindowHint |
           Qt.WindowMinimizeButtonHint |
           Qt.WindowFullscreenButtonHint |
           Qt.WindowMaximizeButtonHint |
           Qt.Window
    visibility: Window.Windowed
    title: qsTr("My Telegram App")

//    property string leftScreenMenuColor: "#17212b"

    Connections{
        target: topBar
        id: resizeWindowConenction
        onResizeWindow: function(){
            if(root.visibility === Window.Windowed) { root.visibility = Window.Maximized }
            else if(root.visibility === Window.Maximized) { root.visibility = Window.Windowed }
        }
        onMinimizeWindow: root.visibility = Window.Minimized
    }

    TopBar{
        id: topBar
    }
    LeftScreen{
        id: leftScreen
    }

    RightScreen{
        id: rightScreen
    }
}
