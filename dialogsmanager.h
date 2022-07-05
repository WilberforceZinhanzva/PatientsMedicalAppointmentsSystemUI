#ifndef DIALOGSMANAGER_H
#define DIALOGSMANAGER_H

#include <QObject>

class DialogsManager : public QObject
{
    Q_OBJECT

public:
    static DialogsManager& instance();

    bool visible() const;
    void setVisible(bool newVisible);
    const QString &dialogFile() const;
    void setDialogFile(const QString &newDialogFile);

    Q_INVOKABLE void openDialog(const QString& dialogFile);
    Q_INVOKABLE void closeDialog();

signals:
    void visibleChanged();
    void dialogFileChanged();

private:
    DialogsManager();
    DialogsManager(const DialogsManager&);
    ~DialogsManager();
    DialogsManager& operator=(const DialogsManager&);

    bool m_visible;
    QString m_dialogFile;

    Q_PROPERTY(bool visible READ visible WRITE setVisible NOTIFY visibleChanged)
    Q_PROPERTY(QString dialogFile READ dialogFile WRITE setDialogFile NOTIFY dialogFileChanged)
};

#endif // DIALOGSMANAGER_H
