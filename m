From: aurelien@aurel32.net (Aurelien Jarno)
Date: Fri, 16 Sep 2005 14:52:37 +0000
Subject: [lm-sensors] sensord and RAM SPD
Message-Id: <20050916125218.GA17407@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050916094258.GA26164@bode.aurel32.net>
In-Reply-To: <20050916094258.GA26164@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 16, 2005 at 12:05:04PM +0200, Jean Delvare wrote:
> 
> Hi Aurelien,
> 
> [Aurelien Jarno]
> > > I'd prefer that we plain drop eeprom support from sensord.
> >
> > That's also fine with me. Do you want a patch for that?
> 
> Yes please :)
> 
Please find it attached.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
--- lm-sensors-2.9.2.orig/prog/sensord/chips.c
+++ lm-sensors-2.9.2/prog/sensord/chips.c
@@ -1005,52 +1005,6 @@
   asb100_names, asb100_features, 0, 0
 };
 
-/** EEPROM **/
-
-static const char *
-fmtType_EEPROM
-(const double values[], int alarm, int beep) {
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
-  } else {
-    sprintf (buff, "Invalid %d %d %d %d", row, col, num, banks);
-  }
-  return buff;
-}
-
-static const char *eeprom_names[] = {
-  SENSORS_EEPROM_PREFIX, NULL
-};
-
-static const FeatureDescriptor eeprom_features[] = {
-  { fmtType_EEPROM, NULL, DataType_other, 0, 0,
-    { SENSORS_EEPROM_TYPE, -1 } },
-  { fmtRowCol_EEPROM, NULL, DataType_other, 0, 0,
-    { SENSORS_EEPROM_ROWADDR, SENSORS_EEPROM_COLADDR, SENSORS_EEPROM_NUMROWS, SENSORS_EEPROM_BANKS, -1 } },
-  { NULL }
-};
-
-static const ChipDescriptor eeprom_chip = {
-  eeprom_names, eeprom_features, 0, 0
-};
-
 /** PC87360 **/
 
 static const char *
@@ -1145,7 +1099,6 @@
   &adm1025_chip,
   &adm9240_chip,
   &ds1621_chip,
-  &eeprom_chip,
   &gl518_chip,
   &lm75_chip,
   &lm78_chip,
