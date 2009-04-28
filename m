From: "James M. Leddy" <jm.leddy@gmail.com>
Date: Tue, 28 Apr 2009 02:25:12 +0000
Subject: [lm-sensors] Asus fan control
Message-Id: <49F66908.5070202@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050608000006070009060601"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050608000006070009060601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I realize http://www.lm-sensors.org/ticket/2350 is closed wontfix, but 
I absolutely must have fan control on my Asus CUV4X.  It is for that 
reason that I've developed the attached patch against 2.6.29

I'm attaching here just in case there are others that would like fan 
control on their asus motherboards.  I've attached a suitable 
/etc/fancontrol as well, which is tricky since the register only uses 
values 0x80-0x8f (decimal 128-143).  Honestly pwm2 doesn't seem to do 
anything on my board, and I don't know which rev of the chip I'm 
using, and I haven't investigated any other values outside 0x80-0x8f. 
  I'm just satisfied that my machine no longer sounds like a jet 
engine. I am willing to work on it if there's a possibility that it 
could be accepted.

--------------050608000006070009060601
Content-Type: text/plain;
 name="as99127f-fan-enablement.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as99127f-fan-enablement.patch"

--- linux-2.6.29-gentoo/drivers/hwmon/w83781d.c	2009-04-17 20:26:33.000000000 -0400
+++ linux-2.6.29-gentoo-r1/drivers/hwmon/w83781d.c	2009-04-28 06:38:07.000000000 -0400
@@ -139,6 +139,9 @@ static const u8 W83781D_REG_PWM[] = { 0x
 #define W83781D_REG_PWMCLK12		0x5C
 #define W83781D_REG_PWMCLK34		0x45C
 
+/* PWM AS99127F only */
+static const u8 AS99127F_REG_PWM[] = { 0x59, 0x5A };
+
 #define W83781D_REG_I2C_ADDR		0x48
 #define W83781D_REG_I2C_SUBADDR		0x4A
 
@@ -186,6 +189,7 @@ FAN_FROM_REG(u8 val, int div)
 
 #define DIV_FROM_REG(val)		(1 << (val))
 
+
 static inline u8
 DIV_TO_REG(long val, enum chips type)
 {
@@ -696,7 +700,11 @@ store_pwm(struct device *dev, struct dev
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
-	w83781d_write_value(data, W83781D_REG_PWM[nr], data->pwm[nr]);
+	if (data->type == as99127f) {
+		w83781d_write_value(data, AS99127F_REG_PWM[nr], data->pwm[nr]);
+	} else {
+		w83781d_write_value(data, W83781D_REG_PWM[nr], data->pwm[nr]);
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1017,7 +1025,7 @@ w83781d_create_files(struct device *dev,
 		}
 	}
 
-	if (kind != w83781d && kind != as99127f) {
+	if (kind != w83781d) {
 		if ((err = device_create_file(dev,
 				&sensor_dev_attr_pwm1.dev_attr))
 		    || (err = device_create_file(dev,
@@ -1469,8 +1477,15 @@ static struct w83781d_data *w83781d_upda
 			/* Only PWM2 can be disabled */
 			data->pwm2_enable = (w83781d_read_value(data,
 					      W83781D_REG_PWMCLK12) & 0x08) >> 3;
+		} else if (data->type == as99127f) {
+			for (i = 0; i < 2; i++) {
+				data->pwm[i] =
+				    w83781d_read_value(data,
+						       AS99127F_REG_PWM[i]);
+			}
 		}
 
+
 		data->temp = w83781d_read_value(data, W83781D_REG_TEMP(1));
 		data->temp_max =
 		    w83781d_read_value(data, W83781D_REG_TEMP_OVER(1));

--------------050608000006070009060601
Content-Type: text/plain;
 name="fancontrol"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fancontrol"

INTERVAL=10
FCTEMPS=hwmon0/device/pwm1=hwmon0/device/temp2_input
FCFANS=hwmon0/device/pwm1=hwmon0/device/fan1_input
MINTEMP=hwmon0/device/pwm1=40
MAXTEMP=hwmon0/device/pwm1=55

MINSTART=hwmon0/device/pwm1=135
MINSTOP=hwmon0/device/pwm1=130
MINPWM=hwmon0/device/pwm1=130
MAXPWM=hwmon0/device/pwm1=143

--------------050608000006070009060601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050608000006070009060601--
