import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

Page {
    id: page
    allowedOrientations: Orientation.All
    Image {
        source: sourceCatImg
        width: parent.width
        height: parent.height
    }
    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Show MainPage")
                onClicked: pageStack.push(Qt.resolvedUrl("MainPage.qml"))
            }
        }
        SilicaListView {
            id: listView
            anchors.fill: parent
            VerticalScrollDecorator { flickable: listView; color: "black"; width: 15 }
            header: PageHeader { title: currentCatModel.get(0).cat; titleColor: "blue" }
            model: currentCatModel
            delegate: Column {
                x: 10; width: parent.width - 2 * x
                Label {
                    width: parent.width
                    color: "black"
                    wrapMode: Text.WordWrap
                    text:name
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                           currentItemModel.clear()
                            currentItemModel.append({
                                name: name,
                                proteins: proteins,
                                fats: fats,
                                carbohydrates: carbohydrates,
                                calorie: calorie});
                            pageStack.push(Qt.resolvedUrl("ItemPage.qml"))
                         }

                     }

                }
            }
        }
    }
}

