From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Mar 2007 21:28:47 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070306222847.85b4aff4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<20070218183805.5a4fd813.khali@linux-fr.org>
	<20070228213803.GA4877@ucw.cz>
	<20070301152655.f232db64.khali@linux-fr.org>
	<20070302114023.GD2163@elf.ucw.cz>
	<20070302150313.198b6053.khali@linux-fr.org>
	<20070302145709.GA3710@srcf.ucam.org>
	<20070302224155.143b8643.khali@linux-fr.org>
	<20070302214643.GA10774@srcf.ucam.org>
In-Reply-To: <20070302214643.GA10774@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@ucw.cz>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Matthew,

On Fri, 2 Mar 2007 21:46:43 +0000, Matthew Garrett wrote:
> On Fri, Mar 02, 2007 at 10:41:55PM +0100, Jean Delvare wrote:
> 
> > I like the patch, after adding some casts to the printf args it
> > compiles fine. However you print warnings each time a resource has been
> > reserved... without checking if it hasn't been reserved by ACPI itself!
> > My machine looks like this:
> 
> Oops! I'll look into fixing that. Thanks, that's an excellent point...

Here is what I have come up with, by mixing your patch with Rudolf
Marek's one. Again this is only a reporting patch, but now it only
reports real unreserved accesses. I plan to use it for debugging
purposes.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/acpi/osl.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

--- linux-2.6.21-rc2.orig/drivers/acpi/osl.c	2007-03-06 20:59:00.000000000 +0100
+++ linux-2.6.21-rc2/drivers/acpi/osl.c	2007-03-06 21:33:13.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/kmod.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
+#include <linux/ioport.h>
 #include <linux/nmi.h>
 #include <linux/acpi.h>
 #include <acpi/acpi.h>
@@ -370,6 +371,7 @@ u64 acpi_os_get_timer(void)
 acpi_status acpi_os_read_port(acpi_io_address port, u32 * value, u32 width)
 {
 	u32 dummy;
+	struct resource *conflict, res;
 
 	if (!value)
 		value = &dummy;
@@ -388,6 +390,23 @@ acpi_status acpi_os_read_port(acpi_io_ad
 		BUG();
 	}
 
+	res.flags = IORESOURCE_IO;
+	res.name = "_ACPI Access";
+	res.start = port;
+	res.end = port + width/8 - 1;
+
+	conflict = ____request_resource(&ioport_resource, &res);
+	while (conflict && conflict->child)
+		conflict = ____request_resource(conflict, &res);
+
+	if (conflict && strncmp(conflict->name, "ACPI ", 5)) {
+		printk (KERN_INFO "ACPI read from allocated ioport %lx, value %lx, width %d\n",
+			(unsigned long)port, (unsigned long)(*value), (int)width);
+	}
+
+	if (conflict = NULL)
+		release_resource(&res);
+
 	return AE_OK;
 }
 
@@ -395,6 +414,25 @@ EXPORT_SYMBOL(acpi_os_read_port);
 
 acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 {
+	struct resource *conflict, res;
+
+	res.flags = IORESOURCE_IO;
+	res.name = "_ACPI Access";
+	res.start = port;
+	res.end = port + width/8 - 1;
+
+	conflict = ____request_resource(&ioport_resource, &res);
+	while (conflict && conflict->child)
+		conflict = ____request_resource(conflict, &res);
+
+	if (conflict && strncmp(conflict->name, "ACPI ", 5)) {
+		printk (KERN_INFO "ACPI write to allocated ioport %lx, value %lx, width %d\n",
+			(unsigned long)port, (unsigned long)(value), (int)width);
+	}
+
+	if (conflict = NULL)
+		release_resource(&res);
+
 	switch (width) {
 	case 8:
 		outb(value, port);
@@ -419,6 +457,7 @@ acpi_os_read_memory(acpi_physical_addres
 {
 	u32 dummy;
 	void __iomem *virt_addr;
+	struct resource *conflict, res;
 
 	virt_addr = ioremap(phys_addr, width);
 	if (!value)
@@ -440,6 +479,22 @@ acpi_os_read_memory(acpi_physical_addres
 
 	iounmap(virt_addr);
 
+	res.flags = IORESOURCE_MEM;
+	res.name = "_ACPI Access";
+	res.start = phys_addr;
+	res.end = phys_addr + width/8 - 1;
+
+	conflict = ____request_resource(&iomem_resource, &res);
+	while (conflict && conflict->child)
+		conflict = ____request_resource(conflict, &res);
+
+	if (conflict && strncmp(conflict->name, "ACPI ", 5))
+		pr_info("ACPI read from allocated iomem %lx, value %lx, width %d\n",
+			(unsigned long)phys_addr, (unsigned long)(*value), (int)width);
+
+	if (conflict = NULL)
+		release_resource(&res);
+
 	return AE_OK;
 }
 
@@ -447,6 +502,23 @@ acpi_status
 acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
+	struct resource *conflict, res;
+
+	res.flags = IORESOURCE_MEM;
+	res.name = "_ACPI Access";
+	res.start = phys_addr;
+	res.end = phys_addr + width/8 - 1;
+
+	conflict = ____request_resource(&iomem_resource, &res);
+	while (conflict && conflict->child)
+		conflict = ____request_resource(conflict, &res);
+
+	if (conflict && strncmp(conflict->name, "ACPI ", 5))
+		pr_info("ACPI write to allocated iomem %lx, value %lx, width %d\n",
+			(unsigned long)phys_addr, (unsigned long)value, (int)width);
+
+	if (conflict = NULL)
+		release_resource(&res);
 
 	virt_addr = ioremap(phys_addr, width);
 


-- 
Jean Delvare

