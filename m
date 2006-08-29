From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:24:57 +0000
Subject: [lm-sensors] patch hwmon-it87-in8-no-limits.patch added to
Message-Id: <20060829232559.D9ACB895AA1@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 07/14] it87: in8 has no limit registers

to my gregkh-2.6 tree.  Its filename is

     hwmon-it87-in8-no-limits.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:27:33 2006
Date: Mon, 28 Aug 2006 14:27:25 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 07/14] it87: in8 has no limit registers
Message-Id: <20060828142725.18716798.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-it87-in8-no-limits.patch

it87: in8 has no limit registers

Signed-off-by: Jean Delvare <khali at linux-fr.org>

---
 drivers/hwmon/it87.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/it87.c
+++ gregkh-2.6/drivers/hwmon/it87.c
@@ -220,8 +220,8 @@ struct it87_data {
 	unsigned long last_updated;	/* In jiffies */
 
 	u8 in[9];		/* Register value */
-	u8 in_max[9];		/* Register value */
-	u8 in_min[9];		/* Register value */
+	u8 in_max[8];		/* Register value */
+	u8 in_min[8];		/* Register value */
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[3];		/* Register values, possibly combined */
 	u16 fan_min[3];		/* Register values, possibly combined */
@@ -1250,12 +1250,9 @@ static struct it87_data *it87_update_dev
 			data->in_max[i]  			    it87_read_value(client, IT87_REG_VIN_MAX(i));
 		}
+		/* in8 (battery) has no limit registers */
 		data->in[8]  		    it87_read_value(client, IT87_REG_VIN(8));
-		/* Temperature sensor doesn't have limit registers, set
-		   to min and max value */
-		data->in_min[8] = 0;
-		data->in_max[8] = 255;
 
 		for (i = 0; i < 3; i++) {
 			/* Skip disabled fans */


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-w83627ehf-add-pwm-support.patch
i2c/hwmon-w83627ehf-documentation.patch
i2c/i2c-algo-bit-kill-mdelay.patch
i2c/hwmon-abituguru-suspend-resume.patch
i2c/i2c-__must_check-fixes-i2c-dev.patch
i2c/i2c-__must_check-fixes.patch
i2c/hwmon-it87-disabled-fans.patch
i2c/i2c-algo-sibyte-cleanups.patch
i2c/i2c-algo-sibyte-merge-in-i2c-sibyte.patch
i2c/i2c-au1550-add-au1200-support.patch
i2c/i2c-au1550-add-smbus-functionality-flag.patch
i2c/i2c-au1550-fix-timeout-problem.patch
i2c/i2c-bus-driver-for-TI-OMAP-boards.patch
i2c/i2c-isa-plan-for-removal.patch
i2c/i2c-dev-cleanups.patch
i2c/i2c-dev-convert-array-to-list.patch
i2c/i2c-dev-drop-template-client.patch
i2c/i2c-dev-device.patch
i2c/i2c-fix-copy-n-paste-in-subsystem-Kconfig.patch
i2c/i2c-matroxfb-c99-struct-init.patch
i2c/i2c-sibyte-drop-kip-walker-address.patch
i2c/i2c-stub-add-chip_addr-param.patch
i2c/hwmon-atxp1-signed-unsigned-char-bug.patch
i2c/hwmon-hdaps-handle-errors-from-input-register-device.patch
i2c/hwmon-it87-copyright-update.patch
i2c/hwmon-it87-div-to-reg-overflow.patch
i2c/hwmon-it87-in8-no-limits.patch
i2c/hwmon-it87-it8716f-support.patch
i2c/hwmon-it87-it8718f-support.patch
i2c/hwmon-it87-sane-limit-defaults.patch
i2c/hwmon-it87-set-fan-div.patch
i2c/hwmon-k8temp-autoload.patch
i2c/hwmon-k8temp-new-driver.patch
i2c/hwmon-smsc47m1-fix-dev-message.patch

