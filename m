From: Julia Lawall <julia@diku.dk>
Date: Wed, 10 Dec 2008 16:42:38 +0000
Subject: [lm-sensors] [PATCH 26/28] drivers/hwmon/vt1211.c: Drop return
Message-Id: <Pine.LNX.4.64.0812101742170.21998@ask.diku.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dmitri.vorobiev@movial.fi, juergh@gmail.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

The return value of the remove function of a driver structure, and thus of
a platform_driver structure, is ultimately ignored, and is thus
unnecessary.  This patch removes the return value for the remove function
stored in a platform_driver structure.  For the files in this patch, the
return values are always 0.

A simplified version of the semantic patch that makes this change is as
follows: (http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r@
struct platform_driver I;
identifier a,f;
position p;
@@
I.remove = \(f@p\|a(f@p)\);

@void_called@
identifier r.f;
position p;
@@
f@p(...);

@called@
identifier r.f;
position p1 != void_called.p;
@@
f@p1(...)

@localfn@
identifier r.f;
@@
static int f(...) { ... }

@depends on !called && localfn@
struct platform_driver I;
identifier a,f;
position r.p;
@@

I.
- remove
+ remove_new
   = \(f@p\|a(f@p)\);

@depends on !called && localfn@
identifier r.f,i;
constant C;
expression E;
@@

- int
+ void
       f(...) {
  <...
(
-  return \(C\|i\);
+  return;
|
-  return E;
+  E;
+  return;
)
  ...>
}
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/hwmon/vt1211.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 12b4359..106b4bc 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -1216,7 +1216,7 @@ EXIT:
 	return err;
 }
 
-static int __devexit vt1211_remove(struct platform_device *pdev)
+static void __devexit vt1211_remove(struct platform_device *pdev)
 {
 	struct vt1211_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
@@ -1228,8 +1228,6 @@ static int __devexit vt1211_remove(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	release_region(res->start, res->end - res->start + 1);
-
-	return 0;
 }
 
 static struct platform_driver vt1211_driver = {
@@ -1238,7 +1236,7 @@ static struct platform_driver vt1211_driver = {
 		.name  = DRVNAME,
 	},
 	.probe  = vt1211_probe,
-	.remove = __devexit_p(vt1211_remove),
+	.remove_new = __devexit_p(vt1211_remove),
 };
 
 static int __init vt1211_device_add(unsigned short address)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
