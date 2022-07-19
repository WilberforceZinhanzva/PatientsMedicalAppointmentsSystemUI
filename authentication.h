#ifndef AUTHENTICATION_H
#define AUTHENTICATION_H

#include <QObject>


class Authentication : public QObject
{
    Q_OBJECT
public:
    static Authentication& instance();

    Q_INVOKABLE void login(const QString& username, const QString &password);
    Q_INVOKABLE void signUp(const QString& fullname, const QString& phone, const QString& email, const QString& address, const QString& username, const QString& password);
    Q_INVOKABLE void bookAppointment(const QString& appointmentType, const QString &doctorId, const QString &dateAndTime, const QString &paymentMethod);
    const QString &token() const;
    void setToken(const QString &newToken);
    const QString &userName() const;
    void setUserName(const QString &newUserName);
    bool authenticated() const;
    void setAuthenticated(bool newAuthenticated);


private slots:
    void onLogin();
    void onSignUp();
    void onBookAppointment();


signals:
    void tokenChanged();
    void userNameChanged();
    void authenticatedChanged();

    void signUpInProgress();
    void signUpSuccess();
    void signUpFailure();

    void bookingProgress();
    void bookingSuccess();
    void bookingFailure();

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
