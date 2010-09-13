From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:26:33 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: conditionalize coretemp's
Message-Id: <4C8E18790200007800015AF7@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fenghua.yu@intel.com, khali@linux-fr.org
Cc: r.marek@assembler.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

PCI specific code is needed only when Atom CPUs are potentially
supported by the kernel.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Rudolf Marek <r.marek@assembler.cz>

---
 drivers/hwmon/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.36-rc4/drivers/hwmon/Kconfig	2010-09-13 08:45:02.000000000 +0200
+++ 2.6.36-rc4-x86-coretemp-maybe-pci/drivers/hwmon/Kconfig	2010-09-10 16:24:16.000000000 +0200
@@ -401,7 +401,8 @@ config SENSORS_GL520SM
 
 config SENSORS_CORETEMP
 	tristate "Intel Core/Core2/Atom temperature sensor"
-	depends on X86 && PCI && EXPERIMENTAL
+	depends on X86 && EXPERIMENTAL
+	depends on PCI || (!MATOM && !GENERIC_CPU && !X86_GENERIC)
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU. Most of the family 6 CPUs




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
