From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Mon, 07 Nov 2005 16:52:52 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721AA1@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you for the advices. I've also tried to write/read block data
to/from the ICH6 SMBus but failed to receive successful returns. I did
tried other commands. I received successful returns for I2C_SMBUS_QUICK,
I2C_SMBUS_BYTE-DATA (read/write) and I2C_SMBUS_WORD_DATA (read), and
unsuccessful returns (-1) for I2C_SMBUS_WORD_DATA (write) and
I2C_SMBUS_BLOCK_DATA (read/write)
when calling the ioctl function of the i2c-dev module.

Any comments and advices?

Thanks.
MK

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Monday, November 07, 2005 11:18 AM
To: Gu, Mingkun
Cc: lm-sensors@lm-sensors.org; Mark M. Hoffman
Subject: RE: [lm-sensors] Helps: how to use i801--SMBus functions
viai2c-dev module in Linux?


Hi Michael,

On 2005-11-07, Mingkun Gu wrote:
> Thank you for your prompt reply. I am working on a project where a
> customized board sitting on the PCI slot. The board has a SMBus
> microcontroller which is used to control some external sensors and
> communicates with the ICH6 SMBus master controller on the host PC
> motherboard. I need to send SMBus request command packets to the
> microcontroller and receive SMBus response data packets from the micro
> which also generates an interrupt sometimes to request for immediate
or
> urgent services.
>
> Do you have any suggestion on how to implement such an application?

For one thing, if you are dealing with events which require fast
reactions, it might be wiser to write a kernel driver than a user-space
application.

Second, as I said, the current i2c-i801 driver is not interrupt based.
If
you need it to react fast, you will need to rewrite it in part to use
interrupts. If you do, you should get in touch with Mark M. Hoffman who
has been working on this some times ago.

The details depend on the exact hardware implementation. I have to admit
I am not really qualified to comment on interrupts, as I never had to
deal with these so far. Please note that the i2c core in Linux doesn't
support slave mode on masters at the moment. If this is something your
system needs, this will be a (serious) problem.

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

