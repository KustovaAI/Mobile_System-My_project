import QtQuick 2.0
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0
import "pages"

ApplicationWindow
{
    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
    Db {id: db1}
    ListModel { id: currentCatModel }
    ListModel { id: currentItemModel }
    property date todayDate: new Date()
    property string dateString: todayDate.toLocaleDateString()
    property variant mDates: []
    property string currentDate: dateString
    property string sourceCatImg: ""
    property int delta: 0
    property real normProteins: 100
    property real normFats: 100
    property real normCarbohydrates: 450
    property real normCalorie: 1800
    property real currentProteins: setting1.value[2]
    property real currentFats: setting1.value[3]
    property real currentCarbohydrates: setting1.value[4]
    property real currentCalorie: setting1.value[5]

     ConfigurationValue {
                id: setting1
                key: "/apps/app_name/setting_name"
                defaultValue: ["Monday, 19 April 2021", 48, 0, 0, 0, 0]
            }
    function selectAllNotes() {
        db1.retrieveNotes(function(notes) {
            for (var i = 0; i < notes.length; i++) {
                var note = notes.item(i);
             //   console.log(note.id, note.day,note.mass, note.proteins, note.fats, note.calorie);
            }
        });
    }
    function selectAllDates() {
        mDates = []
        db1.selectDates(function(notes) {
            for (var i = 0; i < notes.length; i++) {
                var note = notes.item(i);
            //    console.log(note.day);
                mDates.push(note.day)
            }
        });
    }
    function getMass() {
        var my_mass;
        db1.getCurrentValues(function(m) {
            for (var i = 0; i < m.length; i++) {
                my_mass = m.item(0).mass;
            }
        });
        return my_mass;
    }
    function getCurValues() {
        var my_mass;
        db1.getCurrentValues(function(m) {
            for (var i = 0; i < m.length; i++) {
                currentProteins = m.item(0).proteins;
                currentFats = m.item(0).fats;
                currentCarbohydrates = m.item(0).carbohydrates;
                currentCalorie = m.item(0).calorie
            }
        });
        return my_mass;
    }

    function getColor(p) {
        if (p < 0.33) {
            return "green"
        } else {
            if (p < 0.66) {
                return "orange"
            } else {
                return "red"
            }
        }
    }
    Timer {
        id:timer2
        interval: 1; running: true; repeat: false
        onTriggered: {
            if (setting1.value[0] !== dateString) {
                db1.insertNote(dateString, setting1.value[1], 0, 0,0, 0)
                selectAllNotes()
                console.log("New Day")
            }
        }
    }

}
