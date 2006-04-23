From: bunk@stusta.de (Adrian Bunk)
Date: Sun, 23 Apr 2006 21:38:29 +0000
Subject: [lm-sensors] [2.6 patch] drivers/w1/: possible cleanups
Message-Id: <20060423213829.GH13666@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch contains the following possible cleanups:
- the following file did't #include the header with the prototypes for
  it's global functions:
  - w1_int.c
- #if 0 the following unused global function:
  - w1_family.c: w1_family_get()
- make the following needlessly global functions static:
  - w1_family.c: __w1_family_put()
  - w1_io.c: w1_delay()
  - w1_io.c: w1_touch_bit()
  - w1_io.c: w1_read_8()
- remove the following unused EXPORT_SYMBOL's:
  - w1_family.c: w1_family_put
  - w1_family.c: w1_family_registered

Signed-off-by: Adrian Bunk <bunk at stusta.de>

---

 drivers/w1/w1.h        |    3 ---
 drivers/w1/w1_family.c |   18 ++++++++----------
 drivers/w1/w1_family.h |    2 --
 drivers/w1/w1_int.c    |    1 +
 drivers/w1/w1_io.c     |    6 +++---
 drivers/w1/w1_io.h     |    3 ---
 6 files changed, 12 insertions(+), 21 deletions(-)

--- linux-2.6.17-rc1-mm3-full/drivers/w1/w1_family.h.old	2006-04-23 23:07:27.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/w1/w1_family.h	2006-04-23 23:08:42.000000000 +0200
@@ -57,10 +57,8 @@
 
 extern spinlock_t w1_flock;
 
-void w1_family_get(struct w1_family *);
 void w1_family_put(struct w1_family *);
 void __w1_family_get(struct w1_family *);
-void __w1_family_put(struct w1_family *);
 struct w1_family * w1_family_registered(u8);
 void w1_unregister_family(struct w1_family *);
 int w1_register_family(struct w1_family *);
--- linux-2.6.17-rc1-mm3-full/drivers/w1/w1_family.c.old	2006-04-23 23:07:40.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/w1/w1_family.c	2006-04-23 23:09:09.000000000 +0200
@@ -107,6 +107,12 @@
 	return (ret) ? f : NULL;
 }
 
+static void __w1_family_put(struct w1_family *f)
+{
+	if (atomic_dec_and_test(&f->refcnt))
+		f->need_exit = 1;
+}
+
 void w1_family_put(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
@@ -114,19 +120,14 @@
 	spin_unlock(&w1_flock);
 }
 
-void __w1_family_put(struct w1_family *f)
-{
-	if (atomic_dec_and_test(&f->refcnt))
-		f->need_exit = 1;
-}
-
+#if 0
 void w1_family_get(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
 	__w1_family_get(f);
 	spin_unlock(&w1_flock);
-
 }
+#endif  /*  0  */
 
 void __w1_family_get(struct w1_family *f)
 {
@@ -135,8 +136,5 @@
 	smp_mb__after_atomic_inc();
 }
 
-EXPORT_SYMBOL(w1_family_get);
-EXPORT_SYMBOL(w1_family_put);
-EXPORT_SYMBOL(w1_family_registered);
 EXPORT_SYMBOL(w1_unregister_family);
 EXPORT_SYMBOL(w1_register_family);
--- linux-2.6.17-rc1-mm3-full/drivers/w1/w1.h.old	2006-04-23 23:10:32.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/w1/w1.h	2006-04-23 23:11:34.000000000 +0200
@@ -187,11 +187,8 @@
 void w1_search_process(struct w1_master *dev, u8 search_type);
 struct w1_master *w1_search_master_id(u32 id);
 
-void w1_delay(unsigned long);
-u8 w1_touch_bit(struct w1_master *, int);
 u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
--- linux-2.6.17-rc1-mm3-full/drivers/w1/w1_io.h.old	2006-04-23 23:10:46.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/w1/w1_io.h	2006-04-23 23:12:04.000000000 +0200
@@ -24,11 +24,8 @@
 
 #include "w1.h"
 
-void w1_delay(unsigned long);
-u8 w1_touch_bit(struct w1_master *, int);
 u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
--- linux-2.6.17-rc1-mm3-full/drivers/w1/w1_io.c.old	2006-04-23 23:10:57.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/w1/w1_io.c	2006-04-23 23:11:45.000000000 +0200
@@ -50,7 +50,7 @@
 	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
 };
 
-void w1_delay(unsigned long tm)
+static void w1_delay(unsigned long tm)
 {
 	udelay(tm * w1_delay_parm);
 }
@@ -61,7 +61,7 @@
 /**
  * Generates a write-0 or write-1 cycle and samples the level.
  */
-u8 w1_touch_bit(struct w1_master *dev, int bit)
+static u8 w1_touch_bit(struct w1_master *dev, int bit)
 {
 	if (dev->bus_master->touch_bit)
 		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
@@ -177,7 +177,7 @@
  * @param dev     the master device
  * @return        the byte read
  */
-u8 w1_read_8(struct w1_master * dev)
+static u8 w1_read_8(struct w1_master * dev)
 {
 	int i;
 	u8 res = 0;
--- linux-2.6.17-rc1-mm3-full/drivers/w1/w1_int.c.old	2006-04-23 23:28:59.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/w1/w1_int.c	2006-04-23 23:29:18.000000000 +0200
@@ -27,6 +27,7 @@
 #include "w1.h"
 #include "w1_log.h"
 #include "w1_netlink.h"
+#include "w1_int.h"
 
 static u32 w1_ids = 1;
 


