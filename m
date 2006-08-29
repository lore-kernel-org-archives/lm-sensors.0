From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 29 Aug 2006 23:25:29 +0000
Subject: [lm-sensors] patch hwmon-k8temp-autoload.patch added to gregkh-2.6
Message-Id: <20060829232632.74454808ABE@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 13/14] k8temp: Enable automatic loading

to my gregkh-2.6 tree.  Its filename is

     hwmon-k8temp-autoload.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Aug 28 05:41:05 2006
Date: Mon, 28 Aug 2006 14:41:03 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Rudolf Marek <r.marek at sh.cvut.cz>
Subject: [PATCH 13/14] k8temp: Enable automatic loading
Message-Id: <20060828144103.3e14d4b2.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-k8temp-autoload.patch

Let the k8temp driver load automatically.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/k8temp.c |    2 ++
 1 file changed, 2 insertions(+)

--- gregkh-2.6.orig/drivers/hwmon/k8temp.c
+++ gregkh-2.6/drivers/hwmon/k8temp.c
@@ -133,6 +133,8 @@ static struct pci_device_id k8temp_ids[]
 	{ 0 },
 };
 
+MODULE_DEVICE_TABLE(pci, k8temp_ids);
+
 static int __devinit k8temp_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {


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

