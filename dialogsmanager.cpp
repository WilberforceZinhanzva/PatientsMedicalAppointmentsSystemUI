#include "dialogsmanager.h"

DialogsManager &DialogsManager::instance()
{
    static DialogsManager dialogsmanager;
    return dialogsmanager;
}

DialogsManager::DialogsManager()
{

}

DialogsManager::DialogsManager(const DialogsManager &)
{

}

DialogsManager::~DialogsManager()
{

}

bool DialogsManager::visible() const
{
    return m_visible;
}

void DialogsManager::setVisible(bool newVisible)
{
    if (m_visible == newVisible)
        return;
    m_visible = newVisible;
    emit visibleChanged();
}

const QString &DialogsManager::dialogFile() const
{
    return m_dialogFile;
}

void DialogsManager::setDialogFile(const QString &newDialogFile)
{
    if (m_dialogFile == newDialogFile)
        return;
    m_dialogFile = newDialogFile;
    emit dialogFileChanged();
}

void DialogsManager::openDialog(const QString &dialogFile)
{
    this->setDialogFile(dialogFile);
    this->setVisible(true);
}

void DialogsManager::closeDialog()
{
    this->setDialogFile("");
    this->setVisible(false);
}
