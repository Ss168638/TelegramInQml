import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import MyConversationModel 1.0
import "ui/TopBar"
import "ui/LeftScreen"
import "ui/RightScreen"
import "ui/InfoPage"
import "ui/SettingsPage"

Window {
    id: root
    width: 800
    height: 480
    visible: true
    flags: Qt.FramelessWindowHint |
           Qt.WindowMinimizeButtonHint |
           Qt.WindowFullscreenButtonHint |
           Qt.WindowMaximizeButtonHint |
           Qt.Window
    visibility: Window.Windowed
    title: qsTr("My Telegram App")

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

    SplitView{
        id: splitView
        opacity: 1
        antialiasing: true
        focus: true
        anchors{
            top: topBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        LeftScreen{
            id: leftScreen
            Layout.minimumWidth: 200

        }

        RightScreen{
            id: rightScreen
            Layout.minimumWidth: 300
        }

    }

    InfoPage{
        id: userinfoPage
        visible: false
    }

    SqlConversationModel{
        id: conversationModel
        userName: "User Name"
    }

    CreateGroupPage{
        id: groupCreationPage
        visible: false
    }

    ChannelPage{
        id: channelPage
        visible: false
    }

    ContactsPage{
        id: contactsPage
        visible: false
    }


    Connections{
        target: userinfoPage
        onOpenPage: function(name)
        {
            switch(name)
            {
            case "New Group": groupCreationPage.typeName = name ; groupCreationPage.typeName = name; groupCreationPage.visible = true;  break;
                case "New Channel": channelPage.typeName = name ; channelPage.typeName = name; channelPage.visible = true;  break;
                case "Contacts": contactsPage.visible = true ; break;
                case "Calls": break;
                case "Settings": break;
            }
            root.opacity = 0.99
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
