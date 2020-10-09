#include "config.h"
#include <QtCore/QUrl>
#include "core.h"

config::config(QObject *parent) : QObject(parent) {
}

QString config::run() {
    int clientPort = this->getClientPort();
    int clientHTTPPort = this->getClientHttpPort();
    int clientRedir = this->getClientRedirPort();
    char *clientServer = this->QString2PtrChar(this->getClientServer());
    char *clientUsername = this->QString2PtrChar(this->getClientUsername());
    char *clientPassword = this->QString2PtrChar(this->getClientPassword());
    int clientProxyAll = this->isClientProxyAll() ? 1 : 0;
    char *DNSType = this->QString2PtrChar(this->getDnsType());
    char *DNSServer = this->QString2PtrChar(this->getDnsServer());
    char *DNSAddr = this->QString2PtrChar(this->getDnsAddr());
    char *logFile = this->QString2PtrChar(this->getLogFile());
    char *logLevel = this->QString2PtrChar(this->getLogLevel());

    char *ret = Run(clientPort, clientHTTPPort, clientRedir, clientServer, clientUsername, clientPassword,
                    clientProxyAll, DNSType, DNSServer, DNSAddr, logFile, logLevel);
    return QString::fromStdString(std::string(ret));
}

void config::stop() {
    Stop();
}

QString config::loadFile(const QUrl &filename) {
    std::string str = filename.toLocalFile().toStdString();
    char *cstr = new char[str.length() + 1];
    strcpy(cstr, str.c_str());
    auto conf = OpenConfFile(cstr);
    if (std::string(conf.r12).length() == 0) {
        this->setClientPort(conf.r0);
        this->setClientHttpPort(conf.r1);
        this->setClientRedirPort(conf.r2);
        this->setClientServer(conf.r3);
        this->setClientUsername(conf.r4);
        this->setClientPassword(conf.r5);
        this->setClientProxyAll(conf.r6);
        this->setDnsType(conf.r7);
        this->setDnsServer(conf.r8);
        this->setDnsAddr(conf.r9);
        this->setLogFile(conf.r10);
        this->setLogLevel(conf.r11);
    }
    delete[] cstr;
    return QString::fromStdString(std::string(conf.r12));
}

QString config::saveFile(const QUrl &filename) {
    std::string str = filename.toLocalFile().toStdString();
    char *cstr = new char[str.length() + 1];
    strcpy(cstr, str.c_str());
    int clientPort = this->getClientPort();
    int clientHTTPPort = this->getClientHttpPort();
    int clientRedir = this->getClientRedirPort();
    char *clientServer = this->QString2PtrChar(this->getClientServer());
    char *clientUsername = this->QString2PtrChar(this->getClientUsername());
    char *clientPassword = this->QString2PtrChar(this->getClientPassword());
    int clientProxyAll = this->isClientProxyAll() ? 1 : 0;
    char *DNSType = this->QString2PtrChar(this->getDnsType());
    char *DNSServer = this->QString2PtrChar(this->getDnsServer());
    char *DNSAddr = this->QString2PtrChar(this->getDnsAddr());
    char *logFile = this->QString2PtrChar(this->getLogFile());
    char *logLevel = this->QString2PtrChar(this->getLogLevel());
    char *ret = SaveConfFile(cstr, clientPort, clientHTTPPort, clientRedir, clientServer, clientUsername,
                             clientPassword, clientProxyAll, DNSType, DNSServer, DNSAddr, logFile, logLevel);
    QString qret = QString::fromStdString(std::string(ret));
    delete[] ret;
    delete[] logLevel;
    delete[] logFile;
    delete[] DNSAddr;
    delete[] DNSServer;
    delete[] DNSType;
    delete[] clientPassword;
    delete[] clientUsername;
    delete[] clientServer;
    delete[] cstr;

    return qret;
}

QString config::validateAndSave(int clientPort, int clientHttpPort, int clientRedirPort,
                                const QString &clientServer, const QString &clientUsername,
                                const QString &clientPassword,
                                bool clientProxyAll, const QString &dnsType, const QString &dnsServer,
                                const QString &dnsAddr, const QString &logFile, const QString &logLevel) {
    char *_clientServer = this->QString2PtrChar(clientServer);
    char *_clientUsername = this->QString2PtrChar(clientUsername);
    char *_clientPassword = this->QString2PtrChar(clientPassword);
    int _clientProxyAll = clientProxyAll ? 1 : 0;
    char *DNSType = this->QString2PtrChar(dnsType);
    char *DNSServer = this->QString2PtrChar(dnsServer);
    char *DNSAddr = this->QString2PtrChar(dnsAddr);
    char *_logFile = this->QString2PtrChar(logFile);
    char *_logLevel = this->QString2PtrChar(logLevel);

    char *cstr = Validate(clientPort, clientHttpPort, clientRedirPort,
                          _clientServer, _clientUsername, _clientPassword, _clientProxyAll,
                          DNSType, DNSServer, DNSAddr,
                          _logFile, _logLevel);
    QString ret = QString::fromStdString(std::string(cstr));

    if (std::string(cstr).length() == 0) {
        this->setClientPort(clientPort);
        this->setClientHttpPort(clientHttpPort);
        this->setClientRedirPort(clientRedirPort);
        this->setClientServer(clientServer);
        this->setClientUsername(clientUsername);
        this->setClientPassword(clientPassword);
        this->setClientProxyAll(clientProxyAll);
        this->setDnsType(dnsType);
        this->setDnsServer(dnsServer);
        this->setDnsAddr(dnsAddr);
        this->setLogFile(logFile);
        this->setLogLevel(logLevel);
    }

    delete[] _logLevel;
    delete[] _logFile;
    delete[] DNSAddr;
    delete[] DNSServer;
    delete[] DNSType;
    delete[] _clientPassword;
    delete[] _clientUsername;
    delete[] _clientServer;
    delete[] cstr;

    return ret;
}

int config::getClientPort() const {
    return m_client_port;
}

void config::setClientPort(int clientPort) {
    m_client_port = clientPort;
    emit this->clientPortChanged();
}

int config::getClientHttpPort() const {
    return m_client_http_port;
}

void config::setClientHttpPort(int clientHttpPort) {
    m_client_http_port = clientHttpPort;
    emit this->clientHTTPPortChanged();
}

int config::getClientRedirPort() const {
    return m_client_redir_port;
}

void config::setClientRedirPort(int clientRedirPort) {
    m_client_redir_port = clientRedirPort;
    emit this->clientRedirPortChanged();
}

const QString &config::getClientServer() const {
    return m_client_server;
}

void config::setClientServer(const QString &clientServer) {
    m_client_server = clientServer;
    emit this->clientServerChanged();
}

const QString &config::getClientUsername() const {
    return m_client_username;
}

void config::setClientUsername(const QString &clientUsername) {
    m_client_username = clientUsername;
    emit this->clientUsernameChanged();
}

const QString &config::getClientPassword() const {
    return m_client_password;
}

void config::setClientPassword(const QString &clientPassword) {
    m_client_password = clientPassword;
    emit this->clientPasswordChanged();
}

bool config::isClientProxyAll() const {
    return m_client_proxy_all;
}

void config::setClientProxyAll(bool clientProxyAll) {
    m_client_proxy_all = clientProxyAll;
    emit this->clientProxyAllChanged();
}

const QString &config::getDnsType() const {
    return m_dns_type;
}

void config::setDnsType(const QString &dnsType) {
    m_dns_type = dnsType;
    emit this->DNSTypeChanged();
}

const QString &config::getDnsServer() const {
    return m_dns_server;
}

void config::setDnsServer(const QString &dnsServer) {
    m_dns_server = dnsServer;
    emit this->DNSServerChanged();
}

const QString &config::getDnsAddr() const {
    return m_dns_addr;
}

void config::setDnsAddr(const QString &dnsAddr) {
    m_dns_addr = dnsAddr;
    emit this->DNSAddrChanged();
}

const QString &config::getLogFile() const {
    return m_log_file;
}

void config::setLogFile(const QString &logFile) {
    m_log_file = logFile;
    emit this->logFileChanged();
}

const QString &config::getLogLevel() const {
    return m_log_level;
}

void config::setLogLevel(const QString &logLevel) {
    m_log_level = logLevel;
    emit this->logLevelChanged();
}

char *config::QString2PtrChar(QString qstr) {
    std::string str = qstr.toStdString();
    char *cstr = new char[str.length() + 1];
    strcpy(cstr, str.c_str());
    return cstr;
}