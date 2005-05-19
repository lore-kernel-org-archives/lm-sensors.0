From: achim@uni-bielefeld.de (Achim Flammenkamp)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: VT8235-diff for lm_sensors-2.6.5
Message-Id: <200209301258.OAA25010@castor.hrz.uni-bielefeld.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I have made a small update to lm_sensors-2.6.5 to be able that my kernel 2.4.19
detects the VIA VT8235 Soutbridge in the i2c-viapro.o module. At least both
memory modules are now detected on my Epox 8K5A mainboard. :)

Here comes the diff against the lm_sensors-2.6.5 - original-tree:
>----------------- START OF DIFF ---------------------------------------------<
diff -r -u lm_sensors-2.6.5a/CHANGES lm_sensors-2.6.5/CHANGES
--- lm_sensors-2.6.5a/CHANGES	Mon Sep 30 12:48:23 2002
+++ lm_sensors-2.6.5/CHANGES	Mon Sep 16 02:26:16 2002
@@ -17,8 +17,6 @@
 
 -----------------------------------------------------------------------------
 
-2.6.? (20020929)
-  Module i2c-viapro: Add support for VT8235 (0x3177)
 2.6.5 (20020915)
   NOTE: Requires i2c-2.6.1 or newer, or kernel 2.4.13 or newer.
   File sensors.conf.eg: Fix temp[23] for as99127f; add vt8231
diff -r -u lm_sensors-2.6.5a/README lm_sensors-2.6.5/README
--- lm_sensors-2.6.5a/README	Mon Sep 30 12:48:55 2002
+++ lm_sensors-2.6.5/README	Fri Sep 13 03:20:32 2002
@@ -53,7 +53,7 @@
   SMSC Victory66
   3Dfx Voodoo 3 and Banshee
   VIA Technologies VT82C586B, VT82C596A/B, VT82C686A/B, VT8231,
-                   VT8233, VT8233A and VT8235.
+                   VT8233, and VT8233A.
 
 
 At least the following hardware sensor chips are supported:
diff -r -u lm_sensors-2.6.5a/doc/busses/i2c-viapro lm_sensors-2.6.5/doc/busses/i2c-viapro
--- lm_sensors-2.6.5a/doc/busses/i2c-viapro	Mon Sep 30 12:45:44 2002
+++ lm_sensors-2.6.5/doc/busses/i2c-viapro	Mon May 27 22:48:46 2002
@@ -9,7 +9,7 @@
   * VIA Technologies, Inc. VT82C686    
     Datasheet: Sometimes available at the VIA website
 
-  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235
+  * VIA Technologies, Inc. VT8231, VT8233, VT8233A
     Datasheet: available on request from Via
 
 Author: Ky?sti M?lkki <kmalkki@cc.hut.fi>
@@ -38,7 +38,6 @@
  device 1106:3074   (VT8233)
  device 1106:3147   (VT8233A)
  device 1106:8235   (VT8231)
- device 1106:3177   (VT8235)
 
 If none of these show up, you should look in the BIOS for settings like
 enable ACPI / SMBus or even USB.
diff -r -u lm_sensors-2.6.5a/kernel/busses/i2c-viapro.c lm_sensors-2.6.5/kernel/busses/i2c-viapro.c
--- lm_sensors-2.6.5a/kernel/busses/i2c-viapro.c	Mon Sep 30 12:50:50 2002
+++ lm_sensors-2.6.5/kernel/busses/i2c-viapro.c	Sat Jun  8 21:49:06 2002
@@ -25,7 +25,7 @@
 	82C596A/B (0x3050)
 	82C596B (0x3051)
 	82C686A/B
-	8233, 8233A, 8235
+	8233, 8233A
 	8231
    Note: we assume there can only be one device, with one SMBus interface.
 */
@@ -54,9 +54,6 @@
 #ifndef PCI_DEVICE_ID_VIA_8233_0
 #define PCI_DEVICE_ID_VIA_8233_0	0x3074
 #endif
-#ifndef PCI_DEVICE_ID_VIA_8235
-#define PCI_DEVICE_ID_VIA_8235  	0x3177
-#endif
 
 #define SMBBA1	    0x90
 #define SMBBA2      0x80
@@ -75,7 +72,6 @@
 	{PCI_DEVICE_ID_VIA_82C686_4, SMBBA1, 0xD2, "VT82C686A/B"},
 	{PCI_DEVICE_ID_VIA_8233_0, SMBBA3, 0xD2, "VT8233"},
 	{0x3147, SMBBA3, 0xD2, "VT8233A"},
-	{PCI_DEVICE_ID_VIA_8235, SMBBA3, 0xD2, "VT8235"},
 	{0x8235, SMBBA1, 0xD2, "VT8231"},
 	{0, 0, 0, NULL}
 };
diff -r -u lm_sensors-2.6.5a/mkpatch/mkpatch.pl lm_sensors-2.6.5/mkpatch/mkpatch.pl
--- lm_sensors-2.6.5a/mkpatch/mkpatch.pl	Mon Sep 30 12:53:43 2002
+++ lm_sensors-2.6.5/mkpatch/mkpatch.pl	Fri Aug  2 04:11:02 2002
@@ -86,7 +86,7 @@
            m@Intel 82371AB PIIX4\(E\)@ or
            m@Silicon Integrated Systems Corp. SiS5595 based Mainboard@ or
            m@VIA Technologies, Inc. VT82C586B@ or
-           m@VIA Technologies, Inc. VT82C596, 596B, 686A/B, 8233, 8235@ or
+           m@VIA Technologies, Inc. VT82C596, 596B, 686A/B, 8233@ or
            m@3DFX Banshee / Voodoo3@ or
            m@DEC Tsunami 21272@ or
            m@Pseudo ISA adapter \(for hardware sensors modules\)@ or
@@ -196,7 +196,7 @@
   be built as a module which can be inserted and removed while the 
   kernel is running.
 
-VIA Technologies, Inc. VT82C596, 596B, 686A/B, 8233, 8235
+VIA Technologies, Inc. VT82C596, 596B, 686A/B, 8233
 CONFIG_I2C_VIAPRO
   If you say yes to this option, support will be included for the VIA
   Technologies I2C adapter on these chips. For integrated sensors on the
@@ -796,7 +796,7 @@
     tristate '  SiS 5595' CONFIG_I2C_SIS5595
     dep_tristate '  Savage 4' CONFIG_I2C_SAVAGE4 $CONFIG_I2C_ALGOBIT
     dep_tristate '  VIA Technologies, Inc. VT82C586B' CONFIG_I2C_VIA $CONFIG_I2C_ALGOBIT
-    tristate '  VIA Technologies, Inc. VT596A/B, 686A/B, 8231, 8233, 8233A, 8235' CONFIG_I2C_VIAPRO
+    tristate '  VIA Technologies, Inc. VT596A/B, 686A/B, 8231, 8233, 8233A' CONFIG_I2C_VIAPRO
     dep_tristate '  Voodoo3 I2C interface' CONFIG_I2C_VOODOO3 $CONFIG_I2C_ALGOBIT
     tristate '  Pseudo ISA adapter (for some hardware sensors)' CONFIG_I2C_ISA 
   fi
diff -r -u lm_sensors-2.6.5a/prog/detect/sensors-detect lm_sensors-2.6.5/prog/detect/sensors-detect
--- lm_sensors-2.6.5a/prog/detect/sensors-detect	Mon Sep 30 12:54:41 2002
+++ lm_sensors-2.6.5/prog/detect/sensors-detect	Sun Sep  1 22:22:51 2002
@@ -156,14 +156,6 @@
      } ,
      { 
        vendid => 0x1106,
-       devid  => 0x3177,
-       func => 0,
-       procid => "VIA Technologies VT8235 South Bridge",
-       driver => "i2c-viapro",
-       match => sub { $_[0] =~ /^SMBus Via Pro adapter at/ },
-     } ,
-     { 
-       vendid => 0x1106,
        devid  => 0x8235,
        func => 4,
        procid => "VIA Technologies VT8231 South Bridge",
diff -r -u lm_sensors-2.6.5a/prog/eeprom/decode-dimms.pl lm_sensors-2.6.5/prog/eeprom/decode-dimms.pl
--- lm_sensors-2.6.5a/prog/eeprom/decode-dimms.pl	Mon Sep 30 13:00:57 2002
+++ lm_sensors-2.6.5/prog/eeprom/decode-dimms.pl	Sat Feb 16 17:41:54 2002
@@ -139,7 +139,6 @@
 		$l = "Fundemental Memory type";
 		if ($bytes[2] = 2) { printl $l, "EDO"; }
 		elsif ($bytes[2] = 4) { printl $l, "SDRAM"; }
-		elsif ($bytes[2] = 7) { printl $l, "DDR SDRAM"; }
 		else { printl $l, "???"; }
 
 		$l = "Number of Row Address Bits (SDRAM only)";
>----------------- END OF DIFF ---------------------------------------------<

This Epox 8K5A contains an Winbond W83697HF chip. It is detected on port 0x290
on the ISA-Bus (confidence level 8). But later, each call to
sensors_get_feature(*name,SENSORS_W83781D_*,&cur)
in prog/sensors/chips.c gives an 'invalid feature'-error return code (-2).

Regards,
achim
-- 
Achim Flammenkamp    Forschungsschwerp. Mathematisierung   Universit?t Bielefeld
Universit?tsstraBe 25        33501 Bielefeld         Federal Republic of Germany
POB 100131        http://www.uni-bielefeld.de/~achim/     achim@uni-bielefeld.de
(+49)(0)521-106-3841           UTC+2=MEST            < Game of Life and Go Fan >
