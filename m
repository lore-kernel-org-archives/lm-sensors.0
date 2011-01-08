From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 08 Jan 2011 10:05:50 +0000
Subject: Re: [lm-sensors] Nvidia GeForce 310M support?
Message-Id: <20110108110550.2ecf06e9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=yaGq5Hwv=so2-S=oQMw=CNadR_m--hHUkcnwW@mail.gmail.com>
In-Reply-To: <AANLkTi=yaGq5Hwv=so2-S=oQMw=CNadR_m--hHUkcnwW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please reply to the list, not to me only, otherwise the discussion is
not archived for others to look at.

On Fri, 7 Jan 2011 23:03:27 +0530, Zenwalker wrote:
> Thanks for your reply. The output you have asked for
> 
> root[Documents]# perl l.pl
> > # sensors-detect revision 5895 (2010-12-12 17:54:35 +0100)
> > # System: Dell Inc. Vostro 3500
> > # Board: Dell Inc. 0PXM4R

A laptop. lm-sensors is useless on most of them.

> > Trying family `ITE'...                                      No
> > Probing for Super-I/O at 0x4e/0x4f
> > Trying family `National Semiconductor'...                   Yes
> > Found unknown chip with ID 0xfc11

Do you have any idea what Super-I/O (LPC) chip is present on the
machine?

> > Using driver `i2c-i801' for device 0000:00:1f.3: Intel 3400/5 Series (PCH)

This I2C adapter is never scanned, so somehow the i2c-i801 driver
doesn't work for you. Please check the kernel logs after removing and
reloading the i2c-i801 driver. Maybe the I/O ports are reserved by ACPI.

> > Sorry, no sensors were detected.

I'm just realizing that you are asking for support of your graphics
adapter, not system. We don't generally support sensors on graphics
adapters. Sometimes it works, but if it doesn't, there's nothing we can
do. Support has to come from the video driver (and some drivers do
that, in particular the radeon KMS driver in recent kernels, but
obviously it's not helpful for you.)

If you are using the binary nvidia driver, there's a tool that comes
with it, which you can use to check the temperature. I think it's named
nvclock, it would be interesting to see if you can get the information
from it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
