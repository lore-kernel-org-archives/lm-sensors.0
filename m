From: ac9410@bellsouth.net (Albert Cranford)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] 1/4 WIP I2C kernel patches-config
Message-Id: <3CE20AD5.5554A03@bellsouth.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello All,
I'm Albert Cranford and I'm working to get I2C ready for
submission to Linus for inclusion into the 2.5 kernel.

My current base is i2c-2.6.3.  I've split the patches into
Linus sizes with:
1/4 being Config module.
2/4 being the core modules.
3/4 being driver modules.
4/4 being fixes needed to compile inline or modules.

I would like to get some feedback/synchronization of my
suggested changes into CVS 2.6.4.  My comments will be
followed by each patch.  Fell free to reply.
After this patch set is in the kernel, I will submit
i2c-2.6.4 changes.
Thanks,
Albert
Patch 1 assumes we really want to change CONFIG names to
match the *.c modules that use them.
PHILIPSPAR -> BITLP
ELV -> BITELV
VELLEMAN -> BITVELLE
ELEKTOR -> PCFISA

--- linux/drivers/i2c/Config.in.orig    2002-05-05 23:38:06.000000000 -0400
+++ linux/drivers/i2c/Config.in 2002-02-18 20:06:01.000000000 -0500
@@ -10,14 +10,14 @@
 
    dep_tristate 'I2C bit-banging interfaces'  CONFIG_I2C_ALGOBIT $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
-      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
-      dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
-      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_BITLP $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
+      dep_tristate '  ELV adapter' CONFIG_I2C_BITELV $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_BITVELLE $CONFIG_I2C_ALGOBIT
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then
-      dep_tristate '  Elektor ISA card' CONFIG_I2C_ELEKTOR $CONFIG_I2C_ALGOPCF
+      dep_tristate '  Elektor ISA card' CONFIG_I2C_PCFISA $CONFIG_I2C_ALGOPCF
    fi
 
    if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
@@ -45,6 +45,7 @@
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
 
-   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
+
 fi
 endmenu

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
