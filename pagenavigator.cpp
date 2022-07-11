#include "pagenavigator.h"

PageNavigator &PageNavigator::instance()
{
    static PageNavigator pageNavigator;
    return pageNavigator;
}

void PageNavigator::navigateToPage(const QString &page)
{
    this->setCurrentPage(page);
}

void PageNavigator::navigateToDefaultPage()
{
   this->setCurrentPage(m_defaultPage);
}

PageNavigator::PageNavigator(): m_defaultPage("Dashboard.qml"), m_currentPage(m_defaultPage)
{

}

PageNavigator::PageNavigator(const PageNavigator &)
{

}

PageNavigator::~PageNavigator()
{

}

const QString &PageNavigator::defaultPage() const
{
    return m_defaultPage;
}

void PageNavigator::setDefaultPage(const QString &newDefaultPage)
{
    if (m_defaultPage == newDefaultPage)
        return;
    m_defaultPage = newDefaultPage;
    emit defaultPageChanged();
}

const QString &PageNavigator::currentPage() const
{
    return m_currentPage;
}

void PageNavigator::setCurrentPage(const QString &newCurrentPage)
{
    if (m_currentPage == newCurrentPage)
        return;
    m_currentPage = newCurrentPage;
    emit currentPageChanged();
}

