From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Apr 2010 18:11:10 +0000
Subject: Re: [lm-sensors] [PATCH] lis3lv02d: provide means to disable polled
Message-Id: <20100409201110.5d75a24e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LNX.2.00.1004091453530.8345@pobox.suse.cz>
	<4BBF2BD1.5050107@tremplin-utc.net>
	<alpine.LNX.2.00.1004091532150.8345@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1004091532150.8345@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?UTF-8?B?w4lyaWM=?= Piel <eric.piel@tremplin-utc.net>, Marcin Derlukiewicz <marcin@derlukiewicz.pl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 9 Apr 2010 15:32:59 +0200 (CEST), Jiri Kosina wrote:
> On Fri, 9 Apr 2010, =C3=89ric Piel wrote:
>=20
> > > This is reported to create 20% CPU usage increase (and proportionaly =
higher
> > > power consumption) just for the ipolldevd kernel thread (which is used
> > > to read the sensor).
> > >=20
> > > As most users probably only use the freefall functionality of the dri=
ver
> > > and not the joystick interface, provide means for disabling the regis=
tration
> > > of joystick device altogether via module parameter.
> > > (I'd rather make it default to 0, but this will break backwards compa=
tibility).
> > Are you saying there is a 20% CPU usage even when the joystick interface
> > is not open? This should not happen (and this is not happening on my
> > laptop). The polling should happen only when a userspace app opens the
> > joystick interface (like running neverball).
> >=20
> > So I'd tend to think it's more due to a misconfiguration of the system
> > (like xserver using the joystick interface as a pointer device) or it's
> > a bug in the way we set up the polling. Could you investigate and let me
> > know?
>=20
> Marcin originally reported this to me.
>=20
> Marcin, could you please check 'lsof' output to see whether the joystick =

> interface has been open by some application?

I would randomly blame hal. It keeps my IR remote control device opened
all the time and I have no idea why.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
