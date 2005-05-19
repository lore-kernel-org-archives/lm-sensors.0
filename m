From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Refactor swap_bytes in i2c chip drivers
Message-Id: <20040329212303.2b47b12d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This simple patch refactors the swap_bytes function that various chip
drivers use. I moved it to lm75.h because all drivers using lm75-like
temperature sensors will most necessarily need to swap bytes.

Apply if you like it,
thanks.

Note #1: There's one more driver, gl518sm, that still has swap_bytes. I
did not factor this one because it's not using the other functions
provided by lm75.c (nor has it to).

Note #2: Looks like each time we manipulate 16-bit registers we end up
swapping bytes. It looks like we chose the wrong order as the default. I
fear it's a bit late to change that though.

diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/asb100.c linux-2.6.5-rc2/drivers/i2c/chips/asb100.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/asb100.c	Mon Mar 29 20:50:39 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/asb100.c	Mon Mar 29 21:00:46 2004
@@ -862,11 +862,6 @@
 	return 0;
 }
 
-static u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* The SMBus locks itself, usually, but nothing may access the chip between
    bank switches. */
 static int asb100_read_value(struct i2c_client *client, u16 reg)
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/ds1621.c linux-2.6.5-rc2/drivers/i2c/chips/ds1621.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/ds1621.c	Mon Mar 29 20:46:02 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/ds1621.c	Mon Mar 29 21:00:46 2004
@@ -97,11 +97,6 @@
 
 static int ds1621_id = 0;
 
-static u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* All registers are word-sized, except for the configuration register.
    DS1621 uses a high-byte first convention, which is exactly opposite to
    the usual practice. */
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/lm75.c linux-2.6.5-rc2/drivers/i2c/chips/lm75.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/lm75.c	Mon Mar 29 20:46:02 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/lm75.c	Mon Mar 29 21:00:46 2004
@@ -206,11 +206,6 @@
 	return 0;
 }
 
-static u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* All registers are word-sized, except for the configuration register.
    LM75 uses a high-byte first convention, which is exactly opposite to
    the usual practice. */
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/lm75.h linux-2.6.5-rc2/drivers/i2c/chips/lm75.h
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/lm75.h	Fri Jan 16 20:10:16 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/lm75.h	Mon Mar 29 21:06:20 2004
@@ -47,3 +47,7 @@
 	return ((s16)reg / 128) * 500;
 }
 
+static inline u16 swap_bytes(u16 val)
+{
+	return (val >> 8) | (val << 8);
+}
diff -ruN linux-2.6.5-rc2/drivers/i2c/chips.orig/w83781d.c linux-2.6.5-rc2/drivers/i2c/chips/w83781d.c
--- linux-2.6.5-rc2/drivers/i2c/chips.orig/w83781d.c	Mon Mar 29 20:50:39 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/w83781d.c	Mon Mar 29 21:00:46 2004
@@ -275,11 +275,6 @@
 static struct w83781d_data *w83781d_update_device(struct device *dev);
 static void w83781d_init_client(struct i2c_client *client);
 
-static inline u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 static struct i2c_driver w83781d_driver = {
 	.owner = THIS_MODULE,
 	.name = "w83781d",


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
