From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:25:16 +0000
Subject: [lm-sensors] patch hwmon-it87-sane-limit-defaults.patch added to
Message-Id: <20060829232619.C2C9A808ABE@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 10/14] it87: Overwrite broken default limits

to my gregkh-2.6 tree.  Its filename is

     hwmon-it87-sane-limit-defaults.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:38:00 2006
Date: Mon, 28 Aug 2006 14:37:54 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 10/14] it87: Overwrite broken default limits
Message-Id: <20060828143754.a55b6cb6.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-it87-sane-limit-defaults.patch

it87: Overwrite broken default limits

Some IT8716F chips where seen with unreasonable defaults for low
voltage and high temperature limits. Overwrite them with sane defaults
so as to not generate meaningless alarms.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/it87.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- gregkh-2.6.orig/drivers/hwmon/it87.c
+++ gregkh-2.6/drivers/hwmon/it87.c
@@ -1201,6 +1201,22 @@ static void it87_init_client(struct i2c_
 		data->manual_pwm_ctl[i] = 0xff;
 	}
 
+	/* Some chips seem to have default value 0xff for all limit
+	 * registers. For low voltage limits it makes no sense and triggers
+	 * alarms, so change to 0 instead. For high temperature limits, it
+	 * means -1 degree C, which surprisingly doesn't trigger an alarm,
+	 * but is still confusing, so change to 127 degrees C. */
+	for (i = 0; i < 8; i++) {
+		tmp = it87_read_value(client, IT87_REG_VIN_MIN(i));
+		if (tmp = 0xff)
+			it87_write_value(client, IT87_REG_VIN_MIN(i), 0);
+	}
+	for (i = 0; i < 3; i++) {
+		tmp = it87_read_value(client, IT87_REG_TEMP_HIGH(i));
+		if (tmp = 0xff)
+			it87_write_value(client, IT87_REG_TEMP_HIGH(i), 127);
+	}
+
 	/* Check if temperature channnels are reset manually or by some reason */
 	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
 	if ((tmp & 0x3f) = 0) {


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

