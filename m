From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:24:29 +0000
Subject: [lm-sensors] patch hwmon-abituguru-suspend-resume.patch added to
Message-Id: <20060829232532.12F0C895AB4@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 14/14] abituguru: Add suspend/resume support

to my gregkh-2.6 tree.  Its filename is

     hwmon-abituguru-suspend-resume.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:42:28 2006
Date: Mon, 28 Aug 2006 14:42:24 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Hans de Goede <j.w.r.degoede at hhs.nl>
Subject: [PATCH 14/14] abituguru: Add suspend/resume support
Message-Id: <20060828144224.472003b5.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-abituguru-suspend-resume.patch

From: Hans de Goede <j.w.r.degoede at hhs.nl>

This patch contains rudimentary suspend / resume support for the uguru,
this protects the uguru and the driver against suspend / resume cycles,
so there is no reason to unload the driver in your suspend / resume
scripts.

Only include suspend / resume functions when CONFIG_PM is set.

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/abituguru.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/abituguru.c
+++ gregkh-2.6/drivers/hwmon/abituguru.c
@@ -1354,13 +1354,39 @@ LEAVE_UPDATE:
 		return NULL;
 }
 
+#ifdef CONFIG_PM
+static int abituguru_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct abituguru_data *data = platform_get_drvdata(pdev);
+	/* make sure all communications with the uguru are done and no new
+	   ones are started */
+	mutex_lock(&data->update_lock);
+	return 0;
+}
+
+static int abituguru_resume(struct platform_device *pdev)
+{
+	struct abituguru_data *data = platform_get_drvdata(pdev);
+	/* See if the uGuru is still ready */
+	if (inb_p(data->addr + ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT)
+		data->uguru_ready = 0;
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+#else
+#define abituguru_suspend	NULL
+#define abituguru_resume	NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver abituguru_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= ABIT_UGURU_NAME,
 	},
-	.probe	= abituguru_probe,
-	.remove	= __devexit_p(abituguru_remove),
+	.probe		= abituguru_probe,
+	.remove		= __devexit_p(abituguru_remove),
+	.suspend	= abituguru_suspend,
+	.resume		= abituguru_resume,
 };
 
 static int __init abituguru_detect(void)


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

