From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 May 2008 15:39:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627hf) Drop reset module parameter
Message-Id: <20080528173918.6e7e9da4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop the reset parameter of the w83627hf driver. It seems it wasn't
that useful. It was dropped from the Linux 2.4 version of this driver
back in July 2004.

The only users who have reported that they were still using this
parameter, needed it to switch the chip from automatic fan speed
control back to manual mode. Now that the driver creates pwmN_enable
sysfs files, users will be able to use these files instead, which is
way less agressive.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Note: this goes on top of Dominik Geyer's patch:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.html

Dominik, would you be so kind to review, test and ack this patch?
Thanks.

 Documentation/hwmon/w83627hf |    4 ----
 drivers/hwmon/w83627hf.c     |   27 ---------------------------
 2 files changed, 31 deletions(-)

--- linux-2.6.26-rc3.orig/drivers/hwmon/w83627hf.c	2008-05-20 21:03:14.000000000 +0200
+++ linux-2.6.26-rc3/drivers/hwmon/w83627hf.c	2008-05-20 21:03:53.000000000 +0200
@@ -68,10 +68,6 @@ module_param(force_i2c, byte, 0);
 MODULE_PARM_DESC(force_i2c,
 		 "Initialize the i2c address of the sensors");
 
-static int reset;
-module_param(reset, bool, 0);
-MODULE_PARM_DESC(reset, "Set to one to reset chip on load");
-
 static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
@@ -1601,29 +1597,6 @@ static void __devinit w83627hf_init_devi
 	enum chips type = data->type;
 	u8 tmp;
 
-	if (reset) {
-		/* Resetting the chip has been the default for a long time,
-		   but repeatedly caused problems (fans going to full
-		   speed...) so it is now optional. It might even go away if
-		   nobody reports it as being useful, as I see very little
-		   reason why this would be needed at all. */
-		dev_info(&pdev->dev, "If reset=1 solved a problem you were "
-			 "having, please report!\n");
-
-		/* save this register */
-		i = w83627hf_read_value(data, W83781D_REG_BEEP_CONFIG);
-		/* Reset all except Watchdog values and last conversion values
-		   This sets fan-divs to 2, among others */
-		w83627hf_write_value(data, W83781D_REG_CONFIG, 0x80);
-		/* Restore the register and disable power-on abnormal beep.
-		   This saves FAN 1/2/3 input/output values set by BIOS. */
-		w83627hf_write_value(data, W83781D_REG_BEEP_CONFIG, i | 0x80);
-		/* Disable master beep-enable (reset turns it on).
-		   Individual beeps should be reset to off but for some reason
-		   disabling this bit helps some people not get beeped */
-		w83627hf_write_value(data, W83781D_REG_BEEP_INTS2, 0);
-	}
-
 	/* Minimize conflicts with other winbond i2c-only clients...  */
 	/* disable i2c subclients... how to disable main i2c client?? */
 	/* force i2c address to relatively uncommon address */
--- linux-2.6.26-rc3.orig/Documentation/hwmon/w83627hf	2008-05-20 21:03:12.000000000 +0200
+++ linux-2.6.26-rc3/Documentation/hwmon/w83627hf	2008-05-20 21:03:24.000000000 +0200
@@ -40,10 +40,6 @@ Module Parameters
   (default is 1)
   Use 'init=0' to bypass initializing the chip.
   Try this if your computer crashes when you load the module.
-* reset: int
-  (default is 0)
-  The driver used to reset the chip on load, but does no more. Use
-  'reset=1' to restore the old behavior. Report if you need to do this.
 
 Description
 -----------


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
