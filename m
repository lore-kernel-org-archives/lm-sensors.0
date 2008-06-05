From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jun 2008 06:27:14 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <20080605082714.1972c3c1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost>
	<4846EBF5.2030406@tremplin-utc.net>
	<20080604225830.1dff64fc@hyperion.delvare>
	<48471DF1.70505@tremplin-utc.net>
In-Reply-To: <48471DF1.70505@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?B?yXJpYw==?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

Hi Eric,

On Thu, 05 Jun 2008 00:57:53 +0200, =C9ric Piel wrote:
> 04-06-08 22:58, Jean Delvare wrote/a =E9crit:
> > If you didn't receive any answer, my guess is that it's because you're
> > trying to add this driver to the wrong tree. Why would this driver go
> > in drivers/hwmon and be reviewed by hwmon folks, when it doesn't expose
> > a single hwmon attribute to user-space?
> >=20
> > I guess you thought putting the driver there would be fine because
> > that's where the hdaps and ams drivers are, but IMHO the hdaps and ams
> > drivers should never have been placed in drivers/hwmon. These devices
> > really aren't hardware monitoring chips is the traditional sense of the
> > term. They are different chips, serving different purposes and
> > deserving a totally different interface. They'd better live in a
> > different subsystem and be maintainer by a different crew with interest
> > in these devices and hardware to test the drivers.
> >=20
> > This discussion thread might sched some light on a possible approach:
> > http://marc.info/?l=3Dlm-sensors&m=121127824726050&w=3D2
> >=20
> > So my advice is that you don't wait for a review from the hwmon people,
> > because apparently we don't have much interest in this type of device,
> > so you'll be waiting forever. You're much better adding the mdps driver
> > to drivers/misc through Andrew Morton, at least until someone takes
> > care of creating a subsystem for this type of devices and move all
> > existing drivers there.
>
> I understand your argumentation. Indeed, this driver has nothing
> specially related to hwmon, excepted that all the other accelerometers
> so far have been put in hwmon. I've got nothing against redoing the
> patch to move the code to drivers/misc. Andrew, would you accept it?
>=20
> > Would someone object to moving the hdaps and ams (and possibly
> > applesmc) drivers to drivers/misc?
>
> Yeah, applesmc seems a bit less obvious because it also exposes really
> some hardware sensors. Any idea how to handle this? Just leave it in
> hwmon for now?

There are already other drivers in this case:
drivers/thermal/thermal_sys.c, drivers/misc/eeepc-laptop.c,
drivers/misc/thinkpad_acpi.c and drivers/input/touchscreen/ads7846.c.
All these drivers have multiple functions, one of them is hardware
monitoring but that's not the main one, so they didn't go under
drivers/hwmon. The applesmc driver would simply be one more driver in
this case.

Note that drivers/mfd is a possible alternative to drivers/misc for
these multifunction chips.

> So, the rational about moving all these drivers to drivers/misc/ would
> be that it shows they have no relation with hwmon, and they are
> maintained separately. This would be a temporary place until the
> "accelerometer" subsystem exists by it own, right?
> If everyone is happy with this idea, I can submit a separate patch to
> move them.

I'm fine with moving the drivers right now, yes.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
