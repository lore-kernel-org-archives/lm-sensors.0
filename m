From: Julia Lawall <julia@diku.dk>
Date: Wed, 10 Dec 2008 16:41:06 +0000
Subject: [lm-sensors] [PATCH 22/28] drivers/hwmon/dme1737.c: Drop return
Message-Id: <Pine.LNX.4.64.0812101740430.21998@ask.diku.dk>
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
 drivers/hwmon/dme1737.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 27a5d39..3a9b988 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2465,7 +2465,7 @@ exit:
 	return err;
 }
 
-static int __devexit dme1737_isa_remove(struct platform_device *pdev)
+static void __devexit dme1737_isa_remove(struct platform_device *pdev)
 {
 	struct dme1737_data *data = platform_get_drvdata(pdev);
 
@@ -2474,8 +2474,6 @@ static int __devexit dme1737_isa_remove(struct platform_device *pdev)
 	release_region(data->addr, DME1737_EXTENT);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
-
-	return 0;
 }
 
 static struct platform_driver dme1737_isa_driver = {
@@ -2484,7 +2482,7 @@ static struct platform_driver dme1737_isa_driver = {
 		.name = "dme1737",
 	},
 	.probe = dme1737_isa_probe,
-	.remove = __devexit_p(dme1737_isa_remove),
+	.remove_new = __devexit_p(dme1737_isa_remove),
 };
 
 /* ---------------------------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
