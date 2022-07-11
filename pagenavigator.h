#ifndef PAGENAVIGATOR_H
#define PAGENAVIGATOR_H

#include <QObject>

class PageNavigator : public QObject
{
    Q_OBJECT

public:
    static PageNavigator& instance();

    Q_INVOKABLE void navigateToPage(const QString& page);
    Q_INVOKABLE void navigateToDefaultPage();
    const QString &defaultPage() const;
    void setDefaultPage(const QString &newDefaultPage);
    const QString &currentPage() const;
    void setCurrentPage(const QString &newCurrentPage);

signals:
    void defaultPageChanged();
    void currentPageChanged();

private:
    PageNavigator();
    PageNavigator(const PageNavigator&);
    PageNavigator& operator=(const PageNavigator&);
    ~PageNavigator();

    QString m_defaultPage;
    QString m_currentPage;
    Q_PROPERTY(QString defaultPage READ defaultPage WRITE setDefaultPage NOTIFY defaultPageChanged)
    Q_PROPERTY(QString currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)
};

#endif // PAGENAVIGATOR_H
