#ifndef THM_QT_TEST_WALLETTESTS_H
#define THM_QT_TEST_WALLETTESTS_H

#include <QObject>
#include <QTest>

class WalletTests : public QObject
{
    Q_OBJECT

private Q_SLOTS:
    void walletTests();
};

#endif // THM_QT_TEST_WALLETTESTS_H
