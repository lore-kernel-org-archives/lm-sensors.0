From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Oct 2009 09:43:13 +0000
Subject: Re: [lm-sensors] [PATCH v5] [hwmon] add Freescale MC13783 adc driver
Message-Id: <20091009114313.5c3a8666@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1255079811-15436-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1255079811-15436-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Uwe,

On Fri,  9 Oct 2009 11:16:51 +0200, Uwe Kleine-K=F6nig wrote:
> From: Luotao Fu <l.fu@pengutronix.de>
>=20
> This driver provides support for the ADC integrated into the
> Freescale MC13783 PMIC.
>=20
> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> Hello again,
>=20
> just found an uncommited change in the tested driver.
>=20
> Sorry for the inconvenience.
>=20
> Best regards
> Uwe
>=20
> Changes since v4:
>=20
> - remove unused function mc13783_adc_read_raw
>=20
> Changes since v3a:
>=20
> - remove units from sysfs files and round to integer
> - undo zero padding of the sysfs device entries
> - make some variables static
> - some naming fixes (e.g. s/-/_/ for the content of name)
> - use ASCII-only for Documentation/hwmon/mc13783
> - don't include unneeded headers
> - some style fixes requested by Jean Delvare
> - move probe function to .init.text
> - set platform driver data earlier to fix race condition
>=20
> Changes since v3:
>=20
> - remove channels 0, 1, 3 and 4 as reading them needs more work
> - report actual voltages not raw values
> - some cosmetics
> - zero pad the sysfs device entries
>=20
> Changes since v2:
>=20
> - Add Documentation Documentation/hwmon/mc13783
> - use sysfs_create_group
>=20
> Changes since v1:
>=20
> - add MODULE_ALIAS
> - __init -> __devinit in probe function
> - use platform_driver_probe instead of platform_driver_register
>=20
> ---
>  Documentation/hwmon/mc13783_adc |   50 +++++++++
>  drivers/hwmon/Kconfig           |    6 +
>  drivers/hwmon/Makefile          |    1 +
>  drivers/hwmon/mc13783-adc.c     |  225 +++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 282 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/mc13783_adc
>  create mode 100644 drivers/hwmon/mc13783-adc.c

Looks good this time. Patch applied, scheduled for kernel 2.6.33.

> Now calling sensors I get:
>=20
> 	mc13783_adc-isa-0000
> 	Adapter: ISA adapter
> 	in2:         +4.32 V
> 	in5:         +0.00 V
> 	in6:         +0.00 V
> 	in7:         +0.00 V
> 	in8:         +0.00 V
> 	in9:         +0.00 V
> 	in10:        +0.00 V
> 	in11:        +0.00 V
> 	in12:        +0.52 V
> 	in13:        +0.47 V
> 	in14:        +0.47 V
> 	in15:        +0.01 V
>=20
> I wonder why the name contains "isa".  Is this something I need to fix
> in the driver?

No, it's fine. libsensors names "isa" all platform devices, for
historical compatibility reasons.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
