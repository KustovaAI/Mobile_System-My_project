import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0
import QtQuick.LocalStorage 2.0

Page {
    id: page
    property real _prot: 0
    property real _fats: 0
    property real _carb: 0
    property real _cal: 0
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Show MainPage")
                onClicked: pageStack.push(Qt.resolvedUrl("MainPage.qml"))
            }
        }
        PageHeader { title: "Информация о продукте" }

        Label {
            id: label_name
            y: 200
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
            anchors.horizontalCenter: parent.horizontalCenter
            text: currentItemModel.get(0).name
        }

        Label {
            anchors.top : label_name.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "(Показатели для 100 г. продукта)"
        }
        Column {
            id: col1
            y: 350
            spacing: 20
            Label {
                id: label_prot1
                text: "Белки: " + currentItemModel.get(0).proteins + " г."
            }
            Label {
                id: label_fats1
                text: "Жиры: " + currentItemModel.get(0).fats + " г."
            }
            Label {
                id: label_carb1
                text: "Углеводы: " + currentItemModel.get(0).carbohydrates + " г."
            }
            Label {
                id: label_calorie1
                text: "Каллорийность: " + currentItemModel.get(0).calorie + " Ккал"
            }
        }
        Label {
          id: l1
            y: 650
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Введите массу продукта"
        }
        TextField {
            id: textField1
            y: l1.y + 50
            width: 400
        }
        Button {
            y: textField1.y + 120
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Расчитать БЖУ"
            onClicked: {
                b2.visible = true
                _prot = (parseFloat(currentItemModel.get(0).proteins) / 100 * parseInt(textField1.text)).toFixed(2)
                _fats = (parseFloat(currentItemModel.get(0).fats) / 100 * parseInt(textField1.text)).toFixed(2)
                _carb = (parseFloat(currentItemModel.get(0).carbohydrates) / 100 * parseInt(textField1.text)).toFixed(2)
                _cal = (parseFloat(currentItemModel.get(0).calorie) / 100 * parseInt(textField1.text)).toFixed(2)
                label_prot2.text = "Белки: " + _prot + " г."
                label_fats2.text = "Жиры: " + _fats + " г."
                label_carb2.text = "Углеводы: " + _carb + " г."
                label_calorie2.text = "Каллорийность: " + _cal + " Ккал"
            }
        }
        Column {
            y: 900
            Label {
                id: label_prot2
                text: ""
            }
            Label {
                id: label_fats2
                text: ""
            }
            Label {
                id: label_carb2
                text: ""
            }
            Label {
                id: label_calorie2
                text: ""
            }
        }
        Button {
            id: b2
            y: 1200
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Добавить в приём пищи"
            visible: false
            onClicked: {
                db1.insertNote(dateString, setting1.value[1], _prot, _fats, _carb, _cal)
                pageStack.push(Qt.resolvedUrl("CategoriesPage.qml"))
                selectAllNotes()
            }
        }
    }
}

