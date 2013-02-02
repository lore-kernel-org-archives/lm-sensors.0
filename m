From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 02 Feb 2013 16:12:36 +0000
Subject: Re: [lm-sensors] SMSC SIO10n268 Super I/O Linux support
Message-Id: <20130202161236.GB10386@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANSy19gSLySBGDBkD5bbTjY7F6y3vmqWquSC0=8HuV4rzr8krw@mail.gmail.com>
In-Reply-To: <CANSy19gSLySBGDBkD5bbTjY7F6y3vmqWquSC0=8HuV4rzr8krw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 02, 2013 at 08:39:17PM +0530, Sreekanth W wrote:
> Thanks again,
> 
> May be I'm new to the Super I/O device, I was just curious to know more
> info about it, but not found much info on this device support in Linux,
> though I found some code/patch in Coreboot and lm-sensors.
> 
Yes, because there is no need for it when it comes to standard functionality
such as UART and floppy access. Coreboot only initializes the chip,
and lm-sensors handles hardware monitoring.

Guenter

> Let me test this device using the UART driver in Linux, and hope it should
> work.
> 
> Sreekanth
> 
> On Sat, Feb 2, 2013 at 9:47 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Sat, Feb 02, 2013 at 09:31:38AM +0530, Sreekanth W wrote:
> > > Hi Guenter,
> > >
> > Please don't top-post.
> >
> > > Thanks for your response.
> > >
> > > Yes, this Super I/O is not a Sensor.
> > > But I'm just wondering will it work with the standard Linux 8250 UART
> > > driver, or any additional driver is required for this device to control
> > > it's Serial port registers and the Serial port to be functional.
> > >
> > Do you have any indication that there is a problem ?
> >
> > If not, the time to bother about it is if/when it is not working, not
> > beforehand.
> >
> > Thanks,
> > Guenter
> >
> > > Regards,
> > > Sreekanth
> > >
> > > On Sat, Feb 2, 2013 at 12:05 AM, Guenter Roeck <linux@roeck-us.net>
> > wrote:
> > >
> > > > On Fri, Feb 01, 2013 at 08:42:56PM +0530, Sreekanth W wrote:
> > > > > Hello,
> > > > >
> > > > > I would like to know whether the SMSC SIO10n268 Super I/O support
> > exist
> > > > in
> > > > > the Linux kernel? Does it need a Linux Kernel driver? OR does it work
> > > > with
> > > > > the lm-sensors package?
> > > > >
> > > > Unless I am missing something, this chip does not have hardware
> > monitoring
> > > > support, so there won't be a hardware monitoring driver for it.
> > > >
> > > > > I'm able to detect the device with "sensors-detect" and "superiotool"
> > > > > utilities, also able to dump the device registers with "superiotool
> > -d".
> > > > >
> > > > > How to configure a UART port connected to this Super IO device? Is
> > there
> > > > > any other application/tool for this?
> > > > >
> > > > Per datasheet: "High Speed NS16C550 Compatible UARTs with Send/Receive
> > > > 16-Byte FIFOs". It should behave like a standard UART port.
> > > > Do you have any indication that this is not the case ?
> > > >
> > > > Thanks,
> > > > Guenter
> > > >
> >

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
