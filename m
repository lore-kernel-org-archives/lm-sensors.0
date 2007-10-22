From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 22 Oct 2007 16:02:37 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <191fb4ca0710220902v417f2692y485c860ffe33ba29@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,


On 10/19/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Wed, 17 Oct 2007 21:53:42 -0700, Juerg Haefliger wrote:
> > On 10/17/07, Jean Delvare <khali@linux-fr.org> wrote:
> > > On Wed, 17 Oct 2007 12:43:16 -0700, Juerg Haefliger wrote:
> > > > Aha, this is an error as a result of a dme1737 initiated write. 0x1a
> > > > means "SMBus Busy". So the dme1737 driver is colliding with somethi=
ng
> > > > else in the system that tries to talk to a chip on the same bus.
> > >
> > > This can only happen on a multi-master I2C bus, which is rather rare =
on
> > > consumer PCs. Juergen, do you have detailed technical documentation
> > > about your system? It would be interesting to find out what chip the
> > > other master is talking to. If it's the DME1737 chip, this could lead
> > > to problems.
> >
> > Hmm... What about ACPI? Couldn't it interfere with the dme1737 module
> > by going after the same resources.
>
> It could, but I just can't think of a valid reason why ACPI wouldn't
> use the nForce2 SMBus controller itself.
>
> Are you certain that the "busy" error code means that the *bus* is
> busy? Doesn't it rather mean that the *nForce SMBus controller* itself
> is busy (i.e. the previous command is still being processed)? The latter
> would indeed suggest that ACPI is running SMBus transactions in our
> back, which would be a problem. At least, if the SMBus controller lets
> us know, we'll avoid corruption, but bad things can still happen.

From the ACPI spec:
Indicates that the transaction failed because the SMBus host
reports that the SMBus is presently busy with some other
transaction. For example, the Smart Battery might be
sending charging information to the Smart Battery Charger.


> Juergen, if you load the "thermal" driver and look
> in /proc/acpi/thermal_zone, do you see a temperature reported, with the
> same value as one of the DME1737 temperature channels?
>
> If you unload the "thermal" driver, do the dme1737 write errors go away?
>
> > > Assuming that "busy" means that the nForce chip did not even attempt =
to
> > > send the message (or lost arbitration, which is equivalent), this
> > > specific error could be handled in i2c-nforce2, by retrying. The
> > > problem is that you have to decide how many times you retry, and how
> > > much time you wait between retries (there doesn't seem to be a way to
> > > test if the SMBus is busy before trying, right?)
> >
> > The i2c-nforce2 driver already spins for 10 msecs before deciding to
> > give up. I'd just retry once after that and see what happens.
>
> Depends on what kernel Juergen is running. Oleg Ryjkov has submitted
> interesting patches that clean up this part of the i2c-nforce2 driver:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;hA53549734cbdba24e9cf5eb200b70b7b1572e15
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=D49584c4a37c7228e7778bcb60f79e7a08472fa8
> These are already in Linus' tree for 2.6.24.

Hmm... These patches add abort functionality in case the controller is
locked. I don't think this is our problem here. In Juergen's case, any
subsequent transaction after one that fails succeeds so it's a
transient problem and not a hard lock.

...juerg


> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
