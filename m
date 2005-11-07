From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Nov 2005 17:03:40 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <3RSM5dGT.1131378656.7398430.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

On 2005-11-07, Mingkun Gu wrote:
> Thank you for the advices. I've also tried to write/read block data
> to/from the ICH6 SMBus but failed to receive successful returns. I did
> tried other commands. I received successful returns for I2C_SMBUS_QUICK,
> I2C_SMBUS_BYTE-DATA (read/write) and I2C_SMBUS_WORD_DATA (read), and
> unsuccessful returns (-1) for I2C_SMBUS_WORD_DATA (write) and
> I2C_SMBUS_BLOCK_DATA (read/write)
> when calling the ioctl function of the i2c-dev module.
>
> Any comments and advices?

Does your client chip actually support all these transaction types?

An SMBus transaction will only work if the target chip does expect that
transaction type for the given "command" byte. If not, the chip will
not ACK all the bytes or will stop sending data, causing the transaction
to fail.

You may want to read the SMBus specification for clarifications on what
each transaction does. You should not try random transactions. Only use
the transaction types your client chip expects for each command. These
should be documented.

--
Jean Delvare
