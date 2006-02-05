From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:26:51 +0000
Subject: [lm-sensors] [PATCH 07/11] w83781d: Don't reset the chip by default
Message-Id: <20060205232651.5a0be1e4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-w83781d-no-reset-by-default.patch

Stop resetting the chip on load by default, so as to preserve the BIOS
initializations. Same was done in the w83627hf driver some times ago
for the same reasons.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/w83781d |    5 +++++
 drivers/hwmon/w83781d.c     |   22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc2.orig/drivers/hwmon/w83781d.c	2006-02-05 16:01:49.000000000 +0100
+++ linux-2.6.16-rc2/drivers/hwmon/w83781d.c	2006-02-05 16:02:00.000000000 +0100
@@ -57,6 +57,10 @@
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
+static int reset;
+module_param(reset, bool, 0);
+MODULE_PARM_DESC(reset, "Set to one to reset chip on load");
+
 static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
@@ -1460,8 +1464,17 @@
 	int type = data->type;
 	u8 tmp;
 
-	if (init && type != as99127f) {	/* this resets registers we don't have
+	if (reset && type != as99127f) { /* this resets registers we don't have
 					   documentation for on the as99127f */
+		/* Resetting the chip has been the default for a long time,
+		   but it causes the BIOS initializations (fan clock dividers,
+		   thermal sensor types...) to be lost, so it is now optional.
+		   It might even go away if nobody reports it as being useful,
+		   as I see very little reason why this would be needed at
+		   all. */
+		dev_info(&client->dev, "If reset=1 solved a problem you were "
+			 "having, please report!\n");
+
 		/* save these registers */
 		i = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
 		p = w83781d_read_value(client, W83781D_REG_PWMCLK12);
@@ -1478,6 +1491,13 @@
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
 	}
 
+	/* Disable power-on abnormal beep, as advised by the datasheet.
+	   Already done if reset=1. */
+	if (init && !reset && type != as99127f) {
+		i = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
+		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);
+	}
+
 	data->vrm = vid_which_vrm();
 
 	if ((type != w83781d) && (type != as99127f)) {
--- linux-2.6.16-rc2.orig/Documentation/hwmon/w83781d	2006-02-05 16:01:53.000000000 +0100
+++ linux-2.6.16-rc2/Documentation/hwmon/w83781d	2006-02-05 16:02:00.000000000 +0100
@@ -36,6 +36,11 @@
   Use 'init=0' to bypass initializing the chip.
   Try this if your computer crashes when you load the module.
 
+* reset int
+  (default 0)
+  The driver used to reset the chip on load, but does no more. Use
+  'reset=1' to restore the old behavior. Report if you need to do this.
+
 force_subclients=bus,caddr,saddr,saddr
   This is used to force the i2c addresses for subclients of
   a certain chip. Typical usage is `force_subclients=0,0x2d,0x4a,0x4b'

-- 
Jean Delvare

