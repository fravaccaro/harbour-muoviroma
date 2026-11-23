import "../components"
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutpage

    function handleKeyPressed(event) {
        if (event.key === Qt.Key_Down) {
            flickable.flick(0, -aboutpage.height);
            event.accepted = true;
        }
        if (event.key === Qt.Key_Up) {
            flickable.flick(0, aboutpage.height);
            event.accepted = true;
        }
        if (event.key === Qt.Key_PageDown) {
            flickable.scrollToBottom();
            event.accepted = true;
        }
        if (event.key === Qt.Key_PageUp) {
            flickable.scrollToTop();
            event.accepted = true;
        }
        if (event.key === Qt.Key_B) {
            pageStack.navigateBack();
            event.accepted = true;
        }
    }

    focus: true
    anchors.bottomMargin: Theme.paddingLarge
    Keys.onPressed: {
        handleKeyPressed(event);
    }

    SilicaFlickable {
        id: flickable

        anchors.fill: parent
        contentHeight: content.height

        Column {
            id: content

            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader {
                title: qsTr("About")
            }

            Item {
                height: appicon.height + Theme.paddingMedium
                width: parent.width

                Image {
                    id: appicon

                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "./appinfo.png"
                }

            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.highlightColor
                text: "muoviroma"
            }

            LabelText {
                text: qsTr("This app is a lightweight web wrapper providing fast, streamlined access to romamobile.it right from your device, designed for quick, on-the-go checks of Rome's public transit news and updates.")
            }

            LabelText {
                text: qsTr("Released under the <a href='https://www.gnu.org/licenses/gpl-3.0'>GNU GPLv3</a> license.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Sources")
                onClicked: Qt.openUrlExternally("https://github.com/fravaccaro/harbour-muoviroma")
            }

            SectionHeader {
                text: qsTr("Support")
            }

            LabelText {
                text: qsTr("If you like my work and want to buy me a beer, feel free to do it!")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Donate")
                onClicked: Qt.openUrlExternally("https://liberapay.com/fravaccaro")
            }

            SectionHeader {
                text: qsTr("Credits")
            }

            LabelText {
                text: qsTr("This is an independent, community-made app and is not officially affiliated with romamobile.it, ATAC, or Roma Servizi per la Mobilità.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Sources")
                onClicked: Qt.openUrlExternally("https://github.com/lallulli/romamobile")
            }

            LabelText {
                text: qsTr("Based on <a href='https://github.com/jollailija/junatnet'>Junat.net WebView</a> by jollailija.")
            }

            Item {
                width: 1
                height: Theme.paddingLarge
            }

        }

        VerticalScrollDecorator {
        }

    }

}
