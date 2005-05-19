From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Add secondary Super-I/O address support to
Message-Id: <20041226153110.52338750.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, 

This patch adds support for the secondary Super-I/O address to the
w83627hf driver. Most manufacturer use the primary address but at least
the EPoX EP-9NDA3+ had a Winbond W83627THF at the secondary address.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c.orig	2004-12-19 12:14:44.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c	2004-12-19 12:55:31.000000000 +0100
@@ -67,9 +67,9 @@
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
 /* modified from kernel/include/traps.c */
-#define	REG	0x2e	/* The register to read/write */
+static int REG;		/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
-#define	VAL	0x2f	/* The value to read/write */
+static int VAL;		/* The value to read/write */
 
 /* logical device numbers for superio_select (below) */
 #define W83627HF_LD_FDC		0x00
@@ -938,10 +938,13 @@
 	return i2c_detect(adapter, &addr_data, w83627hf_detect);
 }
 
-static int w83627hf_find(int *address)
+static int w83627hf_find(int sioaddr, int *address)
 {
 	u16 val;
 
+	REG = sioaddr;
+	VAL = sioaddr + 1;
+
 	superio_enter();
 	val= superio_inb(DEVID);
 	if(val != W627_DEVID &&
@@ -1422,7 +1425,8 @@
 {
 	int addr;
 
-	if (w83627hf_find(&addr)) {
+	if (w83627hf_find(0x2e, &addr)
+	 && w83627hf_find(0x4e, &addr)) {
 		return -ENODEV;
 	}
 	normal_isa[0] = addr;


-- 
Jean Delvare
http://khali.linux-fr.org/
