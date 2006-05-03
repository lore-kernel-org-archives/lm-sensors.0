From: tandrews@grok.co.za (Thomas Andrews)
Date: Wed, 03 May 2006 19:59:18 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060503195918.GF19375@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

On Wed, May 03, 2006 at 01:39:45PM +0200, Alexander Krause wrote:

> And I'm open for tests ;-)

OK, I'm attaching a patch based on:

/usr/src/linux-2.6.15/drivers/i2c/busses/scx200_acb.c

This patch is to set up the base addresses automatically without
probing (or guessing.)

As I mentioned earlier the patch is untested because I am actually
making the changes on a 2.4 kernel. Please let me know if *anything*
goes wrong on 2.6. If it breaks, I will only be able to get a 2.6 dev
system up next week to debug it :(

8<----------8<----------8<----------8<----------8<----------8<----------

Usage notes:

The driver now finds out by looking at the PCI configuration registers
where exactly the SIO is, so it no longer has to guess 2e, 4e, 15c...
If you don't want this automatic look-up of SIO, you can just specify it
as a module parameter: sioaddr

sioaddr can take up to 4 parameters. Use it to force the driver to use a
specific value of SIO. 0x2e is common, but 0x4e and 0x15c are also
possible.

The base address is now also looked up using the PCI configuration
registers. There are two of these addresses eg 0x810 and 0x820. Once the
driver has a value for sioaddr, it looks up the base address. If you
don't want this automatic lookup of the base addresses, you can still
specify them as module parameters as before. If you do this, it does not
bother to find out what sioaddr is.

As before, specify it as a list of one to four comma-delimited values
eg: base=0x810,0x820,0x830. It will try everything in the list.

8<----------8<----------8<----------8<----------8<----------8<----------

Regards,
Thomas
-------------- next part --------------
diff -Naur orig/scx200_acb.c latest/scx200_acb.c
--- orig/scx200_acb.c	2006-05-03 21:02:04.000000000 +0200
+++ latest/scx200_acb.c	2006-05-03 21:15:57.000000000 +0200
@@ -43,9 +43,15 @@
 MODULE_LICENSE("GPL");
 
 #define MAX_DEVICES 4
-static int base[MAX_DEVICES] = { 0x820, 0x840 };
-module_param_array(base, int, NULL, 0);
+#define MAX_SIO_ADDRS 4
+static int base[MAX_DEVICES] = { };
+static int sioaddr[MAX_SIO_ADDRS] = { };
+MODULE_PARM(base, "1-4i");
+MODULE_PARM(sioaddr, "1-4i");
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
+MODULE_PARM_DESC(sioaddr, "SIO addresses for the ACCESS.bus controllers");
+module_param_array(base, int, NULL, 0);
+module_param_array(sioaddr, int, NULL, 0);
 
 #ifdef DEBUG
 #define DBG(x...) printk(KERN_DEBUG NAME ": " x)
@@ -116,8 +122,116 @@
 #define ACBCTL2		(iface->base + 5)
 #define    ACBCTL2_ENABLE	0x01
 
+/* Static port addresses in the PCI configuration space */
+#define CAR 0xCF8	/* Configuration Address Register */
+#define CDR 0xCFC	/* Configuration Data Register */
+
+static int deviceno;
+
 /************************************************************************/
 
+static unsigned long scx200_get_pci_deviceno(void)
+{
+	unsigned long reg;
+
+	/* Depending on the setting of IO_STRAP_IDSEL_SELECT (F5BAR0+I/O Offset 04h[0])
+	 * the PCI "device number" (used to read anything in the F0 - F5 config space)
+	 * can be either 1001b or 1000b for IO_STRAP_IDSEL_SELECT=0/1 respectively
+	 * This is the only thing we have to probe for. */
+
+	// Try with the default device no of 1001b to read the Vendor & Device ID
+	outl((unsigned)0x80000000 | 0x9000, CAR);
+	reg = inl(CDR);
+	if (((reg >> 16) & 0xFFFF) = 0x0510)
+		return (0x9000);
+
+	// Try with the alternative device no of 1000b to read the Vendor & Device ID
+	outl((unsigned)0x80000000 | 0x8000, CAR);
+	reg = inl(CDR);
+	if (((reg >> 16) & 0xFFFF) = 0x0510)
+		return (0x8000);
+
+	return 0; // Couldn't find it
+}
+
+static unsigned long scx200_get_baseaddr(unsigned long addr)
+{
+	// Retrieve FnBARx
+	outl(addr, CAR);
+	return ((inl(CDR)) & 0xFFFFFFC0);
+}
+
+static int scx200_acb_detect_sioaddr(void)
+{
+	int base;
+	unsigned long siocfg_in, lad_en;
+
+	deviceno = scx200_get_pci_deviceno();
+	if (!deviceno)
+		return 0;
+	DBG("deviceno is %#x\n",deviceno);
+
+	// Read IO_SIOCFG_IN 
+	base = scx200_get_baseaddr(0x80000500 | deviceno | 0x10); // Retrueve F5BAR0
+	siocfg_in = ((inl(base))>>25)&3;
+	DBG("IO_SIOCFG_IN is %x\n", (unsigned int) siocfg_in);
+	switch (siocfg_in) {
+	case 0:		// SIO disabled!
+	case 1:		// SIO configuration access denied!
+		return 0;
+	case 2:		// Base address 1 (2e/2f) selected (or perhaps 4e/4f)
+		base = scx200_get_baseaddr(0x80000000 | deviceno | 0x14); // Retrieve F0BAR1
+		// Get LAD_EN - LPC address enable register: bit 14 is "LPC alternate SIO addressing"
+		lad_en = ((inl(base+0x10))>>14)&1;
+		DBG("LPC alternate SIO addressing is %x\n", (unsigned int) lad_en);
+		return (lad_en ? 0x4e : 0x2e);
+	case 3:		// Base address 2 (15c/15d) selected
+		return 0x15c;
+	}
+
+	return 0;
+}
+
+static int scx200_acb_detect_baseaddr(int sio, int *acb1, int* acb2)
+{
+	unsigned char h1,l1,h2,l2;
+	int val = sio+1;
+
+	// First let's check for the ID of the SIO
+	printk(KERN_DEBUG NAME ": Probing for SIO at address %#x\n",sio);
+	outb(0x20,sio); // SIO ID register
+	if (inb(val) != 0xF5) {
+		*acb1 = 0;
+		*acb2 = 0;
+		printk(KERN_DEBUG NAME ": SIO not found at %x\n",sio);
+		return -1;
+	}
+
+	// Select ACB0 (LDN 5)
+	outb(0x07,sio); // LDN select register
+	outb(0x05,val); // Choose LDN 5 ie ACCESS.bus 1
+	outb(0x60,sio); // Select I/O port 0 base addr
+	h1 = inb(val);
+	outb(0x61,sio);
+	l1 = inb(val);
+
+	// Select ACB1 (LDN 6)
+	outb(0x07,sio); // LDN select register
+	outb(0x06,val); // Choose LDN 6 ie ACCESS.bus 2
+	outb(0x60,sio); // Select I/O port 0 base addr
+	h2 = inb(val);
+	outb(0x61,sio);
+	l2 = inb(val);
+	*acb1 = (h1 << 8) | l1;
+	*acb2 = (h2 << 8) | l2;    
+	if (*acb1 = 0xffff)   // Not a valid address
+		*acb1 = 0;
+	if (*acb2 = 0xffff)   // Not a valid address
+		*acb2 = 0;
+	printk(KERN_DEBUG NAME ": Found ACB0 at %#x, ACB1 at %#x\n",*acb1,*acb2);
+	return 0;
+}
+
 static void scx200_acb_machine(struct scx200_acb_iface *iface, u8 status)
 {
 	const char *errmsg;
@@ -404,6 +518,11 @@
 static int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
 	u8 val;
+	u8 acbctl1,acbctl2;
+
+	// In case probing fails
+	acbctl1 = inb(ACBCTL1);
+	acbctl2 = inb(ACBCTL2);
 
 	/* Disable the ACCESS.bus device and Configure the SCL
            frequency: 16 clock cycles */
@@ -411,7 +530,7 @@
 
 	if (inb(ACBCTL2) != 0x70) {
 		DBG("ACBCTL2 readback failed\n");
-		return -ENXIO;
+		goto errout;
 	}
 
 	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
@@ -419,7 +538,7 @@
 	val = inb(ACBCTL1);
 	if (val) {
 		DBG("disabled, but ACBCTL1=0x%02x\n", val);
-		return -ENXIO;
+		goto errout;
 	}
 
 	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
@@ -429,10 +548,15 @@
 	val = inb(ACBCTL1);
 	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
 		DBG("enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", val);
-		return -ENXIO;
+		goto errout;
 	}
 
 	return 0;
+
+ errout:	// Try to restore clobbered registers
+	outb(acbctl1, ACBCTL1);
+	outb(acbctl2, ACBCTL2);
+	return -ENXIO;
 }
 
 static int  __init scx200_acb_create(int base, int index)
@@ -508,6 +632,10 @@
 {
 	int i;
 	int rc;
+	int probe = 1;
+	int acb1_base = 0;
+	int acb2_base = 0;
+	int sio = 0;
 
 	pr_debug(NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
 
@@ -517,11 +645,42 @@
 
 	rc = -ENXIO;
 	for (i = 0; i < MAX_DEVICES; ++i) {
-		if (base[i] > 0)
+		if (base[i] > 0) {
+			probe = 0;	// A base address was specified, so turn off probing for base
 			rc = scx200_acb_create(base[i], i);
 	}
-	if (scx200_acb_list)
+	}
+	// You need an sioaddr to be able to read the base addresses, so do that first
+	if (probe) {		// No static base addresses specified, so let's probe it
+		for (i=0; i< MAX_SIO_ADDRS; i++) {
+			if (sioaddr[i]) {
+				probe = 0;	// An sio address was specified, so turn off probing for sio
+				if(scx200_acb_detect_baseaddr(sioaddr[i], &acb1_base, &acb2_base) = 0) {
+					if (acb1_base)
+						rc = scx200_acb_create(acb1_base, 0);
+					if (acb2_base)
+						rc = scx200_acb_create(acb2_base, 1);
+					sio = sioaddr[i];
+					break; // No point looking further if the SIO was found
+				}
+			}
+		}
+		if (probe) {					// sioaddr was not specified
+			if (!(sio = scx200_acb_detect_sioaddr()))
+				return -ENODEV;			// couldn't find the sio
+			if(scx200_acb_detect_baseaddr(sio, &acb1_base, &acb2_base) = 0) {
+				if (acb1_base)
+					rc = scx200_acb_create(acb1_base, 0);
+				if (acb2_base)
+					rc = scx200_acb_create(acb2_base, 1);
+			} else {
+				return -ENODEV;			// couldn't read the base addresses
+			}
+		}
+	}
+	if (scx200_acb_list) {
 		return 0;
+	}
 	return rc;
 }
 
