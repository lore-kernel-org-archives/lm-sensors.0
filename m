From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 01 Feb 2013 18:35:51 +0000
Subject: Re: [lm-sensors] SMSC SIO10n268 Super I/O Linux support
Message-Id: <20130201183551.GA20833@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANSy19gSLySBGDBkD5bbTjY7F6y3vmqWquSC0=8HuV4rzr8krw@mail.gmail.com>
In-Reply-To: <CANSy19gSLySBGDBkD5bbTjY7F6y3vmqWquSC0=8HuV4rzr8krw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 01, 2013 at 08:42:56PM +0530, Sreekanth W wrote:
> Hello,
> 
> I would like to know whether the SMSC SIO10n268 Super I/O support exist in
> the Linux kernel? Does it need a Linux Kernel driver? OR does it work with
> the lm-sensors package?
> 
Unless I am missing something, this chip does not have hardware monitoring
support, so there won't be a hardware monitoring driver for it.

> I'm able to detect the device with "sensors-detect" and "superiotool"
> utilities, also able to dump the device registers with "superiotool -d".
> 
> How to configure a UART port connected to this Super IO device? Is there
> any other application/tool for this?
> 
Per datasheet: "High Speed NS16C550 Compatible UARTs with Send/Receive
16-Byte FIFOs". It should behave like a standard UART port.
Do you have any indication that this is not the case ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
