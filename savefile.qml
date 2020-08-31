import QtQuick 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.12
import org.iyouport.config 1.0

FileDialog {
    id: fileDialogSave
    title: "Please choose a file"
    defaultSuffix: ".toml"
    folder: shortcuts.home
    selectExisting: false
    selectMultiple: false
    selectFolder: false
    nameFilters: ["TOML (*.toml)", "All files (*)"]

    property ApplicationWindow parent

    onAccepted: {
        var str = fileDialogSave.parent.config.saveFile(fileDialogSave.fileUrl)
        if(str.length!==0){
            var component = Qt.createComponent("qrc:/error.qml")
            var win = component.createObject(main_window,{text:str})
            win.open()
        }
        fileDialogSave.close()
    }
    onRejected: {
        fileDialogSave.close()
    }
    Component.onCompleted: visible = true
}

