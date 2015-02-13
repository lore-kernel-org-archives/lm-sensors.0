From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 20:44:41 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (nct6775) Convert to use SIMPLE_DEV_PM_OPS
Message-Id: <1423860283-3938-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Get rid of #ifdef CONFIG_PM by using SIMPLE_DEV_PM_OPS and declaring suspend
and resume functions with __maybe_unused.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 1be4117..db6a68e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -880,12 +880,11 @@ struct nct6775_data {
 	u16 have_temp;
 	u16 have_temp_fixed;
 	u16 have_in;
-#ifdef CONFIG_PM
+
 	/* Remember extra register values over suspend/resume */
 	u8 vbat;
 	u8 fandiv1;
 	u8 fandiv2;
-#endif
 };
 
 struct nct6775_sio_data {
@@ -3989,8 +3988,7 @@ static void nct6791_enable_io_mapping(int sioaddr)
 	}
 }
 
-#ifdef CONFIG_PM
-static int nct6775_suspend(struct device *dev)
+static int __maybe_unused nct6775_suspend(struct device *dev)
 {
 	struct nct6775_data *data = nct6775_update_device(dev);
 
@@ -4005,7 +4003,7 @@ static int nct6775_suspend(struct device *dev)
 	return 0;
 }
 
-static int nct6775_resume(struct device *dev)
+static int __maybe_unused nct6775_resume(struct device *dev)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int i, j, err = 0;
@@ -4066,22 +4064,12 @@ abort:
 	return err;
 }
 
-static const struct dev_pm_ops nct6775_dev_pm_ops = {
-	.suspend = nct6775_suspend,
-	.resume = nct6775_resume,
-	.freeze = nct6775_suspend,
-	.restore = nct6775_resume,
-};
-
-#define NCT6775_DEV_PM_OPS	(&nct6775_dev_pm_ops)
-#else
-#define NCT6775_DEV_PM_OPS	NULL
-#endif /* CONFIG_PM */
+static SIMPLE_DEV_PM_OPS(nct6775_dev_pm_ops, nct6775_suspend, nct6775_resume);
 
 static struct platform_driver nct6775_driver = {
 	.driver = {
 		.name	= DRVNAME,
-		.pm	= NCT6775_DEV_PM_OPS,
+		.pm	= &nct6775_dev_pm_ops,
 	},
 	.probe		= nct6775_probe,
 };
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
