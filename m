From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:51 +0000
Subject: [lm-sensors] [PATCH 25/36] w83781d: Don't reset the chip by default
Message-Id: <11431538313901-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Stop resetting the chip on load by default, so as to preserve the BIOS
initializations. Same was done in the w83627hf driver some times ago
for the same reasons.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 Documentation/hwmon/w83781d |    5 +++++
 drivers/hwmon/w83781d.c     |   22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletions(-)

fabddcd49d8b4fca40ce346f701853888d98b5d2
diff --git a/Documentation/hwmon/w83781d b/Documentation/hwmon/w83781d
index ac155d8..b1e9f80 100644
--- a/Documentation/hwmon/w83781d
+++ b/Documentation/hwmon/w83781d
@@ -36,6 +36,11 @@ Module parameters
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
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 7821178..8b17132 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -57,6 +57,10 @@ I2C_CLIENT_INSMOD_5(w83781d, w83782d, w8
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
+static int reset;
+module_param(reset, bool, 0);
+MODULE_PARM_DESC(reset, "Set to one to reset chip on load");
+
 static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
@@ -1460,8 +1464,17 @@ w83781d_init_client(struct i2c_client *c
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
@@ -1478,6 +1491,13 @@ w83781d_init_client(struct i2c_client *c
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
-- 
1.2.4



