import QtQuick 2.12
import QtQuick.Dialogs 1.2

MessageDialog {
    id: messageDialogError
    title: qsTr("Error")
    text: ""
    onAccepted: {
        messageDialogError.close()
    }
    Component.onCompleted: visible = true
}
