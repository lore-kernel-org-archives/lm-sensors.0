From: vsu@altlinux.ru (Sergey Vlasov)
Date: Wed, 24 May 2006 19:31:21 +0000
Subject: [lm-sensors] Fedora Core 5 latest kernel breaks lmsensors on
Message-Id: <20060524233121.7acca073.vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4473CDDF.1070409@charter.net>
In-Reply-To: <4473CDDF.1070409@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 May 2006 22:07:11 -0500 Laurence Vanek wrote:

> Upon updating to the latest kernel (2.6.16-1.2122_FC5) & rebooting I 
> find that I no longer have lmsensors.
[skip]
> Responses I got from the Fedora mail-list seemed to indicate that this 
> is specific to Asus M/B's.  Mine is an Asus P4B533.  I have been using 
> lmsensors on this system for several years thru many Fedora kernels.  
> The previous kernel (kernel-2.6.16-1.2111_FC5) & kernels prior work fine.
> 
> I get the impression that since a small population is having the issue 
> no effort will be made on the kernel side.

I have made a somewhat hackish workaround for this problem (not really
tested yet).  With the patch below, you will need to add 'unhide_smbus'
boot option to restore the previous behavior (however, the S3 sleep
state will be disabled even if your ACPI BIOS supports it).

There was some thinking about running PCI quirks at resume time, which
should fix the underlying problem and allow to enable unhiding again,
but such change will need much discussion and testing before it can
appear in the mainline kernel.

----------------------------------------------------------------------

Add 'unhide_smbus' boot option to unhide SMBus controllers

The recent fix for the "smbus unhiding kills thermal management"
problem just disabled the SMBus unhiding code on kernels
configured with CONFIG_ACPI_SLEEP=y.  However, some people may
use the same kernel image on different machines, some of which
need S3, and some other ones need SMBus unhiding but not S3.
This patch adds a boot option to enable SMBus unhiding even with
CONFIG_ACPI_SLEEP=y (to be safe, unhiding an SMBus controller
disables ACPI S3 sleep state).

Signed-off-by: Sergey Vlasov <vsu at altlinux.ru>

--- linux-2.6.16/drivers/acpi/sleep/main.c.alt-disable-sleep	2006-03-20 08:53:29 +0300
+++ linux-2.6.16/drivers/acpi/sleep/main.c	2006-05-20 16:50:34 +0400
@@ -20,6 +20,7 @@
 #include "sleep.h"
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
+u8 __initdata disabled_sleep_states[ACPI_S_STATE_COUNT];
 
 static struct pm_ops acpi_pm_ops;
 
@@ -209,6 +210,10 @@ static int __init acpi_sleep_init(void)
 		if (ACPI_SUCCESS(status)) {
 			sleep_states[i] = 1;
 			printk(" S%d", i);
+			if (disabled_sleep_states[i]) {
+				sleep_states[i] = 0;
+				printk("(disabled)");
+			}
 		}
 		if (i = ACPI_STATE_S4) {
 			if (sleep_states[i])
--- linux-2.6.16/drivers/pci/quirks.c.alt-unhide-smbus	2006-05-20 15:57:40 +0400
+++ linux-2.6.16/drivers/pci/quirks.c	2006-05-20 17:35:39 +0400
@@ -870,7 +870,6 @@ static void __init quirk_eisa_bridge(str
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge );
 
-#ifndef CONFIG_ACPI_SLEEP
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
@@ -889,6 +888,38 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
  */
 static int __initdata asus_hides_smbus;
 
+#ifdef CONFIG_ACPI_SLEEP
+extern u8 __initdata disabled_sleep_states[ACPI_S_STATE_COUNT];
+static int __initdata unhide_smbus_allowed;
+
+static int __init unhide_smbus_setup(char *str)
+{
+	unhide_smbus_allowed = 1;
+	return 1;
+}
+__setup("unhide_smbus", unhide_smbus_setup);
+
+static int __init can_unhide_smbus(const char *name)
+{
+	if (unhide_smbus_allowed)
+		return 1;
+	printk(KERN_INFO "PCI: %s SMBus was hidden by BIOS - boot with 'unhide_smbus' to unhide it\n"
+	       KERN_INFO "     (this will disable ACPI S3 sleep support)\n",
+	       name);
+	return 0;
+}
+
+static void __init disable_s3_after_smbus_unhide(void)
+{
+	disabled_sleep_states[ACPI_STATE_S3] = 1;
+	printk(KERN_INFO "PCI: Disabling ACPI S3 after unhiding SMBus\n");
+}
+
+#else
+#define can_unhide_smbus(name)			1
+#define disable_s3_after_smbus_unhide()		do {} while(0)
+#endif
+
 static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
 {
 	if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {
@@ -991,12 +1022,16 @@ static void __init asus_hides_smbus_lpc(
 
 	pci_read_config_word(dev, 0xF2, &val);
 	if (val & 0x8) {
+		if (!can_unhide_smbus("i801"))
+			return;
 		pci_write_config_word(dev, 0xF2, val & (~0x8));
 		pci_read_config_word(dev, 0xF2, &val);
 		if (val & 0x8)
 			printk(KERN_INFO "PCI: i801 SMBus device continues to play 'hide and seek'! 0x%x\n", val);
-		else
+		else {
 			printk(KERN_INFO "PCI: Enabled i801 SMBus device\n");
+			disable_s3_after_smbus_unhide();
+		}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
@@ -1016,14 +1051,18 @@ static void __init asus_hides_smbus_lpc_
 	base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000); /* use bits 31:14, 16 kB aligned */
 	if (base = NULL) return;
 	val=readl(base + 0x3418); /* read the Function Disable register, dword mode only */
+	if ((val & 0x00000008) = 0)
+		goto out_unmap;	/* SMBus is not disabled */
+	if (!can_unhide_smbus("ICH6"))
+		goto out_unmap;
 	writel(val & 0xFFFFFFF7, base + 0x3418); /* enable the SMBus device */
-	iounmap(base);
 	printk(KERN_INFO "PCI: Enabled ICH6/i801 SMBus device\n");
+	disable_s3_after_smbus_unhide();
+out_unmap:
+	iounmap(base);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6 );
 
-#endif
-
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */
--- linux-2.6.16/Documentation/kernel-parameters.txt.alt-unhide-smbus	2006-03-20 08:53:29 +0300
+++ linux-2.6.16/Documentation/kernel-parameters.txt	2006-05-20 17:25:11 +0400
@@ -1617,6 +1617,10 @@ running once the system is up.
 	uart6850=	[HW,OSS]
 			Format: <io>,<irq>
 
+	unhide_smbus	[HW,ACPI]
+			Unhide SMBus controllers which were hidden by BIOS.
+			This disables ACPI S3 sleep support.
+
 	usbhid.mousepoll 			[USBHID] The interval which mice are to be polled at.
 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 190 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060525/ae666152/attachment.bin
