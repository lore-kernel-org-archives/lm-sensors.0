From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Sep 2005 22:52:30 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: w83627hf: no reset by default
Message-Id: <20050904225217.13625bd2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Make the reset of the chips in w83627hf optional rather than the
default. This reset has been causing trouble several times already. It
may even go completely away unless it proves to be useful to at least
one user.

Closes bug #5168:
http://bugzilla.kernel.org/show_bug.cgi?idQ68

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/w83627hf.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- linux-2.6.13.orig/drivers/hwmon/w83627hf.c	2005-08-29 20:54:29.000000000 +0200
+++ linux-2.6.13/drivers/hwmon/w83627hf.c	2005-09-04 20:21:31.000000000 +0200
@@ -64,6 +64,10 @@
 /* Insmod parameters */
 enum chips { any_chip, w83627hf, w83627thf, w83697hf, w83637hf };
 
+static int reset;
+module_param(reset, bool, 0);
+MODULE_PARM_DESC(reset, "Set to one to reset chip on load");
+
 static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
@@ -1279,7 +1283,15 @@
 	int type = data->type;
 	u8 tmp;
 
-	if(init) {
+	if (reset) {
+		/* Resetting the chip has been the default for a long time,
+		   but repeatedly caused problems (fans going to full
+		   speed...) so it is now optional. It might even go away if
+		   nobody reports it as being useful, as I see very little
+		   reason why this would be needed at all. */
+		dev_info(&client->dev, "If reset=1 solved a problem you were "
+			 "having, please report!\n");
+
 		/* save this register */
 		i = w83627hf_read_value(client, W83781D_REG_BEEP_CONFIG);
 		/* Reset all except Watchdog values and last conversion values


-- 
Jean Delvare
