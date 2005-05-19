From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814492866@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814492936@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.4, 2004/03/25 10:51:45-08:00, khali@linux-fr.org

[PATCH] I2C: initialize fan_mins in w83781d, asb100 and lm78

Quoting myself:

> While testing, I found a corner case that isn't handled properly. It
> doesn't seem to be handled by the lm78 and the asb100 either. Setting
> fanN_div before ever reading from the chip or setting fanN_min will
> make use of fanN_min while it was never initialized.

The following patch addesses the issue. Tested to work on my AS99127F
rev.1 (which means that only the changes to the w83781d driver were
actually tested). Testers welcome.


 drivers/i2c/chips/asb100.c  |    5 +++++
 drivers/i2c/chips/lm78.c    |    6 ++++++
 drivers/i2c/chips/w83781d.c |    6 ++++++
 3 files changed, 17 insertions(+)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Wed Apr 14 15:14:44 2004
+++ b/drivers/i2c/chips/asb100.c	Wed Apr 14 15:14:44 2004
@@ -807,6 +807,11 @@
 	/* Initialize the chip */
 	asb100_init_client(new_client);
 
+	/* A few vars need to be filled upon startup */
+	data->fan_min[0] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(0));
+	data->fan_min[1] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(1));
+	data->fan_min[2] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(2));
+
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
 	device_create_file_in(new_client, 1);
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Wed Apr 14 15:14:44 2004
+++ b/drivers/i2c/chips/lm78.c	Wed Apr 14 15:14:44 2004
@@ -625,6 +625,12 @@
 	/* Initialize the LM78 chip */
 	lm78_init_client(new_client);
 
+	/* A few vars need to be filled upon startup */
+	for (i = 0; i < 3; i++) {
+		data->fan_min[i] = lm78_read_value(new_client,
+					LM78_REG_FAN_MIN(i));
+	}
+
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:14:44 2004
+++ b/drivers/i2c/chips/w83781d.c	Wed Apr 14 15:14:44 2004
@@ -1252,6 +1252,12 @@
 	/* Initialize the chip */
 	w83781d_init_client(new_client);
 
+	/* A few vars need to be filled upon startup */
+	for (i = 1; i <= 3; i++) {
+		data->fan_min[i - 1] = w83781d_read_value(new_client,
+					W83781D_REG_FAN_MIN(i));
+	}
+
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
 	if (kind != w83783s && kind != w83697hf)

