#ifndef DOCTORMODEL_H
#define DOCTORMODEL_H

#include <QAbstractListModel>
#include <QVector>

struct Doctor{
    QString id;
    QString fullname;
    bool active;
};

class DoctorModel : public QAbstractListModel
{
    Q_OBJECT

    enum DoctorRole{
        IdRole = Qt::UserRole, FullnameRole, ActiveRole
    };

public:

    DoctorModel();
   Q_INVOKABLE void fetchDoctorsByAppointmentType(const QString& appointmentType);
    void clear();

private slots:
    void onDoctorsFetchedByAppointmentType();

private:
    QVector<Doctor*> m_doctors;
    bool m_accessingNetwork = false;
    int m_size = 0;

    // QAbstractItemModel interface
    Q_PROPERTY(bool accessingNetwork READ accessingNetwork WRITE setAccessingNetwork NOTIFY accessingNetworkChanged)

    Q_PROPERTY(int size READ size WRITE setSize NOTIFY sizeChanged)

public:
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;
    bool accessingNetwork() const;
    void setAccessingNetwork(bool newAccessingNetwork);
    int size() const;
    void setSize(int newSize);

signals:
    void accessingNetworkChanged();
    void sizeChanged();
};

#endif // DOCTORMODEL_H
