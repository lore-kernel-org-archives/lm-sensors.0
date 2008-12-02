From: Nicolas Palix <npalix@diku.dk>
Date: Tue, 02 Dec 2008 13:48:13 +0000
Subject: [lm-sensors] [PATCH linux-next] hwmon/ams: Add missing of_node_put
Message-Id: <200812021448.13543.npalix@diku.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@arrakis.delvare>, Paul Mackerras <paulus@samba.org>
Cc: Stelian Pop <stelian@popies.net>, Stephen Rothwell <sfr@canb.auug.org.au>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia@diku.dk>, Nicolas Palix <npalix@diku.dk>


of_node_put is needed before discarding a value received from
of_find_node_by_name, eg in error handling code or when the device
node is no longer used.

The semantic match that catches the bug is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
local idexpression struct device_node *n;
position p1, p2;
statement S1,S2;
expression E,E1;
expression *ptr != NULL;
@@

(
if (!(n@p1 = of_find_node_by_name(...))) S1
|
n@p1 = of_find_node_by_name(...)
)
<... when != of_node_put(n)
    when != if (...) { <+... of_node_put(n) ...+> }
    when != true !n  || ...
    when != n = E
    when != E = n
if (!n || ...) S2
...>
(
  return \(0\|<+...n...+>\|ptr\);
|
return@p2 ...;
|
n = E1
|
E1 = n
)
@script:python@
p1 << r.p1;
p2 << r.p2;
@@

print "* file: %s of_find_node_by_name %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
// </smpl>

Signed-off-by: Nicolas Palix <npalix@diku.dk>
Signed-off-by: Julia Lawall <julia@diku.dk>
---
 drivers/hwmon/ams/ams-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
index 6c9ace1..e612af9 100644
--- a/drivers/hwmon/ams/ams-core.c
+++ b/drivers/hwmon/ams/ams-core.c
@@ -202,6 +202,7 @@ int __init ams_init(void)
 	if (np && of_device_is_compatible(np, "AAPL,accelerometer_1"))
 		/* Found I2C motion sensor */
 		return ams_i2c_init(np);
+	of_node_put(np);
 #endif
 
 #ifdef CONFIG_SENSORS_AMS_PMU
@@ -209,6 +210,7 @@ int __init ams_init(void)
 	if (np && of_device_is_compatible(np, "sms"))
 		/* Found PMU motion sensor */
 		return ams_pmu_init(np);
+	of_node_put(np);
 #endif
 	return -ENODEV;
 }
-- 
Nicolas Palix

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
