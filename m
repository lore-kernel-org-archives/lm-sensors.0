From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:24:52 +0000
Subject: [lm-sensors] patch hwmon-it87-div-to-reg-overflow.patch added to
Message-Id: <20060829232555.41D0D84A3F0@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 06/14] it87: Prevent overflow on fan clock divider write

to my gregkh-2.6 tree.  Its filename is

     hwmon-it87-div-to-reg-overflow.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:26:25 2006
Date: Mon, 28 Aug 2006 14:26:22 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 06/14] it87: Prevent overflow on fan clock divider write
Message-Id: <20060828142622.4e6c9492.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-it87-div-to-reg-overflow.patch

it87: Prevent overflow on fan clock divider write

The highest possible clock divider for fan1 and fan2 is 128.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/it87.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/it87.c
+++ gregkh-2.6/drivers/hwmon/it87.c
@@ -198,7 +198,7 @@ static inline u16 FAN16_TO_REG(long rpm)
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
-	while ((val >>= 1) != 0)
+	while (answer < 7 && (val >>= 1))
 		answer++;
 	return answer;
 }
@@ -562,7 +562,7 @@ static ssize_t set_fan_div(struct device
 
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int i, min[3];
 	u8 old;
 


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

