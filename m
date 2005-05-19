From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:18 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734251033@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734243430@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1315.1.18, 2003/09/22 13:30:23-07:00, greg@kroah.com

[PATCH] I2C: clean up i2c-philips-par.c driver a bit

Fix bug when registering the i2c_adap as the structure was not set to 0.


 drivers/i2c/busses/i2c-philips-par.c |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- a/drivers/i2c/busses/i2c-philips-par.c	Mon Sep 22 16:13:06 2003
+++ b/drivers/i2c/busses/i2c-philips-par.c	Mon Sep 22 16:13:06 2003
@@ -24,10 +24,8 @@
 /* $Id: i2c-philips-par.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
 
 #include <linux/kernel.h>
-#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/stddef.h>
 #include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -45,11 +43,6 @@
 static struct i2c_par *adapter_list;
 
 
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)		/* should be reasonable open, close &c. 	*/
-#define DEB2(x) 	/* low level debugging - very slow 		*/
-#define DEBE(x)	x	/* error messages 				*/
-
 /* ----- printer port defines ------------------------------------------*/
 					/* Pin Port  Inverted	name	*/
 #define I2C_ON		0x20		/* 12 status N	paper		*/
@@ -163,8 +156,9 @@
 		printk(KERN_ERR "i2c-philips-par: Unable to malloc.\n");
 		return;
 	}
+	memset (adapter, 0x00, sizeof(struct i2c_par));
 
-	printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name);
+	/* printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name); */
 
 	adapter->pdev = parport_register_device(port, "i2c-philips-par",
 						NULL, NULL, NULL, 
@@ -191,8 +185,7 @@
 	bit_lp_setscl(port, 1);
 	parport_release(adapter->pdev);
 
-	if (i2c_bit_add_bus(&adapter->adapter) < 0)
-	{
+	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
 		printk(KERN_ERR "i2c-philips-par: Unable to register with I2C.\n");
 		parport_unregister_device(adapter->pdev);
 		kfree(adapter);
@@ -207,10 +200,8 @@
 {
 	struct i2c_par *adapter, *prev = NULL;
 
-	for (adapter = adapter_list; adapter; adapter = adapter->next)
-	{
-		if (adapter->pdev->port = port)
-		{
+	for (adapter = adapter_list; adapter; adapter = adapter->next) {
+		if (adapter->pdev->port = port) {
 			parport_unregister_device(adapter->pdev);
 			i2c_bit_del_bus(&adapter->adapter);
 			if (prev)
@@ -224,21 +215,17 @@
 	}
 }
 
-
 static struct parport_driver i2c_driver = {
-	"i2c-philips-par",
-	i2c_parport_attach,
-	i2c_parport_detach,
-	NULL
+	.name =		"i2c-philips-par",
+	.attach =	i2c_parport_attach,
+	.detach =	i2c_parport_detach,
 };
 
 int __init i2c_bitlp_init(void)
 {
-	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c Philips parallel port adapter driver\n");
 
-	parport_register_driver(&i2c_driver);
-	
-	return 0;
+	return parport_register_driver(&i2c_driver);
 }
 
 void __exit i2c_bitlp_exit(void)

