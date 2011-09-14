From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Sep 2011 08:43:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Initialize tmin
Message-Id: <20110914104307.637e5391@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ttarget is initialized when the driver is loaded, but tmin is not.
As a result, tempX_max_hyst attributes read 0. Fix this.

Also use THERM_*_THRESHOLD* constants in these initializations instead
of hard-coding the constants.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/hwmon/coretemp.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-3.1-rc4.orig/drivers/hwmon/coretemp.c	2011-08-23 21:34:44.000000000 +0200
+++ linux-3.1-rc4/drivers/hwmon/coretemp.c	2011-09-14 09:32:11.000000000 +0200
@@ -601,7 +601,12 @@ static int create_core_data(struct platf
 	err = rdmsr_safe_on_cpu(cpu, tdata->intrpt_reg, &eax, &edx);
 	if (!err) {
 		tdata->attr_size += MAX_THRESH_ATTRS;
-		tdata->ttarget = tdata->tjmax - ((eax >> 16) & 0x7f) * 1000;
+		tdata->tmin = tdata->tjmax -
+			      ((eax & THERM_MASK_THRESHOLD0) >>
+			       THERM_SHIFT_THRESHOLD0) * 1000;
+		tdata->ttarget = tdata->tjmax -
+				 ((eax & THERM_MASK_THRESHOLD1) >>
+				  THERM_SHIFT_THRESHOLD1) * 1000;
 	}
 
 	pdata->core_data[attr_no] = tdata;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
