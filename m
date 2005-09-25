From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:19:18 +0000
Subject: [lm-sensors] [PATCH] (2/13) hwmon: Do not forcibly enable via686a
Message-Id: <20050925161849.28cc5caf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Do not enable the VIA VT82C686A/B integrated sensors by default, as
disabled sensors usually means that this feature is not used so the
values won't make any sense. This has been confusing many users in the
past:

  http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket86
  http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket11
  http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket 52

It is still possible to forcibly enable the sensors by using the
force_addr module parameter.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/hwmon/via686a |   17 +++++++++++++++--
 drivers/hwmon/via686a.c     |   18 +++++++++++-------
 2 files changed, 26 insertions(+), 9 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/hwmon/via686a.c	2005-09-25 11:52:35.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/via686a.c	2005-09-25 14:18:05.000000000 +0200
@@ -589,10 +589,8 @@
 	u16 val;
 
 	/* 8231 requires multiple of 256, we enforce that on 686 as well */
-	if (force_addr)
-		address = force_addr & 0xFF00;
-
 	if (force_addr) {
+		address = force_addr & 0xFF00;
 		dev_warn(&adapter->dev, "forcing ISA address 0x%04X\n",
 			 address);
 		if (PCIBIOS_SUCCESSFUL !@@ -603,11 +601,17 @@
 	    pci_read_config_word(s_bridge, VIA686A_ENABLE_REG, &val))
 		return -ENODEV;
 	if (!(val & 0x0001)) {
-		dev_warn(&adapter->dev, "enabling sensors\n");
-		if (PCIBIOS_SUCCESSFUL !-		    pci_write_config_word(s_bridge, VIA686A_ENABLE_REG,
-					  val | 0x0001))
+		if (force_addr) {
+			dev_info(&adapter->dev, "enabling sensors\n");
+			if (PCIBIOS_SUCCESSFUL !+			    pci_write_config_word(s_bridge, VIA686A_ENABLE_REG,
+						  val | 0x0001))
+				return -ENODEV;
+		} else {
+			dev_warn(&adapter->dev, "sensors disabled - enable "
+				 "with force_addr=0x%x\n", address);
 			return -ENODEV;
+		}
 	}
 
 	/* Reserve the ISA region */
--- linux-2.6.14-rc2.orig/Documentation/hwmon/via686a	2005-09-25 09:03:35.000000000 +0200
+++ linux-2.6.14-rc2/Documentation/hwmon/via686a	2005-09-25 14:25:44.000000000 +0200
@@ -18,8 +18,9 @@
 Module Parameters
 -----------------
 
-force_addr=0xaddr       Set the I/O base address. Useful for Asus A7V boards
-                        that don't set the address in the BIOS. Does not do a
+force_addr=0xaddr       Set the I/O base address. Useful for boards that
+                        don't set the address in the BIOS. Look for a BIOS
+                        upgrade before resorting to this. Does not do a
                         PCI force; the via686a must still be present in lspci.
                         Don't use this unless the driver complains that the
                         base address is not set.
@@ -63,3 +64,15 @@
 
 The driver only updates its values each 1.5 seconds; reading it more often
 will do no harm, but will return 'old' values.
+
+Known Issues
+------------
+
+This driver handles sensors integrated in some VIA south bridges. It is
+possible that a motherboard maker used a VT82C686A/B chip as part of a
+product design but was not interested in its hardware monitoring features,
+in which case the sensor inputs will not be wired. This is the case of
+the Asus K7V, A7V and A7V133 motherboards, to name only a few of them.
+So, if you need the force_addr parameter, and end up with values which
+don't seem to make any sense, don't look any further: your chip is simply
+not wired for hardware monitoring.

-- 
Jean Delvare
