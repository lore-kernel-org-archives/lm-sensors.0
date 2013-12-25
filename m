From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Dec 2013 15:34:12 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Re-enable logical device mapping for NCT6791 during resume
Message-Id: <1387985652-28274-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After a suspend/resume cycle, the NCT6791 is back to its original BIOS
programming. In this state, HWMON IO access may be locked.
Re-enable it during resume.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index cf811c1..8686e96 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3936,6 +3936,18 @@ static int nct6775_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+static void nct6791_enable_io_mapping(int sioaddr)
+{
+	int val;
+
+	val = superio_inb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
+	if (val & 0x10) {
+		pr_info("Enabling hardware monitor logical device mappings.\n");
+		superio_outb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
+			     val & ~0x10);
+	}
+}
+
 #ifdef CONFIG_PM
 static int nct6775_suspend(struct device *dev)
 {
@@ -3955,11 +3967,20 @@ static int nct6775_suspend(struct device *dev)
 static int nct6775_resume(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
-	int i, j;
+	int i, j, err = 0;
 
 	mutex_lock(&data->update_lock);
 	data->bank = 0xff;		/* Force initial bank selection */
 
+	if (data->kind = nct6791) {
+		err = superio_enter(data->sioreg);
+		if (err)
+			goto abort;
+
+		nct6791_enable_io_mapping(data->sioreg);
+		superio_exit(data->sioreg);
+	}
+
 	/* Restore limits */
 	for (i = 0; i < data->in_num; i++) {
 		if (!(data->have_in & (1 << i)))
@@ -3996,11 +4017,12 @@ static int nct6775_resume(struct device *dev)
 		nct6775_write_value(data, NCT6775_REG_FANDIV2, data->fandiv2);
 	}
 
+abort:
 	/* Force re-reading all values */
 	data->valid = false;
 	mutex_unlock(&data->update_lock);
 
-	return 0;
+	return err;
 }
 
 static const struct dev_pm_ops nct6775_dev_pm_ops = {
@@ -4088,15 +4110,9 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 		pr_warn("Forcibly enabling Super-I/O. Sensor is probably unusable.\n");
 		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
 	}
-	if (sio_data->kind = nct6791) {
-		val = superio_inb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
-		if (val & 0x10) {
-			pr_info("Enabling hardware monitor logical device mappings.\n");
-			superio_outb(sioaddr,
-				     NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
-				     val & ~0x10);
-		}
-	}
+
+	if (sio_data->kind = nct6791)
+		nct6791_enable_io_mapping(sioaddr);
 
 	superio_exit(sioaddr);
 	pr_info("Found %s or compatible chip at %#x:%#x\n",
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
