From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 17 Jul 2013 20:53:05 +0000
Subject: [lm-sensors] [PATCH v3 1/4] i2c: Add DIMM bus code
Message-Id: <b8e50b55358b4f0cd1db96174a9e6a2e69780359.1374093761.git.luto@amacapital.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net>
In-Reply-To: <cover.1374093761.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>

Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
contains DIMMs.  This will probe (and autoload modules!) for useful
SMBUS devices that live on DIMMs.

As more SMBUS-addressable DIMM components become supported, this
code can be extended to probe for them.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/i2c/busses/Kconfig    |  4 +++
 drivers/i2c/busses/Makefile   |  4 +++
 drivers/i2c/busses/dimm-bus.c | 84 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/dimm-bus.h  | 24 +++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 include/linux/i2c/dimm-bus.h

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index adfee98..e837f0e 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -133,6 +133,10 @@ config I2C_ISMT
 	  This driver can also be built as a module.  If so, the module will be
 	  called i2c-ismt.
 
+config I2C_DIMM_BUS
+       tristate
+       default n
+
 config I2C_PIIX4
 	tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 8f4fc23..226bb2e 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -24,6 +24,10 @@ obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 
+# DIMM busses
+obj-$(CONFIG_I2C_DIMM_BUS)	+= dimm-bus.o
+obj-$(CONFIG_I2C_IMC)		+= i2c-imc.o
+
 # Mac SMBus host controller drivers
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
diff --git a/drivers/i2c/busses/dimm-bus.c b/drivers/i2c/busses/dimm-bus.c
new file mode 100644
index 0000000..9012638
--- /dev/null
+++ b/drivers/i2c/busses/dimm-bus.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright (c) 2013 Andrew Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/i2c.h>
+#include <linux/bug.h>
+#include <linux/module.h>
+#include <linux/i2c/dimm-bus.h>
+
+static bool probe_addr(struct i2c_adapter *adapter, int addr)
+{
+	/*
+	 * So far, all known devices that live on DIMMs can be safely
+	 * and reliably detected by trying to read a byte at address
+	 * zero.
+	 */
+	union i2c_smbus_data dummy;
+	return i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_READ, 0,
+			      I2C_SMBUS_BYTE_DATA, &dummy) >= 0;
+}
+
+/**
+ * i2c_scan_dimm_bus() - Scans an SMBUS segment known to contain DIMMs
+ * @adapter: The SMBUS adapter to scan
+ *
+ * This function tells the DIMM-bus code that the adapter is known to
+ * contain DIMMs.  i2c_scan_dimm_bus will probe for devices known to
+ * live on DIMMs.
+ *
+ * Do NOT call this function on general-purpose system SMBUS segments
+ * unless you know that the only things on the bus are DIMMs.
+ * Otherwise is it very likely to mis-identify other things on the
+ * bus.
+ *
+ * Callers are advised not to set adapter->class = I2C_CLASS_SPD.
+ */
+void i2c_scan_dimm_bus(struct i2c_adapter *adapter)
+{
+	struct i2c_board_info info = {};
+	int slot;
+
+	/*
+	 * We probe with "read byte data".  If any DIMM SMBUS driver can't
+	 * support that access type, this function should be updated.
+	 */
+	if (WARN_ON(!i2c_check_functionality(adapter,
+					  I2C_FUNC_SMBUS_READ_BYTE_DATA)))
+		return;
+
+	for (slot = 0; slot < 8; slot++) {
+		/* If there's no SPD, then assume there's no DIMM here. */
+		if (!probe_addr(adapter, 0x50 | slot))
+			continue;
+
+		strcpy(info.type, "eeprom");
+		info.addr = 0x50 | slot;
+		i2c_new_device(adapter, &info);
+
+		if (probe_addr(adapter, 0x18 | slot)) {
+			/* This is a temperature sensor. */
+			strcpy(info.type, "tsod");
+			info.addr = 0x18 | slot;
+			i2c_new_device(adapter, &info);
+		}
+	}
+}
+EXPORT_SYMBOL(i2c_scan_dimm_bus);
+
+MODULE_AUTHOR("Andrew Lutomirski <luto@amacapital.net>");
+MODULE_DESCRIPTION("i2c DIMM bus support");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/dimm-bus.h b/include/linux/i2c/dimm-bus.h
new file mode 100644
index 0000000..3d44df4
--- /dev/null
+++ b/include/linux/i2c/dimm-bus.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2013 Andrew Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _I2C_DIMM_BUS
+#define _I2C_DIMM_BUS
+
+struct i2c_adapter;
+void i2c_scan_dimm_bus(struct i2c_adapter *adapter);
+
+#endif /* _I2C_DIMM_BUS */
-- 
1.8.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
