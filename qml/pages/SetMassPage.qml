import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Show MainPage")
                onClicked: pageStack.push(Qt.resolvedUrl("MainPage.qml"))
            }
        }
        PageHeader {
            title: qsTr("Установить вес")
        }
        Label {
            id: label1
            anchors.horizontalCenter: parent.horizontalCenter
            y: 200
            text: qsTr("Напишите новый вес")
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
        }
        TextField {
            x: 50
            y: label1.y + 100
            id: textField1
            width: 400
        }
        Label {
            id: label2
            anchors.left: textField1.right
            y: textField1.y
            text: qsTr(" кг.")
            color: Theme.secondaryHighlightColor

        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 600
            text: "OK"
            onClicked: {
                pageStack.push(Qt.resolvedUrl("MainPage.qml"))
                db1.setMass(dateString, parseFloat(textField1.text))
                selectAllNotes()
            }
        }
    }
}
