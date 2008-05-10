From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 10 May 2008 16:40:22 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <20080510184022.19445898@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Achim,

On Fri, 09 May 2008 19:31:44 +0200, achim wrote:
> Am Freitag, den 09.05.2008, 19:05 +0200 schrieb Jean Delvare:
> > 
> > > Afterward i tried it with only 0x4c excluded and the smbus chip still
> > > works. With no exclusions lm75 detection hangs at 0x4c and afterwards i
> > > only get XX's from dumps.
> > 
> > By "hangs" you mean it takes several seconds, or does it really stop?
> > Are you certain that it's the LM75 detection causing problem? We check
> > for no less than 33 different devices at address 0x4c...
> > 
> -------------------------------------------------
> Client found at address 0x4c
> Probing for `National Semiconductor LM75'...         
> -------------------------------------------------
> This is where it stops for a few seconds.
> i2cdump 0 0x4c w hangs in a way that i must cancle it with Ctrl-C and
> afterwards i need a reboot to get correct dumps.
> 
> > Anyway, most certainly the problem is with word transactions on this
> > device you have at 0x4c. That won't be easy to work around, but I'll
> > take a look anyway, maybe I'll have an idea. If I do, I'll ask you -
> > again - to help with testing. 

OK, I have come up with something. There are not that many detection
routines using SMBus read word transactions, we only use them for the
following devices in the 0x48-0x4f address range: LM75, DS75, LM77,
LM92, LM76, MAX663x and DS1621. So I have changed the detection of all
these devices to do as much as possible with read byte transactions,
and only use read word transactions at the end when we are already
almost certain that we have identified the device.

Here's the patch:

---
 prog/detect/sensors-detect |  163 +++++++++++++++++++++++++++-----------------
 1 file changed, 102 insertions(+), 61 deletions(-)

--- lm-sensors-3.orig/prog/detect/sensors-detect	2008-05-09 22:54:06.000000000 +0200
+++ lm-sensors-3/prog/detect/sensors-detect	2008-05-10 17:29:10.000000000 +0200
@@ -2724,6 +2724,10 @@ sub i2c_smbus_read_byte_data
 # $_[0]: Reference to an opened filehandle
 # $_[1]: Command byte (usually register number)
 # Returns: -1 on failure, the read word on success.
+# Use this function with care, some devices don't like word reads,
+# so you should do as much detection as possible using byte reads,
+# and only start using word reads when there is a good chance that
+# the detection will succeed.
 # Note: some devices use the wrong endiannes; use swap_bytes to correct for 
 # this.
 sub i2c_smbus_read_word_data
@@ -3587,46 +3591,42 @@ sub lm78_alias_detect
 # The DS75 is a bit different, it doesn't cycle over 8-byte boundaries, and
 # all register addresses from 0x04 to 0x0f behave like 0x04-0x07 do for
 # the LM75.
+# Not all devices enjoy SMBus read word transactions, so we use read byte
+# transactions even for the 16-bit registers. The low bits aren't very
+# useful for detection anyway.
 sub lm75_detect
 {
   my $i;
   my ($chip, $file, $addr) = @_;
-  my $cur = i2c_smbus_read_word_data($file,0x00);
+  my $cur = i2c_smbus_read_byte_data($file, 0x00);
   my $conf = i2c_smbus_read_byte_data($file,0x01);
 
-  my $hyst = i2c_smbus_read_word_data($file,0x02);
+  my $hyst = i2c_smbus_read_byte_data($file, 0x02);
   my $maxreg = $chip = 1 ? 0x0f : 0x07;
   for $i (0x04 .. $maxreg) {
-    return if i2c_smbus_read_word_data($file, $i) != $hyst;
+    return if i2c_smbus_read_byte_data($file, $i) != $hyst;
   }
 
-  my $os = i2c_smbus_read_word_data($file,0x03);
+  my $os = i2c_smbus_read_byte_data($file, 0x03);
   for $i (0x04 .. $maxreg) {
-    return if i2c_smbus_read_word_data($file, $i) != $os;
+    return if i2c_smbus_read_byte_data($file, $i) != $os;
   }
 
   if ($chip = 0) {
     for ($i = 8; $i <= 248; $i += 40) {
       return if i2c_smbus_read_byte_data($file, $i + 0x01) != $conf
-             or i2c_smbus_read_word_data($file, $i + 0x02) != $hyst
-             or i2c_smbus_read_word_data($file, $i + 0x03) != $os;
+             or i2c_smbus_read_byte_data($file, $i + 0x02) != $hyst
+             or i2c_smbus_read_byte_data($file, $i + 0x03) != $os;
     }
   }
 
   # All registers hold the same value, obviously a misdetection
-  return if $conf = ($cur & 0xff) and $cur = $hyst
-    and $cur = $os;
+  return if $conf = $cur and $cur = $hyst and $cur = $os;
 
-  $cur = swap_bytes($cur);
-  $hyst = swap_bytes($hyst);
-  $os = swap_bytes($os);
   # Unused bits
   return if $chip = 0 and ($conf & 0xe0);
   return if $chip = 1 and ($conf & 0x80);
 
-  $cur = $cur >> 8;
-  $hyst = $hyst >> 8;
-  $os = $os >> 8;
   # Most probable value ranges
   return 6 if $cur <= 100 and ($hyst >= 10 && $hyst <= 125)
     and ($os >= 20 && $os <= 127) and $hyst < $os;
@@ -3645,54 +3645,65 @@ sub lm75_detect
 #   0x03: Overtemperature Shutdown
 #   0x04: Low limit
 #   0x05: High limit
-#   0x04-0x07: No registers
+#   0x06-0x07: No registers
 # The first detection step is based on the fact that the LM77 has only
 # six registers, and cycles addresses over 8-byte boundaries. We use the
 # 0x06-0x07 addresses (unused) to improve the reliability. These are not
 # real registers and will always return the last returned value. This isn't
 # documented.
 # Note that register 0x00 may change, so we can't use the modulo trick on it.
+# Not all devices enjoy SMBus read word transactions, so we use read byte
+# transactions even for the 16-bit registers at first. We only use read word
+# transactions in the end when we are already almost certain that we have an
+# LM77 chip.
 sub lm77_detect
 {
   my $i;
   my ($file,$addr) = @_;
-  my $cur = i2c_smbus_read_word_data($file,0x00);
+  my $cur = i2c_smbus_read_byte_data($file, 0x00);
   my $conf = i2c_smbus_read_byte_data($file,0x01);
-  my $hyst = i2c_smbus_read_word_data($file,0x02);
-  my $os = i2c_smbus_read_word_data($file,0x03);
+  my $hyst = i2c_smbus_read_byte_data($file, 0x02);
+  my $os = i2c_smbus_read_byte_data($file, 0x03);
 
-  my $low = i2c_smbus_read_word_data($file,0x04);
-  return if i2c_smbus_read_word_data($file,0x06) != $low;
-  return if i2c_smbus_read_word_data($file,0x07) != $low;
-
-  my $high = i2c_smbus_read_word_data($file,0x05);
-  return if i2c_smbus_read_word_data($file,0x06) != $high;
-  return if i2c_smbus_read_word_data($file,0x07) != $high;
+  my $low = i2c_smbus_read_byte_data($file, 0x04);
+  return if i2c_smbus_read_byte_data($file, 0x06) != $low;
+  return if i2c_smbus_read_byte_data($file, 0x07) != $low;
+
+  my $high = i2c_smbus_read_byte_data($file, 0x05);
+  return if i2c_smbus_read_byte_data($file, 0x06) != $high;
+  return if i2c_smbus_read_byte_data($file, 0x07) != $high;
 
   for ($i = 8; $i <= 248; $i += 40) {
     return if i2c_smbus_read_byte_data($file, $i + 0x01) != $conf;
-    return if i2c_smbus_read_word_data($file, $i + 0x02) != $hyst;
-    return if i2c_smbus_read_word_data($file, $i + 0x03) != $os;
-    return if i2c_smbus_read_word_data($file, $i + 0x04) != $low;
-    return if i2c_smbus_read_word_data($file, $i + 0x05) != $high;
+    return if i2c_smbus_read_byte_data($file, $i + 0x02) != $hyst;
+    return if i2c_smbus_read_byte_data($file, $i + 0x03) != $os;
+    return if i2c_smbus_read_byte_data($file, $i + 0x04) != $low;
+    return if i2c_smbus_read_byte_data($file, $i + 0x05) != $high;
   }
 
   # All registers hold the same value, obviously a misdetection
-  return if $conf = ($cur & 0xff) and $cur = $hyst
+  return if $conf = $cur and $cur = $hyst
     and $cur = $os and $cur = $low and $cur = $high;
 
-  $cur = swap_bytes($cur);
-  $os = swap_bytes($os);
-  $hyst = swap_bytes($hyst);
-  $low = swap_bytes($low);
-  $high = swap_bytes($high);
   # Unused bits
   return if ($conf & 0xe0)
-    or (($cur >> 12) != 0 && ($cur >> 12) != 0xf)
-    or (($hyst >> 12) != 0 && ($hyst >> 12) != 0xf)
-    or (($os >> 12) != 0 && ($os >> 12) != 0xf)
-    or (($low >> 12) != 0 && ($low >> 12) != 0xf)
-    or (($high >> 12) != 0 && ($high >> 12) != 0xf);
+    or (($cur >> 4) != 0 && ($cur >> 4) != 0xf)
+    or (($hyst >> 4) != 0 && ($hyst >> 4) != 0xf)
+    or (($os >> 4) != 0 && ($os >> 4) != 0xf)
+    or (($low >> 4) != 0 && ($low >> 4) != 0xf)
+    or (($high >> 4) != 0 && ($high >> 4) != 0xf);
+
+  # Make sure the chip supports SMBus read word transactions
+  $cur = i2c_smbus_read_word_data($file, 0x00);
+  return if $cur < 0;
+  $hyst = i2c_smbus_read_word_data($file, 0x02);
+  return if $hyst < 0;
+  $os = i2c_smbus_read_word_data($file, 0x03);
+  return if $os < 0;
+  $low = i2c_smbus_read_word_data($file, 0x04);
+  return if $low < 0;
+  $high = i2c_smbus_read_word_data($file, 0x05);
+  return if $high < 0;
 
   $cur /= 16;
   $hyst /= 16;
@@ -3720,33 +3731,48 @@ sub lm77_detect
 # One detection step is based on the fact that the LM92 and clones have a
 # limited number of registers, which cycle modulo 16 address values.
 # Note that register 0x00 may change, so we can't use the modulo trick on it.
+# Not all devices enjoy SMBus read word transactions, so we use read byte
+# transactions even for the 16-bit registers at first. We only use read
+# word transactions in the end when we are already almost certain that we
+# have an LM92 chip or compatible.
 sub lm92_detect
 {
   my ($chip, $file, $addr) = @_;
 
   my $conf = i2c_smbus_read_byte_data($file, 0x01);
-  my $hyst = i2c_smbus_read_word_data($file, 0x02);
-  my $crit = i2c_smbus_read_word_data($file, 0x03);
-  my $low = i2c_smbus_read_word_data($file, 0x04);
-  my $high = i2c_smbus_read_word_data($file, 0x05);
+  my $hyst = i2c_smbus_read_byte_data($file, 0x02);
+  my $crit = i2c_smbus_read_byte_data($file, 0x03);
+  my $low = i2c_smbus_read_byte_data($file, 0x04);
+  my $high = i2c_smbus_read_byte_data($file, 0x05);
 
   return if $conf = 0 and $hyst = 0 and $crit = 0
         and $low = 0 and $high = 0;
 
-  return if $chip = 0
-        and i2c_smbus_read_word_data($file, 0x07) != 0x0180;
-  
+  # Unused bits
   return if ($chip = 0 || $chip = 1)
         and ($conf & 0xE0);
 
-  for (my $i = 0; $i < 8; $i++) {
-    return if i2c_smbus_read_byte_data($file, $i*16+0x01) != $conf;
-    return if i2c_smbus_read_word_data($file, $i*16+0x02) != $hyst;
-    return if i2c_smbus_read_word_data($file, $i*16+0x03) != $crit;
-    return if i2c_smbus_read_word_data($file, $i*16+0x04) != $low;
-    return if i2c_smbus_read_word_data($file, $i*16+0x05) != $high;
+  for (my $i = 0; $i <= 240; $i += 16) {
+    return if i2c_smbus_read_byte_data($file, $i + 0x01) != $conf;
+    return if i2c_smbus_read_byte_data($file, $i + 0x02) != $hyst;
+    return if i2c_smbus_read_byte_data($file, $i + 0x03) != $crit;
+    return if i2c_smbus_read_byte_data($file, $i + 0x04) != $low;
+    return if i2c_smbus_read_byte_data($file, $i + 0x05) != $high;
   }
   
+  return if $chip = 0
+        and i2c_smbus_read_word_data($file, 0x07) != 0x0180;
+
+  # Make sure the chip supports SMBus read word transactions
+  $hyst = i2c_smbus_read_word_data($file, 0x02);
+  return if $hyst < 0;
+  $crit = i2c_smbus_read_word_data($file, 0x03);
+  return if $crit < 0;
+  $low = i2c_smbus_read_word_data($file, 0x04);
+  return if $low < 0;
+  $high = i2c_smbus_read_word_data($file, 0x05);
+  return if $high < 0;
+
   foreach my $temp ($hyst, $crit, $low, $high) {
     return if $chip = 2 and ($temp & 0x7F00);
     return if $chip != 2 and ($temp & 0x0700);
@@ -3763,23 +3789,38 @@ sub lm92_detect
 #   0xAA: Temperature
 #   0xA1: High limit
 #   0xA2: Low limit
+#   0xA8: Counter
+#   0xA9: Slope
 #   0xAC: Configuration
 # Detection is weak. We check if bit 4 (NVB) is clear, because it is
 # unlikely to be set (would mean that EEPROM is currently being accessed).
-# Temperature checkings will hopefully prevent LM75 or other chips from
-# being detected as a DS1621.
+# We also check the value of the counter and slope registers, the datasheet
+# doesn't mention the possible values but the conversion formula together
+# with experimental evidence suggest possible sanity checks.
+# Not all devices enjoy SMBus read word transactions, so we do as much as
+# possible with read byte transactions first, and only use read word
+# transactions second.
 sub ds1621_detect
 {
-  my $i;
   my ($file,$addr) = @_;
+
+  my $conf = i2c_smbus_read_byte_data($file, 0xAC);
+  return if ($conf & 0x10);
+
+  my $counter = i2c_smbus_read_byte_data($file, 0xA8);
+  my $slope = i2c_smbus_read_byte_data($file, 0xA9);
+  return if ($slope != 0x10 || $counter > $slope);
+
   my $temp = i2c_smbus_read_word_data($file,0xAA);
+  return if $temp < 0 || ($temp & 0x7f00);
   my $high = i2c_smbus_read_word_data($file,0xA1);
+  return if $high < 0 || ($high & 0x7f00);
   my $low = i2c_smbus_read_word_data($file,0xA2);
-  return if ($temp | $high | $low) & 0x7F00;
-  my $conf = i2c_smbus_read_byte_data($file,0xAC);
+  return if $low < 0 || ($low & 0x7f00);
+
   return if ($temp = 0 && $high = 0 && $low = 0 && $conf = 0);
-  return 3 if ($conf & 0x10) = 0x00;
-  return;
+
+  return 3;
 }
 
 # $_[0]: A reference to the file descriptor to access this chip.

Please give it a try, I believe that it should _not_ do any word
transaction on your chip at 0x4c (all detections should fail before
that) and thus sensors-detect should no longer break your SMBus.

I have also updated the test script at:
http://jdelvare.pck.nerim.net/sensors/sensors-detect
It includes the detection of 1-register-only devices, and the patch
above.

I would appreciate as much testing of this patch as possible, in
particular from people having any of the devices those detection
routines changed (LM75, DS75, LM77, LM92, LM76, MAX663x and DS1621) but
more generally from anyone having an I2C/SMBus device in address range
0x48-0x4f. I want to make sure that I didn't add false positives with
the changes.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
