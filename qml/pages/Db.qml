import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Item {
    property var db;

    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("diary", "1.0");
        createNotesTable();
    }
    function createNotesTable() {
        db.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS diary (
                id INTEGER PRIMARY KEY AUTOINCREMENT,"
                + "day TEXT NOT NULL, mass INT, proteins INT, fats INT, carbohydrates INT, calorie INT);");
        });
    }

    function insertNote(_date, _mass, _proteins, _fats, _carbohydrates, _calorie) {
        retrieveNotes(function(notes) {
            for (var i = 0; i < notes.length; i++) {
                var note = notes.item(i);
                if (i === notes.length -1) {
                    var l_date = notes.item(i).day;
                    var l_mass = notes.item(i).mass;
                    var l_proteins = notes.item(i).proteins;
                    var l_fats = notes.item(i).fats;
                    var l_carbohydrates = notes.item(i).carbohydrates;
                    var l_calorie = notes.item(i).calorie;
                    if (l_date === _date) {
                        updateNote(_date, _mass, l_proteins + _proteins, l_fats + _fats, l_carbohydrates + _carbohydrates, l_calorie + _calorie)
                        setting1.value = [_date, _mass, l_proteins + _proteins, l_fats + _fats, l_carbohydrates + _carbohydrates, l_calorie + _calorie]
                    } else {
                        db.transaction(function(tx) {
                            tx.executeSql("INSERT INTO diary (day, mass, proteins, fats, carbohydrates, calorie)
                             VALUES(?, ?, ?, ?, ?, ?);", [_date, _mass, _proteins, _fats, _carbohydrates, _calorie]);
                                    });
                        setting1.value = [_date, _mass, _proteins, _fats, _carbohydrates, _calorie]
                                }
                }
            }
        });
}



    function setMass(_date, _mass) {
        getDate(function(last_date) {
            for (var i = 0; i < last_date.length; i++) {
                var l_date = last_date.item(i).day;
                var l_mass = last_date.item(i).mass;
                if (l_date === _date) {
                    db.transaction(function(tx) {
                        tx.executeSql("UPDATE diary SET mass = ? WHERE day = ?;", [_mass, _date]);
                    });
                    setting1.value = [_date, _mass, setting1.value[2], setting1.value[3], setting1.value[4], setting1.value[5]]
                } else {
                    db.transaction(function(tx) {
                        tx.executeSql("INSERT INTO diary (day, mass, proteins, fats, carbohydrates, calorie)
                         VALUES(?, ?, ?, ?, ?, ?);", [_date, _mass, 0, 0, 0, 0]);
                                });
                    setting1.value = [_date, _mass, 0, 0, 0, 0]
                    }
            }
        });
    }
    function updateNote(_date, _mass, _proteins, _fats, _carbohydrates, _calorie) {
        db.transaction(function(tx) {
            tx.executeSql("UPDATE diary SET mass = ?, proteins = ?, fats = ?, carbohydrates = ?,
 calorie = ? WHERE day = ?;", [_mass, _proteins, _fats, _carbohydrates, _calorie, _date]);
        });
    }
    function deleteNote(id) {
        db.transaction(function(tx) {
            tx.executeSql("DELETE FROM diary WHERE id > 0;");
        });
    }
    function retrieveNotes(callback) {
        db.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM diary;");
            callback(result.rows);
        });
    }
    function selectDates(callback) {
        db.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT day FROM diary;");
            callback(result.rows);
        });
    }
    function getDate(callback) {
        db.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM diary WHERE id=(SELECT MAX(id) FROM diary);");
            callback(result.rows);
        });
    }
    function getCurrentValues(callback) {
        db.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM diary WHERE day = ?;", [currentDate]);
            callback(result.rows);
        });
    }
}
