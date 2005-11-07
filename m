From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Mon, 07 Nov 2005 18:14:50 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721AA2@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I am actually accessing the master ICH6 SMBus controller's registers and
memory instead of the slave control on the customized board. According
to the data sheet of ICH6, it supports block data transfer. 

Best Rgds
MK

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Monday, November 07, 2005 11:51 AM
To: Gu, Mingkun
Cc: LM Sensors
Subject: RE: [lm-sensors] Helps: how to use i801--SMBus functions
viai2c-dev module in Linux?


Hi Michael,

On 2005-11-07, Mingkun Gu wrote:
> Thank you for the advices. I've also tried to write/read block data
> to/from the ICH6 SMBus but failed to receive successful returns. I did
> tried other commands. I received successful returns for
I2C_SMBUS_QUICK,
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

-----------------------------------------
This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention,
distribution or disclosure by others is strictly prohibited. If you are
not the intended recipient (or authorized to receive for the
recipient), please contact the sender by reply email and delete all
copies of this message. Also, email is susceptible to data corruption,
interception, tampering, unauthorized amendment and viruses. We only
send and receive emails on the basis that we are not liable for any
such corruption, interception, tampering, amendment or viruses or any
consequence thereof.

