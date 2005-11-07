From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Mon, 07 Nov 2005 19:57:04 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721AA4@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


>> I am actually accessing the master ICH6 SMBus controller's registers
and
>> memory instead of the slave control on the customized board.
According
>> to the data sheet of ICH6, it supports block data transfer. 

> Sure it does, that's not the point. The question is, is the slave
> device you are talking to expecting an SMBus block transfer for the
> command byte you are using? As I already said, SMBus transactions only
> work if the master and client agree on the transaction type. If you
are
> trying random block reads/writes, no wonder it doesn't work.

Yes, the slave device has a TI's MSP430 mixed signal microcontroller
which supports block read and write of message/data packets for the
SMBus standard protocol. I'm trying to send the command/data packets in
data blocks. But our board with the microcontroller was not attached to
the PC motherboard during my tests mentioned above. Would this be the
cause for transaction errors?

---
MK


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

