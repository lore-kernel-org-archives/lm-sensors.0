From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 05 Jul 2007 16:19:34 +0000
Subject: Re: [lm-sensors] [PATCH] Add LM93 support
Message-Id: <20070705161934.GU3516@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704131723.42773.hjk@linutronix.de>
In-Reply-To: <200704131723.42773.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans-J=FCrgen Koch <hjk@linutronix.de> [2007-07-05 17:58:29 +0200]:
> Am Donnerstag 05 Juli 2007 15:37 schrieb Mark M. Hoffman:
>=20
> > >=20
> > > 1.) I replaced pwmN_override with pwmN_enable.
> >=20
> > 1825         case 0:
> > 1826                 ctl2 |=3D 0x01; /* enable manual override */
> > 1827                 ctl2 &=3D 0x0F; /* set PWM to zero */
> > 1828                 break;
> >=20
> > No... the value 0 must turn the fan full-on, not off.  Sorry if I was n=
ot
> > clear about that in my review comments.
> >=20
> > See also: Documentation/hwmon/sysfs_interface.
>=20
> Quote from there:
>=20
> pwm[1-*]_enable
> 		Switch PWM on and off.
> 		Not always present even if pwmN is.
> 		0: turn off
> 		1: turn on in manual mode
> 		2+: turn on in automatic mode
>=20
> But checking my max6650 sources, I find that there we also said that
> 0 means "always on". Very confusing.
>=20
> OK, I changed the patch, see below.=20
>=20
> And I'll send a patch to make Documentation/hwmon/sysfs-interface
> clearer. This is the second time it fools me.

Heh, notice the most recent patch in my testing tree...
http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dshortlog=
;h=3Dtesting

I meant for you to check the docs in *my* tree, haha.  Sorry 'bout that.

I'll apply your lm93 patch this evening.

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
