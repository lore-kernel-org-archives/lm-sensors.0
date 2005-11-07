From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Mon, 07 Nov 2005 16:12:54 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A71FB5D@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you for your prompt reply. I am working on a project where a
customized board sitting on the PCI slot. The board has a SMBus
microcontroller which is used to control some external sensors and
communicates with the ICH6 SMBus master controller on the host PC
motherboard. I need to send SMBus request command packets to the
microcontroller and receive SMBus response data packets from the micro
which also generates an interrupt sometimes to request for immediate or
urgent services. 

Do you have any suggestion on how to implement such an application?

Thanks.
MK

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Monday, November 07, 2005 10:39 AM
To: Gu, Mingkun
Cc: lm-sensors@lm-sensors.org
Subject: RE: [lm-sensors] Helps: how to use i801--SMBus functions
viai2c-dev module in Linux?


Hi Michael,

On 2005-11-07, Mingkun Gu wrote:
> With i2c-dev module, is it possible to have more than one device with
> the same major number and different minor numbers? Let say, if I want
to
> have
>
> /dev/i2c/0 89 0
> /dev/i2c/1 89 1
> /dev/i2c/2 89 2
> ......

Yes, it is possible.

> How can I do it? I tried to insmod the i2c-dev module twice and got
> error message say "-1 File exists."

The function of i2c-dev is to give userspace an access to existing i2c
busses. It doesn't create anything per se. If the only I2C/SMBus you
have on your system is the i2c-i801, you'll only have /dev/i2c/0.

Note that it is OK to open the same device file twice, if you need to do
that. Both sessions will be independant. You need to do that if there
are several chips on the bus and you want to drive them all from
userspace.

> One more thing is whether this module provides the ability to handle
> interrupts?

The question isn't relevant for i2c-dev, as it doesn't actually drive
the hardware. It only acts as a bridge.

As for i2c-i801, no, it is poll-based, not interrupt-based. Mark Hoffman
had attempted to convert the driver to interrupt-based, but never
completed the work.

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

