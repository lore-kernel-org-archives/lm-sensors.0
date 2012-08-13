From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 13 Aug 2012 02:30:06 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for ADT7410
Message-Id: <20120813023006.GA13136@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5027D6B5.4020503@gmx.de>
In-Reply-To: <5027D6B5.4020503@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Aug 12, 2012 at 06:15:49PM +0200, Hartmut Knaack wrote:
> New driver for ADT7410 temperature sensor
>=20
> This patch brings basic support for the Analog Devices ADT7410 temperature
> sensor, based on the lm75 hwmon driver and the adt7410 iio driver. The fo=
llowing
> functionality has been implemented:
>=20
>   * get current temperature
>   * get/set minimum, maximum and critical temperature
>   * get/set hysteresis
>   * get alarm events for minimum, maximum and critical temperature
>=20
> All implemented sysfs-symbols have been sucessfully tested at temperature=
s of
> 15=B0C to 40=B0C.
>=20
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Applied, thanks (for the driver and for your patience ;)

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
