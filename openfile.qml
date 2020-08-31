import QtQuick 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.12
import org.iyouport.config 1.0

FileDialog {
    id: fileDialogOpen
    title: "Please choose a file"
    defaultSuffix: ".toml"
    folder: shortcuts.home
    selectExisting: true
    selectMultiple: false
    selectFolder: false
    nameFilters: ["TOML (*.toml)", "All files (*)"]
    property ApplicationWindow parent
    property SpinBox spinBoxClientPort
    property SpinBox spinBoxClientHTTPPort
    property SpinBox spinBoxClientTransparentPort
    property TextField textFieldClientServer
    property TextField textFieldClientUser
    property TextField textFieldClientPassword
    property Switch switchClientProxyAll
    property ComboBox comboBoxDNSType
    property TextField textFieldDNSServer
    property TextField textFieldDNSAddress
    property Button buttonLogFile
    property ComboBox comboBoxLogLevel
    property ToolButton button_open
    property ToolButton button_save
    property ToolButton button_run
    property ToolButton button_stop

    onAccepted: {
        console.log("You chose: " + fileDialogOpen.fileUrls)
        var str = fileDialogOpen.parent.config.loadFile(fileDialogOpen.fileUrl)
        if(str.length!==0){
            var component = Qt.createComponent("qrc:/error.qml")
            var win = component.createObject(main_window,{text:str})
            win.open()
        }else{
            spinBoxClientPort.value=fileDialogOpen.parent.config.clientPort
            spinBoxClientHTTPPort.value=fileDialogOpen.parent.config.clientHTTPPort
            spinBoxClientTransparentPort.value=fileDialogOpen.parent.config.clientTransparentPort
            textFieldClientServer.text = fileDialogOpen.parent.config.clientServer
            textFieldClientUser.text = fileDialogOpen.parent.config.clientUsername
            textFieldClientPassword.text = fileDialogOpen.parent.config.clientPassword
            switchClientProxyAll.checked = fileDialogOpen.parent.config.clientProxyAll
            comboBoxDNSType.currentIndex = comboBoxDNSType.indexOfValue(fileDialogOpen.parent.config.DNSType)
            textFieldDNSServer.text = fileDialogOpen.parent.config.DNSServer
            textFieldDNSAddress.text = fileDialogOpen.parent.config.DNSAddr
            buttonLogFile.text = fileDialogOpen.parent.config.logFile
            comboBoxLogLevel.currentIndex = comboBoxLogLevel.indexOfValue(fileDialogOpen.parent.config.logLevel)
            button_save.enabled = true
            button_run.enabled = true
            button_stop.enabled = false
        }
        fileDialogOpen.close()
    }
    onRejected: {
        fileDialogOpen.close()
    }
    Component.onCompleted: visible = true
}
