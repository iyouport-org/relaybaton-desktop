import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.2
import org.iyouport.config 1.0

ApplicationWindow {
    id: main_window
    visible: true
    width: 480
    height: 650
    title: qsTr("Relaybaton")
    property Config config: Config {
            id: config
        }

    function saveConfig(){
        return config.validateAndSave(spinBoxClientPort.value,spinBoxClientHTTPPort.value,spinBoxClientRedirPort.value,
                         textFieldClientServer.text,textFieldClientUser.text,textFieldClientPassword.text,switchClientProxyAll.checked,
                        comboBoxDNSType.currentValue,textFieldDNSServer.text,textFieldDNSAddress.text,
                        buttonLogFile.text,comboBoxLogLevel.currentValue)
    }

    header: ToolBar {
        id: toolBarTop
        antialiasing: true
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        GridLayout {
                id: grid
                rows: 7
                columns: calcCols()
                antialiasing: true
                anchors.fill: parent

                function calcCols() {
                    var col = 4
                    var row = 4
                    var buttons = [ button_open, button_save,   button_run, button_stop]
                    function maxWid(n) {
                        var max = 0
                        for (var i = 0; i * col + n < row; i++) {
                            max = max > buttons[i * col + n].width ? max : buttons[i * col + n].width
                        }
                        return max
                    }
                    while (true) {
                        var flag = true
                        LOOP: for (var i = 0; i < row; i++) {
                            var len = 0
                            for (var j = 0; j < col && i * col + j < row; j++) {
                                len += maxWid(j)
                                if (j !== col - 1) {
                                    len += grid.columnSpacing
                                }
                            }
                            if (len > grid.width) {
                                col--
                                flag = false
                                break LOOP
                            }
                        }
                        if (flag || col === 1) {
                            return col
                        }
                    }
                }


                ToolButton {
                    id: button_open
                    text: qsTr("Open")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.name: "document-open"
                    icon.color: "transparent"
                    icon.source: "icon/Document-open.svg"
                    icon.height: 32
                    icon.width: 32
                    onClicked: {
                        var component = Qt.createComponent("qrc:/openfile.qml")
                        var win = component.createObject(main_window)
                        win.parent = main_window
                        win.spinBoxClientPort = spinBoxClientPort
                        win.spinBoxClientHTTPPort = spinBoxClientHTTPPort
                        win.spinBoxClientRedirPort = spinBoxClientRedirPort
                        win.textFieldClientServer = textFieldClientServer
                        win.textFieldClientUser = textFieldClientUser
                        win.textFieldClientPassword = textFieldClientPassword
                        win.switchClientProxyAll = switchClientProxyAll
                        win.comboBoxDNSType = comboBoxDNSType
                        win.textFieldDNSServer = textFieldDNSServer
                        win.textFieldDNSAddress = textFieldDNSAddress
                        win.buttonLogFile = buttonLogFile
                        win.comboBoxLogLevel = comboBoxLogLevel
                        win.button_save = button_save
                        win.button_run = button_run
                        win.button_stop = button_stop
                        win.open()
                    }
                }

                ToolButton {
                    id: button_save
                    text: qsTr("Save")
                    enabled: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.name: "document-save-as"
                    icon.color: "transparent"
                    icon.source: "icon/Document-save-as.svg"
                    icon.height: 32
                    icon.width: 32
                    onClicked: {
                        var str = saveConfig()
                        console.log(str)
                        if (str.length!==0){
                            var component = Qt.createComponent("qrc:/error.qml")
                            var win = component.createObject(main_window,{text:str})
                            win.open()
                        }else{
                            var component = Qt.createComponent("qrc:/savefile.qml")
                            var win = component.createObject(main_window)
                            win.parent = main_window
                            win.open()
                        }
                    }
                }

                ToolButton {
                    id: button_run
                    text: qsTr("Run")
                    enabled: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.name: "system-run"
                    icon.color: "transparent"
                    icon.source: "icon/Media-playback-start.svg"
                    icon.height: 32
                    icon.width: 32
                    onClicked: {
                        var str = saveConfig()
                        if (str.length!==0){
                            var component = Qt.createComponent("qrc:/error.qml")
                            var win = component.createObject(main_window,{text:str})
                            win.open()
                        }else{
                            var rstr = config.run()
                            if (rstr.length!==0){
                                var component = Qt.createComponent("qrc:/error.qml")
                                var win = component.createObject(main_window,{text:rstr})
                                win.open()
                            }else{
                                button_open.enabled = false
                                button_save.enabled = false
                                button_run.enabled = false
                                button_stop.enabled = true
                                spinBoxClientPort.enabled = false
                                spinBoxClientHTTPPort.enabled = false
                                spinBoxClientRedirPort.enabled = false
                                textFieldClientServer.enabled = false
                                textFieldClientUser.enabled = false
                                textFieldClientPassword.enabled = false
                                switchClientProxyAll.enabled = false
                                comboBoxDNSType.enabled = false
                                textFieldDNSServer.enabled = false
                                textFieldDNSAddress.enabled = false
                                buttonLogFile.enabled = false
                                comboBoxLogLevel.enabled = false
                            }
                        }
                    }
                }

                ToolButton {
                    id: button_stop
                    text: qsTr("Stop")
                    enabled: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.name: "system-shutdown"
                    icon.color: "transparent"
                    icon.source: "icon/Process-stop.svg"
                    icon.height: 32
                    icon.width: 32
                    onClicked: {
                        config.stop()
                        button_open.enabled = true
                        button_save.enabled = true
                        button_run.enabled = true
                        button_stop.enabled = false
                        spinBoxClientPort.enabled = true
                        spinBoxClientHTTPPort.enabled = true
                        spinBoxClientRedirPort.enabled = true
                        textFieldClientServer.enabled = true
                        textFieldClientUser.enabled = true
                        textFieldClientPassword.enabled = true
                        switchClientProxyAll.enabled = true
                        comboBoxDNSType.enabled = true
                        textFieldDNSServer.enabled = true
                        textFieldDNSAddress.enabled = true
                        buttonLogFile.enabled = true
                        comboBoxLogLevel.enabled = true
                    }
                }
        }
    }

    ColumnLayout {
        id: columnLayout
        spacing: 5
        anchors.fill: parent

        Label {
            id: labelClient
            text: qsTr("Client")
            Layout.topMargin: columnLayout.spacing
            Layout.fillHeight: true
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        GridLayout {
            id: gridLayoutClient
            width: 100
            height: 100
            rows: 7
            columns: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Label {
                id: labelClientPort
                text: qsTr("Port")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            SpinBox {
                id: spinBoxClientPort
                value: 0
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                wheelEnabled: true
                editable: true
                to: 65535
                Layout.fillHeight: true
            }

            Label {
                id: labelClientHTTPPort
                text: qsTr("HTTP Port")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            SpinBox {
                id: spinBoxClientHTTPPort
                value: 0
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                wheelEnabled: true
                editable: true
                to: 65535
                Layout.fillHeight: true
            }

            Label {
                id: labelClientRedirPort
                text: qsTr("Redir Port")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            SpinBox {
                id: spinBoxClientRedirPort
                value: 0
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                wheelEnabled: true
                editable: true
                to: 65535
                Layout.fillHeight: true
            }

            Label {
                id: labelClientServer
                text: qsTr("Server")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id: textFieldClientServer
                //width: textFieldClientUser.contentWidth + 50
                //text: windowPreferences.config.DNSServer
                //Layout.maximumWidth: gridLayoutDNS.width / 2
                Layout.minimumWidth: 120
                Layout.preferredWidth: 240
                Layout.fillWidth: false
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                placeholderText: "www.example.com"
                Layout.fillHeight: true
            }

            Label {
                id: labelClientUser
                text: qsTr("User")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id: textFieldClientUser
                //width: textFieldClientUser.contentWidth + 50
                //text: windowPreferences.config.DNSServer
                //Layout.maximumWidth: gridLayoutDNS.width / 2
                Layout.minimumWidth: 120
                Layout.preferredWidth: 240
                Layout.fillWidth: false
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                //placeholderText: "www.example.com"
                Layout.fillHeight: true
            }

            Label {
                id: labelClientPassword
                text: qsTr("Password")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            TextField {
                id: textFieldClientPassword
                //width: textFieldClientPassword.contentWidth + 50
                //text: windowPreferences.config.DNSServer
                //Layout.maximumWidth: gridLayoutDNS.width / 2
                Layout.minimumWidth: 120
                Layout.preferredWidth: 240
                Layout.fillWidth: false
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                echoMode: TextInput.Password
                //placeholderText: "www.example.com"
                Layout.fillHeight: true
            }

            Label {
                id: labelClientProxyAll
                text: qsTr("Proxy All")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            Switch {
                id: switchClientProxyAll
                Layout.fillWidth: false
                Layout.fillHeight: true

            }

        }

        Label {
            id: labelDNS
            text: qsTr("DNS")
            Layout.topMargin: columnLayout.spacing
            Layout.fillHeight: true
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        GridLayout {
            id: gridLayoutDNS
            width: 100
            height: 100
            rows: 3
            columns: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Label {
                id: labelDNSType
                text: qsTr("Type")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }

            ComboBox {
                id: comboBoxDNSType
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                Layout.fillHeight: true
                currentIndex: 0
                textRole: "key"
                valueRole: "value"
                model: ListModel {
                    ListElement {
                        key: "Default"
                        value: "default"
                    }
                    ListElement {
                        key: "DNS over TLS"
                        value: "dot"
                    }
                    ListElement {
                        key: "DNS over HTTPS"
                        value: "doh"
                    }
                }
            }

            Label {
                id: labelDNSServer
                text: qsTr("Server")
                Layout.fillHeight: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }

            TextField {
                id: textFieldDNSServer
                width: textFieldDNSServer.contentWidth + 50
                text: ""
                Layout.maximumWidth: gridLayoutDNS.width / 2
                Layout.minimumWidth: 120
                Layout.preferredWidth: 240
                Layout.fillWidth: false
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                placeholderText: "www.example.com"
                Layout.fillHeight: true
            }

            Label {
                id: labelDNSAddress
                text: qsTr("Address")
                Layout.fillHeight: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }

            TextField {
                id: textFieldDNSAddress
                width: 120
                text: ""
                Layout.preferredWidth: 120
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                placeholderText: "0.0.0.0"
                Layout.fillHeight: true
            }
        }

        Label {
            id: labelLog
            text: qsTr("Log")
            Layout.topMargin: columnLayout.spacing
            Layout.fillHeight: true
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        GridLayout {
            id: gridLayoutLog
            width: 100
            height: 100
            rows: 2
            columns: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Label {
                id: labelLogFile
                text: qsTr("File")
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            Button {
                id: buttonLogFile
                text: "..."
                Layout.minimumHeight: 20
                Layout.preferredHeight: 40
                Layout.maximumHeight: 40
                Layout.fillHeight: true
                flat: true
                onClicked: {
                    var component = Qt.createComponent("qrc:/openlogfile.qml")
                    var win = component.createObject(main_window)
                    win.parent = main_window
                    win.buttonLogFile = buttonLogFile
                    win.open()
                }
            }

            Label {
                id: labelLogLevel
                text: qsTr("Level")
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            ComboBox {
                id: comboBoxLogLevel
                Layout.minimumHeight: 10
                Layout.preferredHeight: 42
                Layout.maximumHeight: 42
                Layout.fillHeight: true
                currentIndex: 0
                textRole: "key"
                valueRole: "value"
                model: ListModel {
                    ListElement {
                        key: "Panic"
                        value: "panic"
                    }
                    ListElement {
                        key: "Fatal"
                        value: "fatal"
                    }
                    ListElement {
                        key: "Error"
                        value: "error"
                    }
                    ListElement {
                        key: "Warn"
                        value: "warn"
                    }
                    ListElement {
                        key: "Info"
                        value: "info"
                    }
                    ListElement {
                        key: "Debug"
                        value: "debug"
                    }
                    ListElement {
                        key: "Trace"
                        value: "trace"
                    }
                }
            }
        }
    }

    footer: ToolBar {
        id: toolBarBottom
        antialiasing: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }
}
