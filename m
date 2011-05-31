From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 May 2011 19:50:51 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target temperature
Message-Id: <20110531215051.663df5ef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The current temperature range check of MSR_IA32_TEMPERATURE_TARGET
seems too strict to me, some TjMax values documented in
Documentation/hwmon/coretemp wouldn't pass. Relax the check so that
all the documented values pass.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
I'm not even sure why we need to check the range. Why would the
value read from the MSR be wrong?

 drivers/hwmon/coretemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.0-rc1.orig/drivers/hwmon/coretemp.c	2011-05-30 20:45:09.000000000 +0200
+++ linux-3.0-rc1/drivers/hwmon/coretemp.c	2011-05-31 19:36:09.000000000 +0200
@@ -296,7 +296,7 @@ static int get_tjmax(struct cpuinfo_x86
 		 * If the TjMax is not plausible, an assumption
 		 * will be used
 		 */
-		if (val > 80 && val < 120) {
+		if (val >= 70 && val <= 125) {
 			dev_info(dev, "TjMax is %d C.\n", val);
 			return val * 1000;
 		}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
