#include "authentication.h"


Authentication &Authentication::instance()
{
    static Authentication authentication;
    return authentication;
}

void Authentication::login(const QString &username, const QString &password)
{

}

Authentication::Authentication()
{

}

Authentication::Authentication(const Authentication &)
{

}

Authentication::~Authentication()
{

}

const QString &Authentication::token() const
{
    return m_token;
}

void Authentication::setToken(const QString &newToken)
{
    if (m_token == newToken)
        return;
    m_token = newToken;
    emit tokenChanged();
}

const QString &Authentication::userName() const
{
    return m_userName;
}

void Authentication::setUserName(const QString &newUserName)
{
    if (m_userName == newUserName)
        return;
    m_userName = newUserName;
    emit userNameChanged();
}

bool Authentication::authenticated() const
{
    return m_authenticated;
}

void Authentication::setAuthenticated(bool newAuthenticated)
{
    if (m_authenticated == newAuthenticated)
        return;
    m_authenticated = newAuthenticated;
    emit authenticatedChanged();
}
