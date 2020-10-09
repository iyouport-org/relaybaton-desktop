#ifndef CONFIG_H
#define CONFIG_H

#include <QObject>

class config : public QObject {
Q_OBJECT
    Q_PROPERTY(int clientPort READ getClientPort WRITE setClientPort NOTIFY clientPortChanged)
    Q_PROPERTY(int clientHTTPPort READ getClientHttpPort WRITE setClientHttpPort NOTIFY clientHTTPPortChanged)
    Q_PROPERTY(
            int clientRedirPort READ getClientRedirPort WRITE setClientRedirPort NOTIFY clientRedirPortChanged)
    Q_PROPERTY(QString clientServer READ getClientServer WRITE setClientServer NOTIFY clientServerChanged)
    Q_PROPERTY(QString clientUsername READ getClientUsername WRITE setClientUsername NOTIFY clientUsernameChanged)
    Q_PROPERTY(QString clientPassword READ getClientPassword WRITE setClientPassword NOTIFY clientPasswordChanged)
    Q_PROPERTY(bool clientProxyAll READ isClientProxyAll WRITE setClientProxyAll NOTIFY clientProxyAllChanged)
    Q_PROPERTY(QString DNSType READ getDnsType WRITE setDnsType NOTIFY DNSTypeChanged)
    Q_PROPERTY(QString DNSServer READ getDnsServer WRITE setDnsServer NOTIFY DNSServerChanged)
    Q_PROPERTY(QString DNSAddr READ getDnsAddr WRITE setDnsAddr NOTIFY DNSAddrChanged)
    Q_PROPERTY(QString logFile READ getLogFile WRITE setLogFile NOTIFY logFileChanged)
    Q_PROPERTY(QString logLevel READ getLogLevel WRITE setLogLevel NOTIFY logLevelChanged)
public:
    explicit config(QObject *parent = nullptr);

    Q_INVOKABLE QString run();

    Q_INVOKABLE void stop();

    Q_INVOKABLE QString loadFile(const QUrl &filename);

    Q_INVOKABLE QString saveFile(const QUrl &filename);

    Q_INVOKABLE QString validateAndSave(int clientPort, int clientHttpPort, int clientRedirPort,
                                        const QString &clientServer, const QString &clientUsername,
                                        const QString &clientPassword,
                                        bool clientProxyAll, const QString &dnsType, const QString &dnsServer,
                                        const QString &dnsAddr, const QString &logFile, const QString &logLevel);

    int getClientPort() const;

    void setClientPort(int clientPort);

    int getClientHttpPort() const;

    void setClientHttpPort(int clientHttpPort);

    int getClientRedirPort() const;

    void setClientRedirPort(int clientRedirPort);

    const QString &getClientServer() const;

    void setClientServer(const QString &clientServer);

    const QString &getClientUsername() const;

    void setClientUsername(const QString &clientUsername);

    const QString &getClientPassword() const;

    void setClientPassword(const QString &clientPassword);

    bool isClientProxyAll() const;

    void setClientProxyAll(bool clientProxyAll);

    const QString &getDnsType() const;

    void setDnsType(const QString &dnsType);

    const QString &getDnsServer() const;

    void setDnsServer(const QString &dnsServer);

    const QString &getDnsAddr() const;

    void setDnsAddr(const QString &dnsAddr);

    const QString &getLogFile() const;

    void setLogFile(const QString &logFile);

    const QString &getLogLevel() const;

    void setLogLevel(const QString &logLevel);

signals:

    void clientPortChanged();

    void clientHTTPPortChanged();

    void clientRedirPortChanged();

    void clientServerChanged();

    void clientUsernameChanged();

    void clientPasswordChanged();

    void clientProxyAllChanged();

    void DNSTypeChanged();

    void DNSServerChanged();

    void DNSAddrChanged();

    void logFileChanged();

    void logLevelChanged();

private:
    char *QString2PtrChar(QString qstr);

    int m_client_port;
    int m_client_http_port;
    int m_client_redir_port;
    QString m_client_server;
    QString m_client_username;
    QString m_client_password;
    bool m_client_proxy_all;
    QString m_dns_type;
    QString m_dns_server;
    QString m_dns_addr;
    QString m_log_file;
    QString m_log_level;
};

#endif // CONFIG_H
