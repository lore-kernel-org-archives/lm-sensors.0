From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH add set_value locking
Message-Id: <gvh94190nsjcg0gq723ftvf8dmm1nn268p@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
In-Reply-To: <1uc941199l784l0uij33lhigg19qm366f3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 26 Mar 2005 12:02:58 +1100, Grant Coady <grant_nospam@dodo.com.au> =
wrote:

>Greetings,
>
>This patch adds locking around set operations that access=20
>data->something and go out to the chip.
>
Lucky last: it87

Sign-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/it87.c	2005-03-26 07:26:41.00000=
0000 +1100
+++ linux-2.6.12-rc1-mm3x/drivers/i2c/chips/it87.c	2005-03-26 13:20:03.0000=
00000 +1100
@@ -265,9 +265,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MIN(nr),=20
 			data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf,=20
@@ -276,9 +279,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MAX(nr),=20
 			data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -356,8 +362,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_high[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_min(struct device *dev, const char *buf,=20
@@ -366,8 +375,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_low[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -421,6 +433,8 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	data->sensor &=3D ~(1 << nr);
 	data->sensor &=3D ~(8 << nr);
 	/* 3 =3D thermal diode; 2 =3D thermistor; 0 =3D disabled */
@@ -431,6 +445,7 @@
 	else if (val !=3D 0)
 		return -EINVAL;
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	up(&data->update_lock);
 	return count;
 }
 #define show_sensor_offset(offset)					\
@@ -484,8 +499,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,=20
@@ -495,6 +513,8 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
 	int i, min[3];
+
+	down(&data->update_lock);
 	u8 old =3D it87_read_value(client, IT87_REG_FAN_DIV);
=20
 	for (i =3D 0; i < 3; i++)
@@ -522,6 +542,7 @@
 		data->fan_min[i]=FAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
 		it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
 	}
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm_enable(struct device *dev, const char *buf,
@@ -531,6 +552,8 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	if (val =3D 0) {
 		int tmp;
 		/* make sure the fan is on when in on/off mode */
@@ -545,9 +568,12 @@
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
 		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_c=
tl[nr]));
-	} else
+	} else {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
=20
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm(struct device *dev, const char *buf,
@@ -557,13 +583,17 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	if (val < 0 || val > 255)
 		return -EINVAL;
=20
 	data->manual_pwm_ctl[nr] =3D val;
 	if (data->fan_main_ctrl & (1 << nr))
-		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_c=
tl[nr]));
+		it87_write_value(client, IT87_REG_PWM(nr),
+				PWM_TO_REG(data->manual_pwm_ctl[nr]));
=20
+	up(&data->update_lock);
 	return count;
 }
=20
