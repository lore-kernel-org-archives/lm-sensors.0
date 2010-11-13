From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 13 Nov 2010 14:40:21 +0000
Subject: Re: [lm-sensors] Location for thermal drivers
Message-Id: <20101113144021.GA29753@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289594026.22931.388.camel@groeck-laptop>
 <AANLkTimERGh2yGGX_E_N4ajxg_-0QTFS54QSKj2+AAfF@mail.gmail.com>
 <1289599600.22931.406.camel@groeck-laptop>
 <AANLkTikPt09Xdr_wvjmXhdPD8UdA-7b=AJjC+zgn8PA4@mail.gmail.com>
In-Reply-To: <AANLkTikPt09Xdr_wvjmXhdPD8UdA-7b=AJjC+zgn8PA4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Phil Pokorny <ppokorny@penguincomputing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sat, Nov 13, 2010 at 02:21:58AM -0500, Phil Pokorny wrote:
> On Fri, Nov 12, 2010 at 2:06 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Fri, 2010-11-12 at 16:53 -0500, Phil Pokorny wrote:
> >> On Fri, Nov 12, 2010 at 12:33 PM, Guenter Roeck
> >> <guenter.roeck@ericsson.com> wrote:
> >> > I think a better location for the driver would be drivers/thermal.
> >> > drivers/hwmon is not really a good fit, since hwmon support for ther=
mal
> >> > drivers is optional.
> >>
> >> What is the difference between a "thermal" sensor and a "temperature"
> >> sensor? =A0Aren't they the same thing?
> >>
> > The thermal framework is much more extensive than the hwmon framework.
> > See Documentation/thermal/sysfs-api.txt for details.
>=20
> Ahh...  Sorry for wasting your time without reading the necessary
> background first.  I have rectified this oversight.
>=20
> Reading the thermal sysfs-api and code, it's seems clear that it is a
> very ACPI centric kind of thing.  It's involved in the coordination of
> temperatures and the ways (fans, throttle algorithms, etc.) to keep
> them in check.  It makes regular calls into the ACPI parser to
> evaluate values.
>=20
> But this driver that Alan has written seems to be a hwmon driver.
> It's poking at registers, setting up A2D channels and dealing with
> thermistors and perhaps voltages?  Those are very hwmon like things
> for a driver to do.
>=20
> It appears to be very similar to the coretemp and k10temp drivers that
> read temperatures from the internals of the CPU.
>=20
If the driver would use the hwmon framework, yes. However, it uses the ther=
mal
framework, in which hwmon support is optional.

The thermal framework itself is acpi independent. There is no single
acpi call in the thermal framework code. acpi use may be true for the=20
drivers currently registering with the thermal framework, but that
doesn't mean that the thermal framework itself in any way depends on=20
or is only supposed to be used with ACPI devices. ACPI is only referenced
in the documentation as example.

If the thermal framework were to be used for acpi devices only, it would
presumably reside in drivers/acpi and not be independent.

So your reasoning isn't really correct. Putting thermal drivers into=20
the hwmon directory doesn't really make sense. hwmon functionality
is an optional subset of thermal drivers, but that does not mean
that thermal drivers _are_ hwmon drivers.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
