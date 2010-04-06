From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Date: Tue, 06 Apr 2010 00:41:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) Properly handle the case
Message-Id: <321257349.1551270514495494.JavaMail.root@mail.savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100403180551.4299abac@hyperion.delvare>
In-Reply-To: <20100403180551.4299abac@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

----- "Mark Brown" <broonie@opensource.wolfsonmicro.com> a =C3=A9crit :

> On Sat, Apr 03, 2010 at 06:05:51PM +0200, Jean Delvare wrote:
> > When CONFIG_REGULATOR isn't set, regulator_get_voltage() returns 0.
> > Properly handle this case by not trusting the value.
> >=20
> > Reported-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Jonathan Cameron <jic23@cam.ac.uk>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>=20
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

A big thanks and thumbs up to Mark and Jean for the followup.

Jerome Oufella

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
