From: Zhenwen Xu <helight.xu@gmail.com>
Date: Tue, 28 Apr 2009 09:56:51 +0000
Subject: [lm-sensors] [PATCH] fix some section mismatch on
Message-Id: <20090428095651.GA9694@helight>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org


Fix those section mismatch wornings:

WARNING: drivers/hwmon/sht15.o(.data+0x0): Section mismatch in reference from
the variable sht_drivers to the function .devinit.text:sht15_probe()
The variable sht_drivers references
the function __devinit sht15_probe()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0x4): Section mismatch in reference from
the variable sht_drivers to the function .devexit.text:sht15_remove()
The variable sht_drivers references
the function __devexit sht15_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0x50): Section mismatch in reference from
the variable sht_drivers to the function .devinit.text:sht15_probe()
The variable sht_drivers references
the function __devinit sht15_probe()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0x54): Section mismatch in reference from
the variable sht_drivers to the function .devexit.text:sht15_remove()
The variable sht_drivers references
the function __devexit sht15_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0xa0): Section mismatch in reference from
the variable sht_drivers to the function .devinit.text:sht15_probe()
The variable sht_drivers references
the function __devinit sht15_probe()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0xa4): Section mismatch in reference from
the variable sht_drivers to the function .devexit.text:sht15_remove()
The variable sht_drivers references
the function __devexit sht15_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0xf0): Section mismatch in reference from
the variable sht_drivers to the function .devinit.text:sht15_probe()
The variable sht_drivers references
the function __devinit sht15_probe()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0xf4): Section mismatch in reference from
the variable sht_drivers to the function .devexit.text:sht15_remove()
The variable sht_drivers references
the function __devexit sht15_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0x140): Section mismatch in reference from
the variable sht_drivers to the function .devinit.text:sht15_probe()
The variable sht_drivers references
the function __devinit sht15_probe()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

WARNING: drivers/hwmon/sht15.o(.data+0x144): Section mismatch in reference from
the variable sht_drivers to the function .devexit.text:sht15_remove()
The variable sht_drivers references
the function __devexit sht15_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,



Signed-off-by: Zhenwen Xu <helight.xu@gmail.com>
---
 drivers/hwmon/sht15.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 6cbdc2f..18061d2 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -620,7 +620,7 @@ static int __devexit sht15_remove(struct platform_device *pdev)
 }
 
 
-static struct platform_driver sht_drivers[] = {
+static struct platform_driver __refdata sht_drivers[] = {
 	{
 		.driver = {
 			.name = "sht10",
-- 
1.5.6.5

-- 
--------------------------------
http://zhwen.org - Open and Free

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
