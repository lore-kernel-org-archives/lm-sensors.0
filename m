From: gregkh@suse.de (gregkh@suse.de)
Date: Tue, 02 May 2006 05:43:53 +0000
Subject: [lm-sensors] patch
Message-Id: <20060502054527.8533748769D@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: scx200_acb: Fix resource name use after free

to my gregkh-2.6 tree.  Its filename is

     i2c-scx200_acb-fix-resource-name-use-after-free.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Wed Apr 26 14:00:15 2006
Date: Wed, 26 Apr 2006 23:00:16 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: scx200_acb: Fix resource name use after free
Message-Id: <20060426230016.dca44e58.khali at linux-fr.org>
Content-Disposition: inline; filename=i2c-scx200_acb-fix-resource-name-use-after-free.patch

We can't pass a string on the stack to request_region. As soon as we
leave the function that stack is gone and the string is lost. Let's
use the same string we identify the i2c_adapter with instead, it's
more simple, more consistent, and just works.

This is the second half of fix to bug #6445.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/i2c/busses/scx200_acb.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/busses/scx200_acb.c
+++ gregkh-2.6/drivers/i2c/busses/scx200_acb.c
@@ -415,7 +415,6 @@ static int  __init scx200_acb_create(con
 	struct scx200_acb_iface *iface;
 	struct i2c_adapter *adapter;
 	int rc;
-	char description[64];
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 	if (!iface) {
@@ -434,10 +433,7 @@ static int  __init scx200_acb_create(con
 
 	mutex_init(&iface->mutex);
 
-	snprintf(description, sizeof(description), "%s ACCESS.bus [%s]",
-		 text, adapter->name);
-
-	if (request_region(base, 8, description) = 0) {
+	if (!request_region(base, 8, adapter->name)) {
 		printk(KERN_ERR NAME ": can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
 		rc = -EBUSY;


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-f71805f-no-global-resource.patch
i2c/hwmon-lm83-add-lm82-support.patch
i2c/hwmon-smsc47m192-new-driver.patch
i2c/hwmon-sysfs-interface-individual-alarm-files.patch
i2c/hwmon-w83627ehf-add-alarms.patch
i2c/hwmon-w83627ehf-add-voltages.patch
i2c/i2c-piix4-add-ati-smbus-support.patch
i2c/rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch
i2c/hwmon-hdaps-update-id-list.patch
i2c/rtc-m41t00-driver-cleanup.patch
i2c/i2c-nforce2-add-mcp51-mcp55-support.patch
i2c/i2c-piix4-fix-typo-in-documentation.patch
i2c/i2c-piix4-improve-ibm-error-message.patch
i2c/i2c-piix4-remove-fix_hstcfg-parameter.patch
i2c/hwmon-improve-Kconfig-help.patch
i2c/hwmon-lm83-documentation-update.patch
i2c/hwmon-vid-mask-per-vrm.patch
i2c/hwmon-w83791d-new-driver.patch
i2c/i2c-scx200_acb-fix-for-cs5535-errata.patch
i2c/i2c-scx200_acb-fix-resource-name-use-after-free.patch
i2c/i2c-scx200_acb-fix-return-on-init-error.patch
pci/pci-error-handling-on-pci-device-resume.patch

