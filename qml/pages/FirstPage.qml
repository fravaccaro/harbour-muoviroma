/*
  Copyright (C) 2016 jollailija
  Contact: jollailija <jollailija@gmail.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * The names of the contributors may not be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import Sailfish.WebView 1.0
import Sailfish.WebView.Popups 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    BookmarkPage {id: bookmarkPage} // just don't. I know it's wrong, but the freaking bug won't die!

    property alias webView: webViewFlickable.webView

    readonly property string devicePixelRatioHack: "if (!window.location.origin) window.location.origin = window.location.protocol+'//'+window.location.host;"
        + "var meta = document.querySelector('meta[name=viewport]');"
        + "if (!meta) return;"
        + "if (screen.width <= 540) meta.setAttribute('content', 'width=device-width/1.5, initial-scale='+(1.5));"
        + "else if (screen.width > 540 && screen.width <= 768) meta.setAttribute('content', 'width=device-width/2.0, initial-scale='+(2.0));"
        + "else if (screen.width > 768) meta.setAttribute('content', 'width=device-width/3.0, initial-scale='+(3.0));"

    Timer {
        id: timer
        interval: 120000
        repeat: true
        onTriggered: pageStack.replace('IdlePage.qml')
    }

    Connections {
        target: Qt.application
        onActiveChanged: {
            if (!Qt.application.active) {
                timer.restart()
            } else {
                timer.stop()
            }
        }
    }

    WebViewFlickable {
        id: webViewFlickable
        anchors {
            fill: parent
            bottomMargin: navPanel.visibleSize
        }

        PullDownMenu {
            MenuLabel {
                text: qsTr("muoviroma WebView") + " 0.6.0"
            }
            MenuItem {
                text: qsTr("Web App")
                onClicked: {
                    webView.url = "https://romamobile.it/percorso/js/?hl=it#htm-0"
                }
            }
            MenuItem {
                text: navPanel.open ? qsTr("Hide navigation bar")
                                : qsTr("Open navigation bar")
                onClicked: {
                    navPanel.open ? navPanel.open = false : navPanel.open = true
                }
            }
        }

        webView.url: "http://muovi.roma.it/percorso/js/"
        webView.popupProvider: PopupProvider {
            passwordManagerPopup: null
        }
        webView.onLoadingChanged: {
            if (!webView.loading) {
                webView.runJavaScript(devicePixelRatioHack)
            }
        }
    }

    DockedPanel {
        id: navPanel
        dock: Dock.Bottom
        width: parent.width
        height: navRow.height + Theme.paddingMedium
        open: true // todo: open and close on scroll
        _immediate: true // no lag when opening or closing

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.backgroundColor, 0.88)
            z: -1
        }

        Row {
            id: navRow
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                leftMargin: Theme.paddingLarge
                rightMargin: Theme.paddingLarge
            }
            spacing: Theme.paddingMedium
            IconButton {
                icon.source: "image://theme/icon-m-back"
                onClicked: webView.goBack()
                enabled: webView.canGoBack
            }
            IconButton {
                icon.source: "image://theme/icon-m-refresh"
                onClicked: webView.reload()
            }
            IconButton {
                icon.source: "image://theme/icon-m-train"
                onClicked: webView.url = "https://romamobile.it/percorso/js/?hl=it#htm-0"
            }
            IconButton {
                icon.source: "image://theme/icon-m-favorite"
                onClicked: pageStack.push(bookmarkPage, {"name": webView.title, "url": webView.url})
            }
            IconButton {
                icon.source: "image://theme/icon-m-forward"
                onClicked: webView.goForward()
                enabled: webView.canGoForward
            }
        }
    }
}
