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
                onClicked: {
                    delta = 0
                    pageStack.push(Qt.resolvedUrl("MainPage.qml"))
                }
            }
        }

        Button {
            id: back
            x: 80
            y: 80
            width: 100
            height: 10
            text: " < "
            onClicked: {
                selectAllDates()
                if (mDates.length - 2 - delta >= 0) {
                    pageStack.push(Qt.resolvedUrl("HistoryPage.qml"))
                    delta += 1
                    currentDate = mDates[mDates.length - 1 - delta]
                    getCurValues()
                    l_d.text = currentDate
                    l_m.text = "Вес: " + getMass()
                }
            }
        }
        Button {
            id: forward
            x: parent.width - 150
            y: 80
            width: 100
            height: 10
            text: " > "
            onClicked: {
                selectAllDates()
                if (delta === 1) {
                    pageStack.push(Qt.resolvedUrl("MainPage.qml"))
                    delta -= 1
                    currentDate = mDates[mDates.length - 1 - delta]
                } else {
                    pageStack.push(Qt.resolvedUrl("HistoryPage.qml"))
                    delta -= 1
                    currentDate = mDates[mDates.length - 1 - delta]
                    getCurValues()
                    l_d.text = currentDate
                    l_m.text = "Вес: " + getMass()
                }
            }
        }
        contentHeight: column.height
        Column {
            id: column
            anchors.horizontalCenter: parent.horizontalCenter
            y: 60
            spacing: 50
            Label {
                id: l_d
                text:currentDate
            }
            Label {
                id: l_m
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
                text:"Вес: " + getMass()
            }
        }
        Column {
            x: 20
            y: 300
            spacing: 30
            Item {
                id: container1
                width: 700
                height: 80
                property string curColor: "green"
                property real progress
                progress: (currentProteins < normProteins)? (currentProteins / normProteins) : 1
                Rectangle { anchors.fill: parent; color: "black"; opacity: 0.5 }
                Rectangle {
                    id: fill1; color: getColor(container1.progress); height: container1.height
                    width: container1.width * container1.progress
                }
                Text {
                    font.pixelSize: 40
                    font.bold: true
                    anchors.centerIn: parent
                    text:"Белки: " + (currentProteins).toFixed(2) + "  /" + normProteins
                    color: "white"
                }
            }
            Item {
                id: container2
                width: 700
                height: 80
                property real progress
                progress: (currentFats < normFats)? (currentFats / normFats) : 1
                Behavior on opacity { NumberAnimation { duration: 600 } }
                Rectangle { anchors.fill: parent; color: "black"; opacity: 0.5 }
                Rectangle {
                    id: fill2; color: getColor(container2.progress); height: container2.height
                    width: container2.width * container2.progress
                }
                Text {
                    font.pixelSize: 40
                    font.bold: true
                    anchors.centerIn: parent
                    text:"Жиры: " + (currentFats).toFixed(2) + "  /" + normFats
                    color: "white"
                }
            }
            Item {
                id: container3
                width: 700
                height: 80
                property real progress
                progress: (currentCarbohydrates < normCarbohydrates)? (currentCarbohydrates / normCarbohydrates) : 1
                Behavior on opacity { NumberAnimation { duration: 600 } }
                Rectangle { anchors.fill: parent; color: "black"; opacity: 0.5 }
                Rectangle {
                    id: fill3; color: getColor(container3.progress); height: container3.height
                    width: container3.width * container3.progress
                }
                Text {
                    font.pixelSize: 40
                    font.bold: true
                    anchors.centerIn: parent
                    text:"Углеводы: " + (currentCarbohydrates).toFixed(2) + "  /" + normCarbohydrates
                    color: "white"
                }
            }
            Item {
                id: container4
                width: 700
                height: 80
                property real progress
                progress: (currentCalorie < normCalorie)? (currentCalorie / normCalorie) : 1
                Behavior on opacity { NumberAnimation { duration: 600 } }
                Rectangle { anchors.fill: parent; color: "black"; opacity: 0.5 }
                Rectangle {
                    id: fill4; color: getColor(container4.progress); height: container4.height
                    width: container4.width * container4.progress
                }
                Text {
                    font.pixelSize: 40
                    font.bold: true
                    anchors.centerIn: parent
                    text:"Калории: " + (currentCalorie).toFixed(2) + "  /" + normCalorie
                    color: "white"
                }
            }
        }
    }
}
