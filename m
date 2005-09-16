From: aurelien@aurel32.net (Aurelien Jarno)
Date: Fri, 16 Sep 2005 11:43:39 +0000
Subject: [lm-sensors] sensord and RAM SPD
Message-Id: <20050916094258.GA26164@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

sensord currently fails decode correctly RAM SPD in most cases
and thus fails to determine the RAM size. It seems the corresponding
code is a bit outdated.

Please find attached a patch to fix that. Most of the code is taken 
from sensors.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
--- lm-sensors-2.9.2.orig/prog/sensord/chips.c
+++ lm-sensors-2.9.2/prog/sensord/chips.c
@@ -1008,27 +1008,56 @@
 /** EEPROM **/
 
 static const char *
-fmtType_EEPROM
+fmt_EEPROM
 (const double values[], int alarm, int beep) {
-  if ((int) values[0] = 4)
-    sprintf (buff, "SDRAM DIMM SPD");
-  else if ((int) values[0] = 7)
-    sprintf (buff, "DDR SDRAM DIMM SPD");
-  else
-    sprintf (buff, "Invalid"); /* N.B: sensors just returns, aborting further tests; I don't.. */
-  return fmtExtra (alarm, beep);
-}
-
-static const char *
-fmtRowCol_EEPROM
-(const double values[], int alarm, int beep) {
-  int row = (int) values[0];
-  int col = (int) values[1];
-  int num = (int) values[2];
-  int banks = (int) values[3];
-  int foo = (row & 0xf) + (col & 0xf) + 17;
-  if ((foo > 0) && (foo <= 12) && (num <= 8) && (banks <= 8)) {
-    sprintf (buff, "%d", (1 << foo) * num * banks);
+  int i, k;
+  int type = values[0];
+  int row = (int) values[1];
+  int col = (int) values[2];
+  int num = (int) values[3];
+  int banks = (int) values[4];
+
+  switch (type) {
+    case 1:
+            sprintf (buff, "DRDRAM RIMM SPD");
+	    break;
+    case 2:
+            sprintf (buff, "EDO SPD");
+	    break;
+    case 4:
+            sprintf (buff, "SDR SDRAM DIMM SPD");
+	    break;
+    case 7:
+            sprintf (buff, "DDR SDRAM DIMM SPD");
+	    break;
+    case 8:
+            sprintf (buff, "DDR2 SDRAM DIMM SPD");
+	    break;
+    case 17:
+            sprintf (buff, "RAMBUS RIMM SPD");
+	    break;
+    default:
+	    sprintf (buff, "Invalid");
+	    return buff;
+  }	    
+
+  k = 0; /* multiplier, 0 if invalid */
+  if (type = 17) { /* RAMBUS */
+    i = (((int) row) & 0x0f) + (((int) row) >> 4) + (((int) num) & 0x07) - 13;
+    k = 1;
+  } else if (type = 1) { /* DRDRAM */
+    i = (((int) col) & 0x0f) + (((int) col) >> 4) + (((int) num) & 0x07) - 13;
+    k = 1;
+  } else if (type = 8) { /* DDR2 */
+    i = (((int) row) & 0x0f) + (((int) col) & 0x0f) - 17;
+    k = ((((int) num) & 0x7) + 1) * ((int) banks);
+  } else { /* SDRAM */
+    i = (((int) row) & 0x0f) + (((int) col) & 0x0f) - 17;
+    if (((int) num) <= 8 && ((int) banks) <= 8)
+      k = ((int) num) * ((int) banks);
+  }
+  if(i > 0 && i <= 12 && k > 0) {
+    sprintf (buff, "%d", (1 << i) * k);
   } else {
     sprintf (buff, "Invalid %d %d %d %d", row, col, num, banks);
   }
@@ -1040,10 +1069,8 @@
 };
 
 static const FeatureDescriptor eeprom_features[] = {
-  { fmtType_EEPROM, NULL, DataType_other, 0, 0,
-    { SENSORS_EEPROM_TYPE, -1 } },
-  { fmtRowCol_EEPROM, NULL, DataType_other, 0, 0,
-    { SENSORS_EEPROM_ROWADDR, SENSORS_EEPROM_COLADDR, SENSORS_EEPROM_NUMROWS, SENSORS_EEPROM_BANKS, -1 } },
+  { fmt_EEPROM, NULL, DataType_other, 0, 0,
+    { SENSORS_EEPROM_TYPE, SENSORS_EEPROM_ROWADDR, SENSORS_EEPROM_COLADDR, SENSORS_EEPROM_NUMROWS, SENSORS_EEPROM_BANKS, -1 } },
   { NULL }
 };
 
