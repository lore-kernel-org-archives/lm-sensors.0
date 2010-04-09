From: Jiri Kosina <jkosina@suse.cz>
Date: Fri, 09 Apr 2010 13:32:59 +0000
Subject: Re: [lm-sensors] [PATCH] lis3lv02d: provide means to disable polled
Message-Id: <alpine.LNX.2.00.1004091532150.8345@pobox.suse.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LNX.2.00.1004091453530.8345@pobox.suse.cz> <4BBF2BD1.5050107@tremplin-utc.net>
In-Reply-To: <4BBF2BD1.5050107@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Samu Onkalo <samu.p.onkalo@nokia.com>, Pavel Machek <pavel@ucw.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Marcin Derlukiewicz <marcin@derlukiewicz.pl>

On Fri, 9 Apr 2010, =C9ric Piel wrote:

> > This is reported to create 20% CPU usage increase (and proportionaly hi=
gher
> > power consumption) just for the ipolldevd kernel thread (which is used
> > to read the sensor).
> >=20
> > As most users probably only use the freefall functionality of the driver
> > and not the joystick interface, provide means for disabling the registr=
ation
> > of joystick device altogether via module parameter.
> > (I'd rather make it default to 0, but this will break backwards compati=
bility).
> Are you saying there is a 20% CPU usage even when the joystick interface
> is not open? This should not happen (and this is not happening on my
> laptop). The polling should happen only when a userspace app opens the
> joystick interface (like running neverball).
>=20
> So I'd tend to think it's more due to a misconfiguration of the system
> (like xserver using the joystick interface as a pointer device) or it's
> a bug in the way we set up the polling. Could you investigate and let me
> know?

Marcin originally reported this to me.

Marcin, could you please check 'lsof' output to see whether the joystick=20
interface has been open by some application?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
