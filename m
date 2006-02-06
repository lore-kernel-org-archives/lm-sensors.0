From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:58 +0000
Subject: [lm-sensors] [PATCH] i2c: Use ARRAY_SIZE macro
Message-Id: <11392571383350@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Use ARRAY_SIZE macro

Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0]). Some trailing
whitespaces are also removed.

Signed-off-by: Tobias Klauser <tklauser at nuerscht.ch>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Russell King <rmk+kernel at arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 7e3d7db52469f6bcfbfd2d3d00dd17da573facd9
tree c6090fda544c24ddf169177ee4596121b8bd10a6
parent 8104a9a9c9ad8c849d931c46ef6841b23d1fc729
author Tobias Klauser <tklauser at nuerscht.ch> Mon, 09 Jan 2006 23:19:51 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:15 -0800

 drivers/i2c/busses/i2c-parport-light.c |    9 +++------
 drivers/i2c/busses/i2c-parport.c       |    7 ++-----
 drivers/i2c/busses/i2c-pxa.c           |    2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index 3e5eba9..c63025a 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -121,14 +121,11 @@ static struct i2c_adapter parport_adapte
 
 static int __init i2c_parport_init(void)
 {
-	int type_count;
-
-	type_count = sizeof(adapter_parm)/sizeof(struct adapter_parm);
-	if (type < 0 || type >= type_count) {
+	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
 		type = 0;
 	}
-	
+
 	if (base = 0) {
 		printk(KERN_INFO "i2c-parport: using default base 0x%x\n", DEFAULT_BASE);
 		base = DEFAULT_BASE;
@@ -152,7 +149,7 @@ static int __init i2c_parport_init(void)
 		release_region(base, 3);
 		return -ENODEV;
 	}
-	
+
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 2854d85..7e2e8cd 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -241,14 +241,11 @@ static struct parport_driver i2c_parport
 
 static int __init i2c_parport_init(void)
 {
-	int type_count;
-
-	type_count = sizeof(adapter_parm)/sizeof(struct adapter_parm);
-	if (type < 0 || type >= type_count) {
+	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
 		type = 0;
 	}
-	
+
 	return parport_register_driver(&i2c_parport_driver);
 }
 
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 86e2234..7579f4b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -861,7 +861,7 @@ static irqreturn_t i2c_pxa_handler(int t
 		decode_ISR(isr);
 	}
 
-	if (i2c->irqlogidx < sizeof(i2c->isrlog)/sizeof(u32))
+	if (i2c->irqlogidx < ARRAY_SIZE(i2c->isrlog))
 		i2c->isrlog[i2c->irqlogidx++] = isr;
 
 	show_state(i2c);


