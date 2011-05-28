From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 May 2011 12:38:29 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon/sch5627: Factor our some code to
Message-Id: <20110528143829.54e34869@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 28 May 2011 09:21:23 +0200, Hans de Goede wrote:
> This patch adds a new sch56xx-common.ko which contains code which will al=
so
> be used in the new sch5636 driver.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/Kconfig          |    5 +
>  drivers/hwmon/Makefile         |    1 +
>  drivers/hwmon/sch5627.c        |  334 +++-------------------------------=
-----
>  drivers/hwmon/sch56xx-common.c |  336 ++++++++++++++++++++++++++++++++++=
++++++
>  drivers/hwmon/sch56xx-common.h |   24 +++
>  5 files changed, 390 insertions(+), 310 deletions(-)
>  create mode 100644 drivers/hwmon/sch56xx-common.c
>  create mode 100644 drivers/hwmon/sch56xx-common.h
> (...)
> --- /dev/null
> +++ b/drivers/hwmon/sch56xx-common.c
> (...)
> +#define SIO_SCH56XX_LD_EM	0x0C	/* Embedded =C5=B3Controller Logical Dev =
*/

A regular "u" will do... I don't know you used but that wasn't even a
Greek mu.


All the rest looks pretty good.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
