From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:24:34 +0000
Subject: [lm-sensors] patch hwmon-atxp1-signed-unsigned-char-bug.patch added
Message-Id: <20060829232536.B7C5E895AC5@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 01/14] atxp1: Signed/unsigned char bug fix

to my gregkh-2.6 tree.  Its filename is

     hwmon-atxp1-signed-unsigned-char-bug.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:18:20 2006
Date: Mon, 28 Aug 2006 14:18:14 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Alexey Dobriyan <adobriyan at gmail.com>
Subject: [PATCH 01/14] atxp1: Signed/unsigned char bug fix
Message-Id: <20060828141814.71640724.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-atxp1-signed-unsigned-char-bug.patch

From: Alexey Dobriyan <adobriyan at gmail.com>

vid_to_reg() can return -1 and char can be unsigned.

Signed-off-by: Alexey Dobriyan <adobriyan at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/atxp1.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/atxp1.c
+++ gregkh-2.6/drivers/hwmon/atxp1.c
@@ -116,8 +116,7 @@ static ssize_t atxp1_storevcore(struct d
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
-	char vid;
-	char cvid;
+	int vid, cvid;
 	unsigned int vcore;
 
 	client = to_i2c_client(dev);


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

