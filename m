From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:25:40 +0000
Subject: [lm-sensors] patch hwmon-smsc47m1-fix-dev-message.patch added to
Message-Id: <20060829232642.AD6D3808ABE@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 03/14] smsc47m1: dev_warn fix

to my gregkh-2.6 tree.  Its filename is

     hwmon-smsc47m1-fix-dev-message.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:22:44 2006
Date: Mon, 28 Aug 2006 14:22:34 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 03/14] smsc47m1: dev_warn fix
Message-Id: <20060828142234.3acd8103.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-smsc47m1-fix-dev-message.patch

smsc47m1: dev_warn fix

We can't use dev_warn on an i2c client before it is attached.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/smsc47m1.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/hwmon/smsc47m1.c
+++ gregkh-2.6/drivers/hwmon/smsc47m1.c
@@ -428,7 +428,8 @@ static int smsc47m1_detect(struct i2c_ad
 	pwm2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
 	       = 0x04;
 	if (!(fan1 || fan2 || pwm1 || pwm2)) {
-		dev_warn(&new_client->dev, "Device is not configured, will not use\n");
+		dev_warn(&adapter->dev, "Device at 0x%x is not configured, "
+			 "will not use\n", new_client->addr);
 		err = -ENODEV;
 		goto error_free;
 	}


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

