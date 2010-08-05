From: Julia Lawall <julia@diku.dk>
Date: Thu, 05 Aug 2010 20:25:06 +0000
Subject: [lm-sensors] [PATCH 27/42] drivers/hwmon: Adjust confusing if
Message-Id: <Pine.LNX.4.64.1008052224500.31692@ask.diku.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

The if (ret) test has no effect if the if branch is not taken, so move it
into the branch that it is already aligned with.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable braces4@
position p1,p2;
statement S1,S2;
@@

(
if (...) { ... }
|
if (...) S1@p1 S2@p2
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

if (p1[0].column = p2[0].column):
  cocci.print_main("branch",p1)
  cocci.print_secs("after",p2)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/hwmon/mc13783-adc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index ce3c7bc..0b53713 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -162,10 +162,11 @@ static int __init mc13783_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_err_create1;
 
-	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN))
+	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN)) {
 		ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
 		if (ret)
 			goto out_err_create2;
+	}
 
 	priv->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(priv->hwmon_dev)) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
