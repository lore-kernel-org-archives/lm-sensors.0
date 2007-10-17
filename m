From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 17 Oct 2007 19:43:16 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710171243x379a2003sc6bbc198fbcdc773@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,


On 10/17/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
> Jean, Juerg,
>
>
> > -----Urspr=FCngliche Nachricht-----
> > Von: "Juerg Haefliger" <juergh@gmail.com>
> > Gesendet: 09.10.07 18:08:33
> > An: "Jean Delvare" <khali@linux-fr.org>
> > CC: lm-sensors@lm-sensors.org
> > Betreff: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
>
>
> > > >
> > > > not much information:
> > > > /var/log/messages.0:Oct  4 00:17:43 lisa kernel: dme1737 0-002e: Wr=
ite to register 0x30 failed (-1)! Please report to the driver maintainer.
> > >
> > > As I expected...
> > >
> > > > i2c_nforce2             7232  0
> >
> > Yes, I looked at the driver and it indeed only returns -1 on error.
> >
> > > Juerg, you could patch i2c-nforce2 to return more useful error codes.
> > > Such a patch could go upstream. Alternatively, building the i2c-nforc=
e2
> > > driver with CONFIG_I2C_DEBUG_BUS=3Dy may provide some hints.
> >
> > I was thinking of doing that. First I have to try to recreate the
> > problem on my machine.
> >
> > Juergen: Do you feel like recompiling i2c_nforce2 with debugging enable=
d?
> >
>
> Here is what I found in /var/log:
>
> /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: nForce2=
 SMBus adapter at 0x4c00
> /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: nForce2=
 SMBus adapter at 0x4c40
> /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: Found a=
 DME1737 chip at 0x2e (rev 0x8a)
>
> /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Time=
out! (0x10)
> /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Time=
out! (0x10)
> /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: SMBus Time=
out! (0x10)

These are all errors that occur when the drivers (i2c and dme1737) get
loaded. The dme1737 is not printing any errors so they are not
transactions initiated by the dme1737. The 0x10 means "SMBus Device
Address Not Acknowledged" according to the ACPI spec. Not sure how
this can happen... Signal integrity problems on the board level? In
any case, these errors should probably be retried. Not sure at what
level though. Jean?


> /var/log/debug:Oct 17 19:35:30 lisa kernel: i2c_adapter i2c-0: SMBus Time=
out! (0x1a)
>
> /var/log/messages:Oct 17 09:16:00 lisa kernel: dme1737 0-002e: Optional f=
eatures: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=3Dyes, fan5=3Dno=
, fan6=3Dno.
> /var/log/messages:Oct 17 19:35:30 lisa kernel: dme1737 0-002e: Write to r=
egister 0x30 failed (-1)! Please report to the driver maintainer.

Aha, this is an error as a result of a dme1737 initiated write. 0x1a
means "SMBus Busy". So the dme1737 driver is colliding with something
else in the system that tries to talk to a chip on the same bus. That
should definitely get retried. I can certainly do that at the dme1737
level but I don't think that's the right place. Jean?

...juerg



> Juergen
> _______________________________________________________________________
> Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
> kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
