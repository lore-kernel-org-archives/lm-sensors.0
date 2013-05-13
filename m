From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 13 May 2013 14:56:26 +0000
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect function
Message-Id: <20130513145626.GA4795@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130212164811.GV8668@pengutronix.de>
 <3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com>
 <20130508175417.GB29689@roeck-us.net>
 <FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com>
 <20130509035313.GA26817@roeck-us.net>
 <3322BACE-9434-4249-8621-C1AD0D340A8A@gmail.com>
 <20130513101150.0c9e4d30@endymion.delvare>
 <E43DA0E6-A130-4837-8343-EEC182A12EE6@gmail.com>
 <20130513161413.58ebc9e8@endymion.delvare>
In-Reply-To: <20130513161413.58ebc9e8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: =?iso-8859-1?Q?Jean-Fran=E7ois?= Dagenais <jeff.dagenais-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org

On Mon, May 13, 2013 at 04:14:13PM +0200, Jean Delvare wrote:
> On Mon, 13 May 2013 09:54:47 -0400, Jean-Fran=E7ois Dagenais wrote:
> > Salut Jean, merci de participer!
> >=20
> > On 2013-05-13, at 4:11 AM, Jean Delvare wrote:
> >=20
> > >=20
> > > Guenter is right. You never have to disable auto-detection in the sla=
ve
> > > drivers (jc42 etc.) All these slave drivers do is claim "I _can_ do
> > > auto-detection", not "I _will_ do auto-detection." It's always up to =
the
> > > I2C adapter driver, whether auto-detection will happen or not. And it
> > > is disabled by default. So if you don't want it, just do not enable it
> > > in the bus driver. You can even set it per adapter, when the driver
> > > controls more than one adapter, and per bus segment, when multiplexing
> > > is taking place.
> >=20
> > I am just wondering where the clean hook is for doing this. From what I=
 can
> > gather, the master driver(s I've seen) declare ".class =3D I2C_CLASS_HW=
MON |
> > I2C_CLASS_SPD," pretty statically. Is it just that they are missing this
> > flexibility? Something along the lines of patching the pdata of such a =
master
> > driver to provide a 'class' variable in pdata?
>=20
> Yes, exactly.
>=20
Or use devicetree, which is quite prevalent in embedded systems nowadays.

Guenter

> > If so, one would have to take
> > into account the existing users of the master which expect the previous=
 class
> > setting which may not be '0', thus requiring patching the existing upst=
reamed
> > users...  Suggestions?
>=20
> Yes, you have to do something like that. The static class declarations
> come from the PC world drivers where they (almost) never change.
> Embedded systems definitely want a per-bus decision and should avoid
> static declarations as much as possible. Especially when in most cases
> they know exactly what slaves they are so they don't need
> auto-detection. There's a reason why auto-detection is an optional
> feature...
>=20
> --=20
> Jean Delvare
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
