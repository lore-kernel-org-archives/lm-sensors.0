From: Alan Stern <stern@rowland.harvard.edu>
Date: Mon, 19 Nov 2007 20:27:14 +0000
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Message-Id: <Pine.LNX.4.44L0.0711191521170.3129-100000@iolanthe.rowland.org>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <4741EB91.9080000@assembler.cz>
References: <4740BC36.2070200@gmail.com>
In-Reply-To: <4740BC36.2070200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, lm-sensors@lm-sensors.org

On Mon, 19 Nov 2007, Rudolf Marek wrote:

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

That does look like it was meant for exactly this sort of situation.

> > It's not clear what the best way is to fix this.  Perhaps the CPU=20
> > notification should be sent along with a special flag indicating that=20
> > the CPU transition is part of a system sleep (although this seems=20
> > racy).  Perhaps the driver should notice when a system sleep begins,=20
> > and defer all CPU-change handling until after the sleep is over.
>=20
> maybe it does exist?  CPU_DOWN_PREPARE ?
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dbl=
ob;f=3DDocumentation/cpu-hotplug.txt;hb=3DHEAD
>=20
> Unfortunately I'm not very familiar with this, calling the=20
> coretemp_device_remove from CPU_DOWN_PREPARE would help? Looking at micro=
code=20
> driver, seems it just hide sysfs interface from user.

I'm not sure exactly what you want to do here.  But it seems like a=20
waste to unregister the coretemp devices at the start of a system sleep=20
and then register them back at the end.

Could you simply leave the devices registered throughout the entire
sleep?  Of course, at the end you would have to check that all the CPUs
really did come back up, and unregister the devices for the CPUs that
are still offline.

Alan Stern


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
