From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 20 Nov 2007 23:46:22 +0000
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Message-Id: <200711210100.43049.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4741EB91.9080000@assembler.cz> <Pine.LNX.4.44L0.0711191521170.3129-100000@iolanthe.rowland.org> <20071120131520.GC12077@jupiter.solarsys.private>
In-Reply-To: <20071120131520.GC12077@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Rudolf Marek <r.marek@assembler.cz>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <greg@kroah.com>, Kernel development list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Tuesday, 20 of November 2007, Mark M. Hoffman wrote:
> Hi all:
>=20
> * Alan Stern <stern@rowland.harvard.edu> [2007-11-19 15:27:14 -0500]:
> > On Mon, 19 Nov 2007, Rudolf Marek wrote:
> >=20
> > > Hello all,
> > > >>> gives coretemp_cpu_callback -> coretemp_device_remove ->
> > > >>> platform_device_unregister, so coretemp seems to be what I have a=
nd you don't.
> > > >=20
> > > > Yes.
> > > >=20
> > > > For the coretemp developers: coretemp_cpu_callback() needs to be mo=
re=20
> > > > careful about what it does.  During a system sleep transition (susp=
end,=20
> > > > hibernate, resume) it isn't possible to register or unregister a=20
> > > > device.  Attempts to register will fail and attempts to unregister =
will=20
> > > > block until the system sleep is over -- and for this callback that =

> > > > means hanging.
> > >=20
> > > Well I wrote the driver. Thanks for the clarification. If I recall co=
rrectly I=20
> > > looked how this part should be done from others drivers. Now while ch=
ecking
> > > what happened to the file, seems Rafael added something related.
> > >=20
> > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=8Bb7844286fb8c9fce6f65d8288aeb09d03a5e0d
> >=20
> > That does look like it was meant for exactly this sort of situation.
> >=20
> > > > It's not clear what the best way is to fix this.  Perhaps the CPU=20
> > > > notification should be sent along with a special flag indicating th=
at=20
> > > > the CPU transition is part of a system sleep (although this seems=20
> > > > racy).  Perhaps the driver should notice when a system sleep begins=
,=20
> > > > and defer all CPU-change handling until after the sleep is over.
> > >=20
> > > maybe it does exist?  CPU_DOWN_PREPARE ?
> > >=20
> > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;f=3DDocumentation/cpu-hotplug.txt;hb=3DHEAD
> > >=20
> > > Unfortunately I'm not very familiar with this, calling the=20
> > > coretemp_device_remove from CPU_DOWN_PREPARE would help? Looking at m=
icrocode=20
> > > driver, seems it just hide sysfs interface from user.
>=20
> AFAICT from that documentation, it would have been better to unregister
> the device on CPU_DOWN_PREPARE anyway.  CPU_DEAD seems to be too late -
> it's already gone by then.
>=20
> > I'm not sure exactly what you want to do here.  But it seems like a=20
> > waste to unregister the coretemp devices at the start of a system sleep=
=20
> > and then register them back at the end.
> >=20
> > Could you simply leave the devices registered throughout the entire
> > sleep?  Of course, at the end you would have to check that all the CPUs
> > really did come back up, and unregister the devices for the CPUs that
> > are still offline.
>=20
> Is it possible to unregister a driver on CPU_DOWN_PREPARE_FROZEN?

No.  In that case the suspend core is holding the device's mutex and your
attempt to unregister it will deadlock with it.

Do you _have_ _to_ unregister the device at all?  Why don't you just leave
it registered on CPU_DOWN_PREPARE_FROZEN?  The CPU is not going away
physically in this case and it's _guaranteed_ that _cpu_up() will be called=
 on
it as soon as the hibernation image is ready or we are back from suspend.

> If so, then the simplest fix would be the patch below (Jiri: feel free to
> try it). Otherwise it would take a bit of refactoring to bring the sysfs
> interface down/up for suspend/resume.
>=20
> commit ce9c7b78c839a6304696d90083eac08baad524ce
> Author: Mark M. Hoffman <mhoffman@lightlink.com>
> Date:   Tue Nov 20 07:51:50 2007 -0500
>=20
>     hwmon: (coretemp) fix suspend/resume hang
>    =20
>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

I'd do it like this:

> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 5c82ec7..afe2d31 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -338,10 +338,12 @@ static int coretemp_cpu_callback(struct notifier_bl=
ock *nfb,
>  	switch (action) {
>  	case CPU_ONLINE:
>  	case CPU_ONLINE_FROZEN:
> +	case CPU_DOWN_FAILED:
>  		coretemp_device_add(cpu);
+	case CPU_DOWN_FAILED_FROZEN:=20
>  		break;
> -	case CPU_DEAD:
> -	case CPU_DEAD_FROZEN:
> +	case CPU_DOWN_PREPARE:
>  		coretemp_device_remove(cpu);
+	case CPU_DOWN_PREPARE_FROZEN:
>  		break;
>  	}

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
