From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:35:46 +0000
Subject: [lm-sensors] [PATCH 08/14] it87: Cleanup set_fan_div
Message-Id: <20060828143546.9d439cf8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=3Dhwmon-it87-set-fan-div.patch

it87: Cleanup set_fan_div

We only change one fan clock divider at a time, so there is only one
fan min which needs to be saved and restored.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/it87.c	2006-08-27 22:59:10.00000000=
0 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/it87.c	2006-08-27 23:00:44.000000000 +02=
00
@@ -563,14 +563,14 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
-	int i, min[3];
+	int min;
 	u8 old;
=20
 	mutex_lock(&data->update_lock);
 	old =3D it87_read_value(client, IT87_REG_FAN_DIV);
=20
-	for (i =3D 0; i < 3; i++)
-		min[i] =3D FAN_FROM_REG(data->fan_min[i], DIV_FROM_REG(data->fan_div[i])=
);
+	/* Save fan min limit */
+	min =3D FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
=20
 	switch (nr) {
 	case 0:
@@ -590,10 +590,10 @@
 		val |=3D 0x1 << 6;
 	it87_write_value(client, IT87_REG_FAN_DIV, val);
=20
-	for (i =3D 0; i < 3; i++) {
-		data->fan_min[i]=FAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
-		it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
-	}
+	/* Restore fan min limit */
+	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+
 	mutex_unlock(&data->update_lock);
 	return count;
 }

--=20
Jean Delvare

