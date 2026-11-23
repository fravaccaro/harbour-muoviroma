# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

TARGET = harbour-muoviroma
# Thanks, kimmoli! For future reference: https://github.com/kimmoli/test5-app/blob/master/test5.pro
TEMPLATE = aux

qml.files = qml/*

qml.path = /usr/share/harbour-jollait/qml

desktop.files = harbour-jollait.desktop
desktop.path = /usr/share/applications

appicons.path = /usr/share/icons/hicolor/
appicons.files = appicons/*

OTHER_FILES += \
    qml/harbour-muoviroma.qml \
    qml/pages/AboutPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/LinksPage.qml \
    qml/components/BackgroundRectangle.qml \
    qml/components/BusyState.qml \
    qml/components/LabelText.qml \
    qml/components/dockedbar/DockedBar.qml \
    qml/cover/CoverPage.qml \
    qml/pages/appinfo.png \
    rpm/harbour-muoviroma.spec \
    rpm/harbour-muoviroma.changes \
    harbour-muoviroma.desktop \
    harbour-muoviroma.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n link_pkgconfig

# Required to use the Gecko-based Sailfish WebView:
# https://sailfishos.org/develop/docs/sailfish-components-webview/
PKGCONFIG += qt5embedwidget

TRANSLATIONS += translations/*.ts

INSTALLS += appicons qml desktop
