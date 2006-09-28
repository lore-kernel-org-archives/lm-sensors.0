From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:30 +0000
Subject: [lm-sensors] [PATCH 10/39] it87: Cleanup set_fan_div
Message-Id: <11594837701727-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

it87: Cleanup set_fan_div

We only change one fan clock divider at a time, so there is only one
fan min which needs to be saved and restored.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/it87.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index bfad897..e9ab8a3 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -564,14 +564,14 @@ static ssize_t set_fan_div(struct device
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
@@ -591,10 +591,10 @@ static ssize_t set_fan_div(struct device
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
1.4.2.1


