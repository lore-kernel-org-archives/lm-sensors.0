From: kl@gjs.cc (GertJan Spoelman)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: Fwd: [PATCH] (1/3) i2c-isa, via686a and w8378x series sensors support for 2.5.58
Message-Id: <200301170057.05298.kl@gjs.cc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have ported the i2c-isa driver and the via686a and w83781d driver and sent
them to Linus for inclusion in the 2.5 kernel, don't know if he will accept them.
I probably should have mailed you before about this, I hope you don't mind.
I did these because I use them myself, if you would like it I can try to port some
others too and sent them to you for testing, I can't test any other sensors
because I don't have any hardware with other sensors then these 2.

Regards,

	GertJan

----------  Forwarded Message  ----------

Subject: [PATCH] (1/3) i2c-isa, via686a and w8378x series sensors support for 2.5.58
Date: Thu, 16 Jan 2003 21:52:01 +0100
From: GertJan Spoelman <kl@gjs.cc>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello Linus,

These 3 patches provide support for the Pseudo ISA adapter (i2c-isa),
the VIA 686A Integrated Hardware Monitor (via686a) and Winbond W8378x series
(w83781d) sensors.
Both sensors depend on i2c-isa.
The added files are modified versions of the ones found in the lm_sensors-2.7.0
package and were ported by me with help from Christoph Hellwig to the new driver model.

This patch (1/3) adds /drivers/i2c/busses/i2c-isa.c and adds it to Kconfig and Makefile
in the same dir.
Please apply.

Thanks,

        GertJan

diff -Nru linux-2.5.58/drivers/i2c/busses/Kconfig linux-2.5.58-edited/drivers/i2c/busses/Kconfig
--- linux-2.5.58/drivers/i2c/busses/Kconfig     2003-01-15 20:43:35.000000000 +0100
+++ linux-2.5.58-edited/drivers/i2c/busses/Kconfig      2003-01-12 12:32:03.000000000 +0100
@@ -39,5 +39,19 @@
          in the lm_sensors package, which you can download at 
          http://www.lm-sensors.nu
 
+config I2C_ISA
+       tristate "  Pseudo ISA adapter (for some hardware sensors)"
+       depends on I2C && ISA
+       help
+         This provide support for accessing some hardware sensors chips over
+         the ISA bus rather than the I2C or SMBus. If you want to do this,
+         say yes here.
+
+         This can also be built as a module which can be inserted and removed
+         while the kernel is running.  If you want to compile it as a module,
+         say M here and read <file:Documentation/modules.txt>.
+
+         The module will be called i2c-isa.ko.
+
 endmenu
 
diff -Nru linux-2.5.58/drivers/i2c/busses/Makefile linux-2.5.58-edited/drivers/i2c/busses/Makefile
--- linux-2.5.58/drivers/i2c/busses/Makefile    2003-01-15 20:43:48.000000000 +0100
+++ linux-2.5.58-edited/drivers/i2c/busses/Makefile     2003-01-12 12:32:03.000000000 +0100
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_I2C_AMD756)       += i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)      += i2c-amd8111.o
+obj-$(CONFIG_I2C_ISA)          += i2c-isa.o
diff -Nru linux-2.5.58/drivers/i2c/busses/i2c-isa.c linux-2.5.58-edited/drivers/i2c/busses/i2c-isa.c
--- linux-2.5.58/drivers/i2c/busses/i2c-isa.c   1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.58-edited/drivers/i2c/busses/i2c-isa.c    2003-01-12 12:32:03.000000000 +0100
@@ -0,0 +1,61 @@
+/*
+    i2c-isa.c - Part of lm_sensors, Linux kernel modules for hardware
+            monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/* This implements an i2c algorithm/adapter for ISA bus. Not that this is
+   on first sight very useful; almost no functionality is preserved.
+   Except that it makes writing drivers for chips which can be on both
+   the SMBus and the ISA bus very much easier. See lm78.c for an example
+   of this. */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+
+/* This is the actual algorithm we define */
+static struct i2c_algorithm isa_algorithm = {
+       .name           = "ISA bus algorithm",
+       .id             = I2C_ALGO_ISA,
+};
+
+/* There can only be one... */
+static struct i2c_adapter isa_adapter = {
+       .owner          = THIS_MODULE,
+       .name           = "ISA main adapter",
+       .id             = I2C_ALGO_ISA | I2C_HW_ISA,
+       .algo           = &isa_algorithm,
+};
+
+static int __init isa_init(void)
+{
+       return i2c_add_adapter(&isa_adapter);
+}
+
+static void __exit isa_exit(void)
+{
+       i2c_del_adapter(&isa_adapter);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("ISA bus access through i2c");
+MODULE_LICENSE("GPL");
+
+module_init(isa_init)
+module_exit(isa_exit)
