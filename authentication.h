#ifndef AUTHENTICATION_H
#define AUTHENTICATION_H

#include <QObject>


class Authentication : public QObject
{
    Q_OBJECT
public:
    static Authentication& instance();

    Q_INVOKABLE void login(const QString& username, const QString &password);
    const QString &token() const;
    void setToken(const QString &newToken);
    const QString &userName() const;
    void setUserName(const QString &newUserName);
    bool authenticated() const;
    void setAuthenticated(bool newAuthenticated);

signals:
    void tokenChanged();
    void userNameChanged();
    void authenticatedChanged();

private:
    Authentication();
    Authentication(const Authentication&);
    ~Authentication();
    Authentication& operator=(const Authentication&);

    QString m_token;
    QString m_userName;
    bool m_authenticated;

    Q_PROPERTY(QString token READ token WRITE setToken NOTIFY tokenChanged)
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY(bool authenticated READ authenticated WRITE setAuthenticated NOTIFY authenticatedChanged)
};

#endif // AUTHENTICATION_H
