// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef GLOBALBITCOIN_QT_GLOBALBITCOINADDRESSVALIDATOR_H
#define GLOBALBITCOIN_QT_GLOBALBITCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class GlobalBitcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit GlobalBitcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** GlobalBitcoin address widget validator, checks for a valid globalbitcoin address.
 */
class GlobalBitcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit GlobalBitcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // GLOBALBITCOIN_QT_GLOBALBITCOINADDRESSVALIDATOR_H
