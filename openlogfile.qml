import QtQuick 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.12
import org.iyouport.config 1.0

FileDialog {
    id: fileOpenLogFile
    title: "Please choose a file"
    defaultSuffix: ".xml"
    folder: shortcuts.home
    selectExisting: true
    selectMultiple: false
    selectFolder: false
    nameFilters: ["XML (*.xml)", "All files (*)"]

    property ApplicationWindow parent
    property Button buttonLogFile
    onAccepted: {
        buttonLogFile.text = fileDialogOpen.fileUrl
        fileOpenLogFile.close()
    }
    onRejected: {
        fileOpenLogFile.close()
    }
    Component.onCompleted: visible = true
}
