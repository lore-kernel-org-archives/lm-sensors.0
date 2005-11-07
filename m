From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Nov 2005 15:51:58 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <LMX4SZyo.1131374357.6876490.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

On 2005-11-07, Mingkun Gu wrote:
> With i2c-dev module, is it possible to have more than one device with
> the same major number and different minor numbers? Let say, if I want to
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
