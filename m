From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 23 Sep 2005 21:39:02 +0000
Subject: [lm-sensors] Asus Z80V/M6V i2c support
Message-Id: <433459A7.3010605@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <318b1df00509211647a24cdec@mail.gmail.com>
In-Reply-To: <318b1df00509211647a24cdec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Micha? Mleczko wrote:
> Hi,
> 
> thank you very much. I am using kernel 2.6.13. Could you give me some
> hints as to where to look for the configuration registers? I would be
> interested to find out more about this.

Hello,

As you pointed out you need to get to that enable register. This register is provided in PCI address space.
To access it you need to its base address. RCBA--Root Complex Base Address Register (page 361) Value in register
is 16KB aligned so it size is also 16KB. Then you just need to map it to address space of procesor. This
can be done via ioremap_nocache. Once mapped you just need to change right bit in right place.
Note that you can access to this register only in 32bit chunks.(so readl/writel should help).

Rest is simple. We will use PCI hostbridge vendor ID to idetify your notebook. When done, we will read
the RCBA base and do the stuff. Code I'm attaching is totally untested but I belive it should work.
Edit it to your taste and let us know if it works for you. If so I will prepare final patch and post it
to kernel. Also it seems we need the GPIO and ACPI iospace quirk too, but this can be done later.

Standard disclaimer: Do not blame us if you blow up your notebook.

Regards

Rudolf
-------------- next part --------------
diff -Naur a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-09-20 05:00:41.000000000 +0200
+++ b/drivers/pci/quirks.c	2005-09-23 21:36:12.649136000 +0200
@@ -847,6 +847,12 @@
 			case 0x186a: /* M6Ne notebook */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device = PCI_DEVICE_ID_INTEL_82915GM_HB)
+			switch (dev->subsystem_device) {
+			case 0x1882: /* MV6V notebook */
+				asus_hides_smbus = 1;
+			}
+			
 	} else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_HP)) {
 		if (dev->device =  PCI_DEVICE_ID_INTEL_82855PM_HB)
 			switch(dev->subsystem_device) {
@@ -891,6 +897,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB,	asus_hides_smbus_hostbridge );
 
 static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
 {
@@ -915,6 +922,27 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
 
+static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+{
+	u32 val;
+	u32 rcba;
+	void __iomem *base;
+
+	if (likely(!asus_hides_smbus))
+		return;
+	pci_read_config_dword(dev, 0xF0, &rcba);
+	base = ioremap_nocache(rcba,0x4000);
+	printk(KERN_INFO "PCI: Trying to enable ICH6 SMBus. RCBA base 0x%x relocated 0x%x \n",rcba,base);
+	if (base = NULL) return;
+	val=readl(base+0x3418);
+	val&=0xFFFFFFF7;
+	writel(val,base+0x3418);
+	iounmap(rcba);
+	printk(KERN_INFO "PCI: Done. I wrote: %x\n",val);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
+
+
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */
