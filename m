From: Thomas Renninger <trenn@suse.de>
Date: Fri, 13 Jul 2007 12:59:09 +0000
Subject: [lm-sensors] [PATCH - 1/2] Identify native drivers and ACPI
Message-Id: <1184331549.3960.105.camel@d88.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Bernhard Walle <bwalle@suse.de>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jean Delvare <khali@linux-fr.org>, akpm <akpm@linux-foundation.org>

Also pass the OperationRegion name to the OS validate func


Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/dispatcher/dsopcode.c |    4 +++-
 include/acpi/acpiosxf.h            |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6.22-rc5/include/acpi/acpiosxf.h
=================================--- linux-2.6.22-rc5.orig/include/acpi/acpiosxf.h
+++ linux-2.6.22-rc5/include/acpi/acpiosxf.h
@@ -239,8 +239,8 @@ acpi_status acpi_os_validate_interface(c
 acpi_status acpi_osi_invalidate(char* interface);
 
 acpi_status
-acpi_os_validate_address(u8 space_id,
-			 acpi_physical_address address, acpi_size length);
+acpi_os_validate_address(u8 space_id, acpi_physical_address address,
+			 acpi_size length, char *name);
 
 u64 acpi_os_get_timer(void);
 
Index: linux-2.6.22-rc5/drivers/acpi/dispatcher/dsopcode.c
=================================--- linux-2.6.22-rc5.orig/drivers/acpi/dispatcher/dsopcode.c
+++ linux-2.6.22-rc5/drivers/acpi/dispatcher/dsopcode.c
@@ -359,7 +359,9 @@ acpi_status acpi_ds_get_region_arguments
 
 	status = acpi_os_validate_address(obj_desc->region.space_id,
 					  obj_desc->region.address,
-					  (acpi_size) obj_desc->region.length);
+					  (acpi_size) obj_desc->region.length,
+					  acpi_ut_get_node_name(node));
+
 	if (ACPI_FAILURE(status)) {
 		/*
 		 * Invalid address/length. We will emit an error message and mark



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
