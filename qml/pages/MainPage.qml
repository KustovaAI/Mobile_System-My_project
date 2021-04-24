import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        Button {
            id: back
            x: 80
            y: 80
            width: 100
            height: 10
            text: " < "
            onClicked: {
                selectAllDates()
                if (mDates.length >= 1) {
                     pageStack.push(Qt.resolvedUrl("HistoryPage.qml"))
                    delta = 1
                    currentDate = mDates[mDates.length - 1 - delta]
                    getCurValues()
                }
            }
        }
        contentHeight: column.height
        Column {
            id: column
            anchors.left: back.right
            y: 60
            spacing: 50
            Label {
                text:"  Сегодня: " + dateString
            }
            Label {
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
                text:"Ваш вес: " + setting1.value[1]

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
                progress: (setting1.value[2] < normProteins)? (setting1.value[2] / normProteins) : 1
                Rectangle { anchors.fill: parent; color: "black"; opacity: 0.5 }
                Rectangle {
                    id: fill1; color: getColor(container1.progress); height: container1.height
                    width: container1.width * container1.progress
                }
                Text {
                    font.pixelSize: 40
                    font.bold: true
                    anchors.centerIn: parent
                    text:"Белки: " + (setting1.value[2]).toFixed(2) + "  /" + normProteins + " г."
                    color: "white"
                }
            }
            Item {
                id: container2
                width: 700
                height: 80
                property real progress
                progress: (setting1.value[3] < normFats)? (setting1.value[3] / normFats) : 1
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
                    text:"Жиры: " + (setting1.value[3]).toFixed(2) + "  /" + normFats + " г."
                    color: "white"
                }
            }
            Item {
                id: container3
                width: 700
                height: 80
                property real progress
                progress: (setting1.value[4] < normCarbohydrates)? (setting1.value[4] / normCarbohydrates) : 1
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
                    text:"Углеводы: " + (setting1.value[4]).toFixed(2) + "  /" + normCarbohydrates + " г."
                    color: "white"
                }
            }
            Item {
                id: container4
                width: 700
                height: 80
                property real progress
                progress: (setting1.value[5] < normCalorie)? (setting1.value[5] / normCalorie) : 1
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
                    text:"Калории: " + (setting1.value[5]).toFixed(2) + "  /" + normCalorie + " Ккал"
                    color: "white"
                }
            }
        }
        Column {
            y: 900
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 50
            Button {
                text:"Задать вес"
                width: 500
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("SetMassPage.qml"))
                }

            }
            Button {
                width: 500
                text:"Выбрать продукт"
                onClicked: pageStack.push(Qt.resolvedUrl("CategoriesPage.qml"))
            }
            Button {
                width: 500
                text:"Посчитать ИМТ"
                onClicked: pageStack.push(Qt.resolvedUrl("BodyMassIndexPage.qml"))
            }
        }
    }
}
