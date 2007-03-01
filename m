From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 09:54:27 +0000
Subject: [lm-sensors] Asus P4R800-VM with w83627THF sensor
Message-Id: <20070301105427.697e4dd5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45B2BB3B.4000603@eltofts.homelinux.com>
In-Reply-To: <45B2BB3B.4000603@eltofts.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andy,

On Thu, 01 Mar 2007 01:07:56 +0000, Andy Wright wrote:
> Jean Delvare wrote:
> > On Sun, 21 Jan 2007 01:00:43 +0000, Andy Wright wrote:
> >   
> >> I'm trying to get lm_sensors working on an asus p4r800-vm motherboard. 
> >> OS is Centos 4.4 running Kernel 2.6.9-42.0.3.EL and I have installed the 
> >> libsysfs library from the lm-sensors.org website.
> >>
> >> sensors-detect gives the following;
> >>
> >> Driver 'w83627hf' (should be inserted):
> >>   Detects correctly:
> >>   *  ISA bus address 0x0228 (Busdriver 'i2c-isa')
> >>       Chip 'Winbond W83627THF Super IO Sensors' (confidence: 9)
> >>
> >> modprobe i2c-isa succeeds
> >>
> >> modprobe w83627hf   fails with;
> >>
> >> FATAL: Error inserting w83627hf 
> >> (/lib/modules/2.6.9-42.0.3.EL/kernel/drivers/i2c/chips/w83627hf.ko): No 
> >> such device
> >>
> >> Would anyone have any pointers as to how to get this going ?
> >
> > Was the W83627THF chip found as the "primary" or "secondary" Super-I/O
> > chip? (sensors-detect should tell you)
> 
> It was discovered as the secondary.....

Support for the secondary Super-I/O address was added to the w83627hf
driver in kernel 2.6.11. This is the reason why it doesn't work with
your 2.6.9 kernel. You will need to backport the following patch:

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

