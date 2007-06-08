From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Fri, 08 Jun 2007 19:13:04 +0000
Subject: Re: [lm-sensors] hwmon/w83627ehf
Message-Id: <4dfa50520706081213h43d83040hc582dd53f5ecc41b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
In-Reply-To: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> On Tue, 15 May 2007 12:53:18 -0600, David Hubbard wrote:
> > On 5/15/07, Jean Delvare <khali@linux-fr.org> wrote:
> > > This confirms that the configuration space of the W83627DHG is mapped
> > > to 0x4e/0x4f. This explains the log message that you reported: the
> > > driver printed it after it failed to find a device at 0x2e/0x2f. Then
> > > it tried 0x4e/0x4f and succeeded, so the message was only a warning,
> > > not an error.
> > >
> > > The w83627ehf driver should be changed to _not_ print a message when =
the
> > > device ID reads 0xffff (or 0x0000, for that matter) as it means there
> > > is _no_ chip at this address.
> > >
> > > On top of that, the driver should _not_ print a message by default wh=
en
> > > it finds an unsupported ID. It is perfectly valid to have a W83627DHG
> > > at 0x4e/0x4f and another LPC chip at 0x2e/0x2f. I think we already
> > > heard of boards with two LPC chips, and we don't want to fill the log
> > > with irrelevant messages in that case. So I believe that the driver
> > > should only print this message when compiled with debugging enabled, =
as
> > > the w83627hf driver is doing.
> > >
> > > David, can you please submit a patch doing that?
> >
> > Yes, I'd consider it a bug when it finds an OK chip at 0x43. I'll look
> > at how w83627hf driver does it and copy that.
>
> Do you have a patch ready? A bug report now exists on kernel.org:
> http://bugzilla.kernel.org/show_bug.cgi?id=8593

Thanks for the heads up. I'm still working on getting rid of i2c-isa,
but I'll include a patch to fix this in my next update.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
