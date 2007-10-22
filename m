From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 22 Oct 2007 16:05:53 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710220905g487f5f35u45e1ea0e69b6b948@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,


On 10/20/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
>
> > Von: Jean Delvare <khali@linux-fr.org>
> > Gesendet: 17.10.07 23:32:28
> >
> > On Wed, 17 Oct 2007 12:43:16 -0700, Juerg Haefliger wrote:
> > > On 10/17/07, Juergen Bausa <Juergen.Bausa@web.de> wrote:
> > > > Here is what I found in /var/log:
> > > >
> > > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: n=
Force2 SMBus adapter at 0x4c00
> > > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: n=
Force2 SMBus adapter at 0x4c40
> > > > /var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: F=
ound a DME1737 chip at 0x2e (rev 0x8a)
> > > >
> > > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBu=
s Timeout! (0x10)
> > > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBu=
s Timeout! (0x10)
> > > > /var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: SMBu=
s Timeout! (0x10)
> > >
> > > These are all errors that occur when the drivers (i2c and dme1737) get
> > > loaded. The dme1737 is not printing any errors so they are not
> > > transactions initiated by the dme1737. The 0x10 means "SMBus Device
> > > Address Not Acknowledged" according to the ACPI spec. Not sure how
> > > this can happen... Signal integrity problems on the board level? In
> > > any case, these errors should probably be retried. Not sure at what
> > > level though. Jean?
> >
> > These are not errors at all, it's only i2c-core probing at work. The
> > dme1737 driver specifies three possible addresses (0x2c, 0x2d, 0x2e),
> > the probes at 0x2c and 0x2d on bus 0 fail, these are the first two
> > "SMBus Timeout!" messages above. Then the probe at 0x2e succeeds. Then
> > i2c-core goes on with bus 1. There should have been 3 failing probes
> > there, but surprisingly, there's only one "SMBus Timeout!" for bus 1. I
> > can't explain it.
>
> I greped the mesages. Maybe, there was a 'message repeated xx times' in t=
he log, that wasnt displayed.
>
> >
> > Juergen, can you please attach the output of:
> >
> > modprobe i2c-dev
> > i2cdetect -y 0
> > i2cdetect -y 1
>
> lisa:/home/jba# modprobe i2c-dev
> lisa:/home/jba# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- 0d -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --
> 30: 30 31 -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> lisa:/home/jba# i2cdetect -y 1
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> lisa:/home/jba#
>
>
> >
> > Either way these 3 log messages can safely be ignored.
> >
> > > > /var/log/debug:Oct 17 19:35:30 lisa kernel: i2c_adapter i2c-0: SMBu=
s Timeout! (0x1a)
> > > >
> > > > /var/log/messages:Oct 17 09:16:00 lisa kernel: dme1737 0-002e: Opti=
onal features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=3Dyes, fan=
5=3Dno, fan6=3Dno.
> > > > /var/log/messages:Oct 17 19:35:30 lisa kernel: dme1737 0-002e: Writ=
e to register 0x30 failed (-1)! Please report to the driver maintainer.
> > >
> > > Aha, this is an error as a result of a dme1737 initiated write. 0x1a
> > > means "SMBus Busy". So the dme1737 driver is colliding with something
> > > else in the system that tries to talk to a chip on the same bus.
> >
> > This can only happen on a multi-master I2C bus, which is rather rare on
> > consumer PCs. Juergen, do you have detailed technical documentation
> > about your system? It would be interesting to find out what chip the
> > other master is talking to. If it's the DME1737 chip, this could lead
> > to problems.
>
> No. I dont have detailes information. Its an asus barebone.
>
> Asus borads have a feature called 'ASUS Q-Fan Technology'. Its a BIOS-bas=
ed controller for the
> FAN/CPU-temperature. This is turned on in the bios. However, when booting=
 linux, the script
> 'fancontrol' is started and then controls cpu-temperature. Maybe the Q-fa=
n still tries to access
> the fan and this is the reason for the collision?

I don't think so. It's just a setting that tells the BIOS to setup the
dme1737 for automatic fan control. After that it won't touch the
dme1737 again. I have a barebone with the same feature.

...juerg



> >
> > >                                                                  That
> > > should definitely get retried. I can certainly do that at the dme1737
> > > level but I don't think that's the right place. Jean?
> >
> > Assuming that "busy" means that the nForce chip did not even attempt to
> > send the message (or lost arbitration, which is equivalent), this
> > specific error could be handled in i2c-nforce2, by retrying. The
> > problem is that you have to decide how many times you retry, and how
> > much time you wait between retries (there doesn't seem to be a way to
> > test if the SMBus is busy before trying, right?)
> >
> > We have "timeout" and "retries" fields in struct i2c_adapter, which
> > could be used for this. The meaning of "retries" is a bit different
> > though, it's supposed to be the number of nacks the bus driver accepts
> > when attempting to contact a chip before giving up. This doesn't appear
> > to be very useful though so I wouldn't mind recycling this field for
> > the more interesting usage you need. Most bus drivers don't set nor use
> > "timeout".
> >
> > As a first aid solution, you could simply hardcode the timeout and
> > retry values, just to confirm that it solves Juergen's problem. Then
> > we can see how to make it cleaner. Error handling is an area where the
> > i2c subsystem needs to be improved.
> >
>
> Just to make it clear: The messages are no real problem. fancontrol is wo=
rking very fine.
> Maybe its not successful in setting fan speed sometimes (once a day). But=
 it just sets thge
> fan speed in the next iteration 5 seconds later. Thats no problem.
>
> However,  I am also interested in the solution of this.
>
> Juergen
>
> __________________________________________________________________________
> Erweitern Sie FreeMail zu einem noch leistungsst=E4rkeren E-Mail-Postfach!
> Mehr Infos unter http://produkte.web.de/club/?mc=021131
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
