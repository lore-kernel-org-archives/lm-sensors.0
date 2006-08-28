From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 09:39:08 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-suspend-resume.patch
Message-Id: <20060828113908.c3c00881.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44DB2470.3050507@hhs.nl>
In-Reply-To: <44DB2470.3050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> This patch contains rudimentary suspend / resume support for the uguru,
> this protects the uguru and the driver against suspend / resume cycles,
> so there is no reason to unload the driver in your suspend / resume scripts.
> 
> I'm not sure if this is needed, does the sysfs code itself guarantee
> that no sysfs attr read/write calls are in progress before starting a
> resume, if it does then this patch most likely isn't needed. Except for
> protecting against this, it also checks the uguru is still in ready
> status after a resume, but that seems to be unnescesarry (as it seems
> that the uguru always is still ready after the resume).

I've noticed that most drivers take care to exclude the suspend/resume
functions when CONFIG_PM is disabled. I agree it shouldn't matter much
for the abituguru driver, as ACPI implies CONFIG_PM and I don't think
anyone would run these boards with ACPI support. But in an attempt to
make things as good as possible (in case others copy that code for
other hwmon driver), what about stacking the following patch on top of
yours?


Only include suspend/resume functions when CONFIG_PM is set.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/abituguru.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.18-rc5.orig/drivers/hwmon/abituguru.c	2006-08-28 11:09:39.000000000 +0200
+++ linux-2.6.18-rc5/drivers/hwmon/abituguru.c	2006-08-28 11:31:26.000000000 +0200
@@ -1354,6 +1354,7 @@
 		return NULL;
 }
 
+#ifdef CONFIG_PM
 static int abituguru_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct abituguru_data *data = platform_get_drvdata(pdev);
@@ -1372,6 +1373,10 @@
 	mutex_unlock(&data->update_lock);
 	return 0;
 }
+#else
+#define abituguru_suspend	NULL
+#define abituguru_resume	NULL
+#endif /* CONFIG_PM */
 
 static struct platform_driver abituguru_driver = {
 	.driver = {

Thanks,
-- 
Jean Delvare

