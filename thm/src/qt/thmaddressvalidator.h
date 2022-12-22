// Copyright (c) 2011-2014 The THM Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef THM_QT_THMADDRESSVALIDATOR_H
#define THM_QT_THMADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class THMAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit THMAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** THM address widget validator, checks for a valid thm address.
 */
class THMAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit THMAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // THM_QT_THMADDRESSVALIDATOR_H
