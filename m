From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <10559607093836@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10559607081420@kroah.com>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1318.3.6, 2003/06/16 11:40:37-07:00, margitsw@t-online.de

[PATCH] I2C: Sensors patch for adm1021

Patch for adm1021
This corrects temp reporting and a major error whereby
"alarms" and "die_code" were being put though the "TEMP" macro.
Compiled but don't have the hardware to test.


 drivers/i2c/chips/adm1021.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Jun 18 11:19:25 2003
+++ b/drivers/i2c/chips/adm1021.c	Wed Jun 18 11:19:25 2003
@@ -88,8 +88,8 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 /* Conversions  note: 1021 uses normal integer signed-byte format*/
-#define TEMP_FROM_REG(val)	(val > 127 ? val-256 : val)
-#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val < 0 ? val+256 : val),0,255))
+#define TEMP_FROM_REG(val)	(val > 127 ? (val-256)*1000 : val*1000)
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val < 0 ? (val/1000)+256 : val/1000),0,255))
 
 /* Initial values */
 
@@ -172,8 +172,18 @@
 show(remote_temp_max);
 show(remote_temp_hyst);
 show(remote_temp_input);
-show(alarms);
-show(die_code);
+
+#define show2(value)	\
+static ssize_t show_##value(struct device *dev, char *buf)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct adm1021_data *data = i2c_get_clientdata(client);	\
+								\
+	adm1021_update_client(client);				\
+	return sprintf(buf, "%d\n", data->value);		\
+}
+show2(alarms);
+show2(die_code);
 
 #define set(value, reg)	\
 static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\

