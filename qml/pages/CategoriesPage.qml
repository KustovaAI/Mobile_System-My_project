import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0

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
        XmlListModel {
            id: modelCat
            query: "/Table/Category"
            source: "../pages/table.xml"
            XmlRole { name: "nameCat"; query: "nameCat/string()"; }
            XmlRole { name: "imgCat"; query: "imgCat/string()"; }
        }
        XmlListModel {
            id: modelItems
            query: "/Table/Category/Item"
            source: "../pages/table.xml"
            XmlRole { name: "name"; query: "name/string()"; }
            XmlRole { name: "proteins"; query: "proteins/string()"; }
            XmlRole { name: "fats"; query: "fats/string()"; }
            XmlRole { name: "carbohydrates"; query: "carbohydrates/string()"; }
            XmlRole { name: "calorie"; query: "calorie/string()"; }
            XmlRole { name: "cat"; query: "cat/string()"; }
        }
        SilicaListView {
            anchors.fill: parent
            header: PageHeader { title: "Категории продуктов" }
            model: modelCat
            spacing: 50
            delegate: Column {
                x: 10; width: parent.width - 2 * x
                Button {
                    width: parent.width                    
                    text: nameCat
                    onClicked: {
                        sourceCatImg = imgCat
                        model: modelItems
                        currentCatModel.clear()
                        for (var i = 0; i < modelItems.count; i++ ) {
                            if (modelItems.get(i).cat === nameCat) {
                                currentCatModel.append({
                                   name: modelItems.get(i).name,
                                   proteins: modelItems.get(i).proteins,
                                   fats: modelItems.get(i).fats,
                                   carbohydrates: modelItems.get(i).carbohydrates,
                                   calorie: modelItems.get(i).calorie,
                                   cat: modelItems.get(i).cat});
                            }
                        }
                        pageStack.push(Qt.resolvedUrl("CurentCategoryPage.qml"))
                    }
                }
            }
        }
    }
}

