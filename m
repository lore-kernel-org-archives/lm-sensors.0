From: Frank Myhr <fmyhr@fhmtech.com>
Date: Thu, 12 Jun 2008 02:38:47 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon (hwmon-vid): trivial format
Message-Id: <48508C37.4060703@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frank Myhr <fmyhr@fhmtech.com>
---
Rudolf, thank you for pointing me in the right direction by email.
I've split the patch into two parts, this one is just a formatting
change. I've tried to follow the directions for submitting patches,
but this is my first one, so please let me know if I've mucked
it up. Thanks, Frank.

--- linux-2.6.26-rc5_before/drivers/hwmon/hwmon-vid.c   2008-04-16 22:49:44.000000000 -0400
+++ linux-2.6.26-rc5_after/drivers/hwmon/hwmon-vid.c    2008-06-11 17:52:54.000000000 -0400
@@ -1,76 +1,78 @@
 /*
-    hwmon-vid.c - VID/VRM/VRD voltage conversions
-
-    Copyright (c) 2004 Rudolf Marek <r.marek@assembler.cz>
-
-    Partly imported from i2c-vid.h of the lm_sensors project
-    Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
-    With assistance from Trent Piepho <xyzzy@speakeasy.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * hwmon-vid.c - VID/VRM/VRD voltage conversions
+ *
+ * Copyright (c) 2004 Rudolf Marek <r.marek@assembler.cz>
+ *
+ * Partly imported from i2c-vid.h of the lm_sensors project
+ * Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+ * With assistance from Trent Piepho <xyzzy@speakeasy.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
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

 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/hwmon-vid.h>

 /*
-    Common code for decoding VID pins.
-
-    References:
+ * Common code for decoding VID pins.
+ *
+ * References:
+ *
+ * For VRM 8.4 to 9.1, "VRM x.y DC-DC Converter Design Guidelines",
+ * available at http://developer.intel.com/.
+ *
+ * For VRD 10.0 and up, "VRD x.y Design Guide",
+ * available at http://developer.intel.com/.
+ *
+ * AMD Opteron processors don't follow the Intel specifications.
+ * I'm going to "make up" 2.4 as the spec number for the Opterons.
+ * No good reason just a mnemonic for the 24x Opteron processor
+ * series.
+ *
+ * Opteron VID encoding is:
+ *    00000  =  1.550 V
+ *    00001  =  1.525 V
+ *     . . . .
+ *    11110  =  0.800 V
+ *    11111  =  0.000 V (off)
+ *
+ * The 17 specification is in fact Intel Mobile Voltage Positioning -
+ * (IMVP-II). You can find more information in the datasheet of Max1718
+ * http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2452
+ *
+ * The 13 specification corresponds to the Intel Pentium M series. There
+ * doesn't seem to be any named specification for these. The conversion
+ * tables are detailed directly in the various Pentium M datasheets:
+ * http://www.intel.com/design/intarch/pentiumm/docs_pentiumm.htm
+ *
+ * The 14 specification corresponds to Intel Core series. There
+ * doesn't seem to be any named specification for these. The conversion
+ * tables are detailed directly in the various Pentium Core datasheets:
+ * http://www.intel.com/design/mobile/datashts/309221.htm
+ *
+ * The 110 (VRM 11) specification corresponds to Intel Conroe based series.
+ * http://www.intel.com/design/processor/applnots/313214.htm
+ */

-    For VRM 8.4 to 9.1, "VRM x.y DC-DC Converter Design Guidelines",
-    available at http://developer.intel.com/.
-
-    For VRD 10.0 and up, "VRD x.y Design Guide",
-    available at http://developer.intel.com/.
-
-    AMD Opteron processors don't follow the Intel specifications.
-    I'm going to "make up" 2.4 as the spec number for the Opterons.
-    No good reason just a mnemonic for the 24x Opteron processor
-    series.
-
-    Opteron VID encoding is:
-       00000  =  1.550 V
-       00001  =  1.525 V
-        . . . .
-       11110  =  0.800 V
-       11111  =  0.000 V (off)
-
-    The 17 specification is in fact Intel Mobile Voltage Positioning -
-    (IMVP-II). You can find more information in the datasheet of Max1718
-    http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2452
-
-    The 13 specification corresponds to the Intel Pentium M series. There
-    doesn't seem to be any named specification for these. The conversion
-    tables are detailed directly in the various Pentium M datasheets:
-    http://www.intel.com/design/intarch/pentiumm/docs_pentiumm.htm
-
-    The 14 specification corresponds to Intel Core series. There
-    doesn't seem to be any named specification for these. The conversion
-    tables are detailed directly in the various Pentium Core datasheets:
-    http://www.intel.com/design/mobile/datashts/309221.htm
-
-    The 110 (VRM 11) specification corresponds to Intel Conroe based series.
-    http://www.intel.com/design/processor/applnots/313214.htm
-*/
-
-/* vrm is the VRM/VRD document version multiplied by 10.
-   val is the 4-bit or more VID code.
-   Returned value is in mV to avoid floating point in the kernel.
-   Some VID have some bits in uV scale, this is rounded to mV */
+/*
+ * vrm is the VRM/VRD document version multiplied by 10.
+ * val is the 4-bit or more VID code.
+ * Returned value is in mV to avoid floating point in the kernel.
+ * Some VID have some bits in uV scale, this is rounded to mV.
+ */
 int vid_from_reg(int val, u8 vrm)
 {
        int vid;
@@ -141,9 +143,9 @@ int vid_from_reg(int val, u8 vrm)


 /*
-    After this point is the code to automatically determine which
-    VRM/VRD specification should be used depending on the CPU.
-*/
+ * After this point is the code to automatically determine which
+ * VRM/VRD specification should be used depending on the CPU.
+ */

 struct vrm_model {
        u8 vendor;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
