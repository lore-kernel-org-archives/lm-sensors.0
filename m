From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: i2c-i810.c bus driver
Message-Id: <20030920210754.GA17127@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030915183026.GA11108@kroah.com>
In-Reply-To: <20030915183026.GA11108@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Greg KH <greg@kroah.com> [2003-09-15 11:30:26 -0700]:
> Ugh, in looking over the bus drivers that are currently in the cvs tree,
> but not in the kernel tree, I ran accross this horrible bit of code in
> the i2c-i810.c driver:
> 
> static unsigned char *mem;
> 
> static inline void outlong(unsigned int dat, int off)
> {
> 	*((unsigned int *) (mem + off)) = dat;
> }
> 
> static inline unsigned int readlong(int off)
> {
> 	return *((unsigned int *) (mem + off));
> }
> 
> Will someone please fix this up properly to not directly access memory!
> That is not portable at all, and will do bad things on non-i386 based
> hardware platforms.
> 
> After that's done, I'll worry about porting it to 2.6, but not before...

Is this what you want?  If so I'll update it (and the other two).
Er, I'll get rid of the outlong/readlong indirection too...

Index: kernel/busses/i2c-i810.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-i810.c,v
retrieving revision 1.18
diff -u -r1.18 i2c-i810.c
--- kernel/busses/i2c-i810.c	28 Jul 2003 09:57:11 -0000	1.18
+++ kernel/busses/i2c-i810.c	20 Sep 2003 21:18:33 -0000
@@ -81,16 +81,16 @@
 static void config_i810(struct pci_dev *dev);
 
 
-static unsigned char *mem;
+static unsigned long ioaddr;
 
 static inline void outlong(unsigned int dat, int off)
 {
-	*((unsigned int *) (mem + off)) = dat;
+	writel(dat, ioaddr + off);
 }
 
 static inline unsigned int readlong(int off)
 {
-	return *((unsigned int *) (mem + off));
+	return readl(ioaddr + off);
 }
 
 /* The i810 GPIO registers have individual masks for each bit
@@ -172,8 +172,8 @@
 	cadr = dev->resource[1].start;
 	cadr += I810_IOCONTROL_OFFSET;
 	cadr &= PCI_BASE_ADDRESS_MEM_MASK;
-	mem = ioremap_nocache(cadr, 0x1000);
-	if(mem) {
+	ioaddr = (unsigned long)ioremap_nocache(cadr, 0x1000);
+	if(ioaddr) {
 		bit_i810i2c_setscl(NULL, 1);
 		bit_i810i2c_setsda(NULL, 1);
 		bit_i810ddc_setscl(NULL, 1);
@@ -308,7 +308,7 @@
 	pci_unregister_driver(&i810_driver);
 */
 	i810_remove(NULL);
-	iounmap(mem);
+	iounmap((void *)ioaddr);
 }
 
 MODULE_AUTHOR

-- 
Mark M. Hoffman
mhoffman@lightlink.com
