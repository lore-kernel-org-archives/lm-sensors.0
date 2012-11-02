From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Nov 2012 03:09:00 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121102030900.GA9054@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Nov 01, 2012 at 02:18:53PM -0700, Phil Pokorny wrote:
> On Thu, Nov 1, 2012 at 1:54 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> > On Thu, Nov 01, 2012 at 07:12:08PM +0100, Jean Delvare wrote:
> > > On Thu, 1 Nov 2012 10:17:07 -0700, Guenter Roeck wrote:
> > > > On Thu, Nov 01, 2012 at 05:37:57PM +0100, Jean Delvare wrote:
> > > > > On an IT8720F chip with temp3 configured for PECI:
> > > > >
> > > > > temp1_offset: 0
> > > > > temp2_offset: 0
> > > > > temp3_offset: -128000
> > > > >
> > > > > I'm unsure how to interpret this -128000... This value is definit=
ely
> > > > > not neutral, doesn't sound very realistic. I would expect a posit=
ive
> > > > > number for PECI. Maybe the offset register should be treated as
> > > > > unsigned in PECI mode? Or maybe its value is irrelevant for the
> > IT8720F
> > > > > in PECI mode.
> > > > >
> > > > > # grep . /sys/class/hwmon/hwmon2/device/temp3*
> > > > > /sys/class/hwmon/hwmon2/device/temp3_alarm:0
> > > > > /sys/class/hwmon/hwmon2/device/temp3_beep:1
> > > > > /sys/class/hwmon/hwmon2/device/temp3_input:25000
> > > > > /sys/class/hwmon/hwmon2/device/temp3_max:70000
> > > > > /sys/class/hwmon/hwmon2/device/temp3_min:127000
> > > > > /sys/class/hwmon/hwmon2/device/temp3_offset:-128000
> > > > > /sys/class/hwmon/hwmon2/device/temp3_type:6
> > > > >
> > > > > This is with an it87 driver including all your recent patches. It=
 you
> > > > > have ideas or theories, I'm interested.
> > > > >
> > > > Hi Jean,
> > > >
> > > > I agree. The alternative (+128 degrees C) sounds a bit high, though.
> > > > Maybe there is another register on IT8720F to store Tjmax ? Did you
> > check
> > > > in the register map if there is a register value that happens to ma=
tch
> > it ?
> > >
> > > How would I know which value I am looking for? k10temp says this:
> > > high =3D +70.0=B0C, crit =3D +90.0=B0C, hyst =3D +87.0=B0C
> > > but the monitored value doesn't match it87's temp3.
> >
>=20
>=20
> > I don't know what AMD uses as equivalent of Tjmax - maybe they
> > use a fixed value of 128=B0C.
> >
>=20
> Wouldn't it be 70 degC?  That's the "Tcontrol" value they always
> reference.  Anything over 70deg C on the "Tcontrol" scale is "HOT"
>=20
One would think so, but that doesn't fit with Jean's observation that he ha=
s to
enter -128 degC (or possibly 128 degC) for a decent temperature reading.

Jean, does the temperature increase if you put load onto the system ?
And which value in temp3_offset makes the reported temperature match the
temperature reported by k10temp ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
