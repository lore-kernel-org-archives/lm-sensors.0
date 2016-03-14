From: Eduardo Valentin <edubezval@gmail.com>
Date: Mon, 14 Mar 2016 19:49:46 +0000
Subject: Re: [lm-sensors] [PATCH 04/13] hwmon: convert scpi-hwmon to use devm_thermal_zone_of_sensor_register
Message-Id: <20160314194945.GG1872@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3741305908428592184=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-5-git-send-email-edubezval@gmail.com>
 <56E0DBFD.7060903@roeck-us.net>
In-Reply-To: <56E0DBFD.7060903@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>


--===============3741305908428592184==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 06:29:17PM -0800, Guenter Roeck wrote:
> On 03/09/2016 01:35 PM, Eduardo Valentin wrote:
> >This changes the driver to use the devm_ version
> >of thermal_zone_of_sensor_register and cleans
> >up the  local points and unregister calls.
> >
> >Cc: Jean Delvare <jdelvare@suse.com>
> >Cc: Guenter Roeck <linux@roeck-us.net>
> >Cc: lm-sensors@lm-sensors.org
> >Cc: linux-kernel@vger.kernel.org
> >Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> >---
> >  drivers/hwmon/scpi-hwmon.c | 41 ++++++++------------------------------=
---
> >  1 file changed, 8 insertions(+), 33 deletions(-)
> >
> >diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> >index 7e20567..2309e47 100644
> >--- a/drivers/hwmon/scpi-hwmon.c
> >+++ b/drivers/hwmon/scpi-hwmon.c
> >@@ -31,10 +31,8 @@ struct sensor_data {
> >  };
> >
> >  struct scpi_thermal_zone {
> >-	struct list_head list;
> >  	int sensor_id;
> >  	struct scpi_sensors *scpi_sensors;
> >-	struct thermal_zone_device *tzd;
> >  };
> >
> >  struct scpi_sensors {
> >@@ -92,20 +90,6 @@ scpi_show_label(struct device *dev, struct device_att=
ribute *attr, char *buf)
> >  	return sprintf(buf, "%s\n", sensor->info.name);
> >  }
> >
> >-static void
> >-unregister_thermal_zones(struct platform_device *pdev,
> >-			 struct scpi_sensors *scpi_sensors)
> >-{
> >-	struct list_head *pos;
> >-
> >-	list_for_each(pos, &scpi_sensors->thermal_zones) {
> >-		struct scpi_thermal_zone *zone;
> >-
> >-		zone =3D list_entry(pos, struct scpi_thermal_zone, list);
> >-		thermal_zone_of_sensor_unregister(&pdev->dev, zone->tzd);
> >-	}
> >-}
> >-
> >  static struct thermal_zone_of_device_ops scpi_sensor_ops =3D {
> >  	.get_temp =3D scpi_read_temp,
> >  };
> >@@ -224,6 +208,7 @@ static int scpi_hwmon_probe(struct platform_device *=
pdev)
> >  	INIT_LIST_HEAD(&scpi_sensors->thermal_zones);
> >  	for (i =3D 0; i < nr_sensors; i++) {
> >  		struct sensor_data *sensor =3D &scpi_sensors->data[i];
> >+		struct thermal_zone_device *z;
> >  		struct scpi_thermal_zone *zone;
> >
> >  		if (sensor->info.class !=3D TEMPERATURE)
> >@@ -232,42 +217,33 @@ static int scpi_hwmon_probe(struct platform_device=
 *pdev)
> >  		zone =3D devm_kzalloc(dev, sizeof(*zone), GFP_KERNEL);
> >  		if (!zone) {
> >  			ret =3D -ENOMEM;
> >-			goto unregister_tzd;
> >+			goto mfail;
>=20
> 			return -ENOMEM;
>=20
> ... and drop the unnecessary label.

True. I will change as requested.

Thanks


--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5xXVAAoJEMLUO4d9pOJW6poH/1ffws8u4lxp7CLo0q/7A+/Y
vhfwm78PDxNzimEh8owH1F8eIdgi30+9s2h0AThsU2qwzzgsvw3z2LID3Z5YyCQk
atQKjj0ykH/FrzR3cpc7aGsb8s+r9xcdS0R/tzEfywxG5wDKlMLsP+zAxJHHIM2L
M2C+H+0BQxz/yrhzK9eSMQwwXqKEb0MdsaXDqxMaeJzSgpl38HOwS76NwnZPkdmI
72ymPBQ5Q4PvjWt5sMP8//VolHjpbY3ZqOBdFolV/bN5GsLNyj/tHlhnOm5B/pWT
5dhpRo6DWH9CeJNRGNXBOb7oHVNjgN9rz9FiKrHnqXH4cqS1JZK1vHOkzJwNhHg=
=1nTO
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--


--===============3741305908428592184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3741305908428592184==--
