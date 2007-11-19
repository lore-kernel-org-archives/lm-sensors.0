From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 19 Nov 2007 21:53:40 +0000
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Message-Id: <200711192253.41532.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44L0.0711182156330.22727-100000@netrider.rowland.org> <4741EB91.9080000@assembler.cz>
In-Reply-To: <4741EB91.9080000@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, lm-sensors@lm-sensors.org

On Monday, 19 of November 2007, Rudolf Marek wrote:
> Hello all,
> >>> gives coretemp_cpu_callback -> coretemp_device_remove ->
> >>> platform_device_unregister, so coretemp seems to be what I have and y=
ou don't.
> >=20
> > Yes.
> >=20
> > For the coretemp developers: coretemp_cpu_callback() needs to be more=20
> > careful about what it does.  During a system sleep transition (suspend,=
=20
> > hibernate, resume) it isn't possible to register or unregister a=20
> > device.  Attempts to register will fail and attempts to unregister will=
=20
> > block until the system sleep is over -- and for this callback that=20
> > means hanging.
>=20
> Well I wrote the driver. Thanks for the clarification. If I recall correc=
tly I=20
> looked how this part should be done from others drivers. Now while checki=
ng
> what happened to the file, seems Rafael added something related.
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h=8Bb7844286fb8c9fce6f65d8288aeb09d03a5e0d

Well, in principle you can use the observation that the _FROZEN versions
are used during suspend/hibernation.  Thus, if you only unregister the devi=
ce
for CPU_DEAD, but you won't do that for CPU_DEAD_FROZEN, it will work as lo=
ng
as the freezer is there.

> > It's not clear what the best way is to fix this.  Perhaps the CPU=20
> > notification should be sent along with a special flag indicating that=20
> > the CPU transition is part of a system sleep (although this seems=20
> > racy).

In fact, it's already done that way and I don't think it's racy (see above).

Greetings,
Rafael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
