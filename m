From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Jan 2012 18:42:19 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120128184219.GA4443@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Jan 28, 2012 at 01:15:36PM -0500, Jean Delvare wrote:
> On Sat, 28 Jan 2012 09:34:34 -0800, Guenter Roeck wrote:
> > Maybe the perceived problem is that gain and offset are different and a=
ll over the place
> > for the various ADCs, so one either needs a whole bunch of functions, o=
r a large
> > case statement, or a table with <gain, offset> per adc. I'd choose the =
latter,
> > to simplify runtime code. Also, the description of adc->temperature con=
version
> > is really quite confusing.
>=20
> The die temperature seems to be a simple linear extrapolation, this
> should actually be fairly easy to implement.
>=20
> The battery temperature is a typical thermistor computation. It is best
> done in user-space by a libsensors configuration statement (i.e. the
> driver exports a value in mV instead of m=B0C and sensors.conf takes care
> of the conversion.)
>=20
> So I don't see anything particularly frightening here. Do you?
>=20
Not really; I didn't expect the implementation to be difficult, just unders=
tanding
the documentation.

For the battery temperature, I would prefer to report a temperature if the =
chip
is configured for it (assuming that can be detected).

At least so far we can not convert voltages to temperatures via sensors.con=
f,
or can we ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
