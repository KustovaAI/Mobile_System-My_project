import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    property real imt: 0
    allowedOrientations: Orientation.All
    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Show MainPage")
                onClicked: pageStack.push(Qt.resolvedUrl("MainPage.qml"))
            }
        }
        PageHeader { title: "Расчёт индекса массы тела" }

        Label {
            id: label_1
            y: 150
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Введите свой вес: "
        }
        TextField {
            id: textField1
            y: label_1.y + 60
            placeholderText : "50"
            width: 200
        }
        Label {
            id: label_1_2
            y: textField1.y
            anchors.left: textField1.right
            text: " кг."
        }
        Label {
            id: label_2
            y: 300
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Введите свой рост: "
        }
        TextField {
            id: textField2
            y: label_2.y + 80
            placeholderText : "158"
            width: 200
        }
        Label {
            id: label_2_2
            y: textField2.y
            anchors.left: textField2.right
            text: " см."
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 500
            text: "Расчитать"
            onClicked: {
                imt = parseFloat(textField1.text) / ((parseFloat(textField2.text) * parseFloat(textField2.text) / 10000))
                label_3.text = "Ваш индекс массы тела: " + (imt).toFixed(1)
                if (imt < 15.99) {
                    label_4.text = "ВЫРАЖЕННЫЙ ДЕФИЦИТ МАССЫ ТЕЛА"
                    label_4.color = "red"
                } else if (imt < 18.49) {
                    label_4.text = "НЕДОСТАТОЧНАЯ МАССА ТЕЛА"
                    label_4.color = "orange"
                } else if (imt < 24.99) {
                    label_4.text = "НОРМА"
                    label_4.color = "green"
                } else if (imt < 29.99) {
                    label_4.text = "ИЗБЫТОЧНАЯ МАССА ТЕЛА"
                    label_4.color = "orange"
                } else if (imt < 34.99) {
                    label_4.text = "ОЖИРЕНИЕ 1 СТЕПЕНИ"
                    label_4.color = "red"
                } else if (imt < 39.99) {
                    label_4.text = "ОЖИРЕНИЕ 2 СТЕПЕНИ"
                    label_4.color = "red"
                } else {
                    label_4.text = "ОЖИРЕНИЕ 3 СТЕПЕНИ"
                    label_4.color = "red"
                }
            }
        }
        Label {
            id: label_3
            anchors.horizontalCenter: parent.horizontalCenter
            y: 600
            text: ""
        }
        Label {
            id: label_4
            anchors.horizontalCenter: parent.horizontalCenter
            y: 650
            font.bold: true
            text: ""
        }
        Label {
            id: label_5
            anchors.horizontalCenter: parent.horizontalCenter
            y: 800
            font.pixelSize: 40
            text: "     Менее 15,99 - Выраженный дефицит
                     массы тела;
     16 — 18,5 - Недостаточная масса тела
     18,5 — 25 - Норма
     25 — 30 - Избыточная масса тела
     30 — 35 - Ожирение первой степени
     35 — 40 - Ожирение второй степени
     Более 40 - Ожирение третьей степени"
        }
    }
}
