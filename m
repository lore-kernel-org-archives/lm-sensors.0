From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 12 Feb 2010 21:51:21 +0000
Subject: [lm-sensors] [PATCH] i2c-scmi: Provide module aliases for automatic
Message-Id: <20100212215121.GM29569@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100210180116.GG29604@tux1.beaverton.ibm.com> <d35bed621002101007y639fd3c7k736ef53ff400f79@mail.gmail.com> <20100210204057.2ca95b0d@hyperion.delvare> <d35bed621002101223ida7758fp5ccbedfe25bd3148@mail.gmail.com> <20100211012105.GH29604@tux1.beaverton.ibm.com> <d35bed621002102333i701a212re957efb600cbda5f@mail.gmail.com> <20100211091743.287030b0@hyperion.delvare> <d35bed621002110842h54c8185fqf3bf481ad63df7bf@mail.gmail.com> <20100212185241.GJ29604@tux1.beaverton.ibm.com> <20100212200955.05730d69@hyperion.delvare>
In-Reply-To: <20100212200955.05730d69@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "D. Can Celasun" <dcelasun@gmail.com>, Huaxu Wan <huaxu.wan@intel.com>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Ok, here's a quick patch to provide the module aliases.  Lightly tested, and
requires the patch that defines ACPI_SMBUS_IBM_HID.
---
i2c-scmi: Provide module aliases for automatic loading

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/i2c/busses/i2c-scmi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index 4c9fb4c..388cbdc 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -54,6 +54,7 @@ static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
 	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
 	{"", 0}
 };
+MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
 
 #define ACPI_SMBUS_STATUS_OK			0x00
 #define ACPI_SMBUS_STATUS_FAIL			0x07

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
