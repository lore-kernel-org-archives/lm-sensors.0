From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 09:46:26 +0000
Subject: Re: [lm-sensors] Detection of W83L771W/G in lm90
Message-Id: <20101014114626.7c4be041@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander,

On Thu, 14 Oct 2010 08:44:15 +0200, Alexander Stein wrote:
> On Wednesday 13 October 2010, 17:43:50 Jean Delvare wrote:
> > On Wed, 13 Oct 2010 17:02:17 +0200, Alexander Stein wrote:
> > > > Probing for `Winbond W83L771W/G'...                         Success!
> > > > 
> > > >     (confidence 6, driver `to-be-written')
> > > > 
> > > > Probing for `Winbond W83L771AWG/ASG'...                     No
> > 
> > Oh, I get it now. What the lm90 driver currently supports is the recent
> > W83L771AWG/ASG. It doesn't have detection for the old W83L771W/G. In
> > all honesty I wasn't sure if that one had ever been used in a public
> > product, and its detection is somewhat weak, which is why I didn't add
> > support (if I remember correctly, at least.)
> 
> It is from my motherboard, it's a ASRock ALiveNF6G-DVI.
> 
> > First thing to do is ensure this isn't a misdetection. Please send a
> > dump of the chip:
> > 
> > # (install i2c-tools)
> > # modprobe i2c-dev
> > # i2cdump 0 0x4c b
> 
> Here is the output:
> > # i2cdump 0 0x4c b
> > WARNING! This program can confuse your I2C bus, cause data loss and worse!
> > I will probe file /dev/i2c-0, address 0x4c, mode byte
> > Continue? [Y/n] 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 21 1f 80 01 06 46 00 46 00 ff ff ff ff ff ff ff    !????F.F........
> > 10: 20 00 00 00 00 ff ff ff ff 6e ff ff ff ff ff ff     ........n......
> > 20: 55 0a ff ff ff ff ff ff ff ff ff ff ff ff ff ff    U?..............
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 06    ...............?
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: bb c0 82 bb c0 1f 21 24 82 ff ff 4b 06 ff ff ff    ??????!$?..K?...
> > f0: ff 20 00 10 80 00 ff 00 00 02 00 50 4a 16 5c 01    . .??....?.PJ?\?

Thanks, I've added it to my collection.

> > If you really have that old chip then I'll add support to the lm90
> > driver. Meanwhile you can force the lm90 driver to attach to it by
> > using the following command:
> > 
> > # echo w83L771 0x4c > /sys/devices/i2c-0/new_device
> > 
> > (I hope the path is right for kernel 2.6.34 already.)
> 
> Nope, one possible path is /sys/bus/i2c/devices/i2c-0/new_device, but with the 
> lower case name, as Guenter pointed out, it seems to work. Even with kernel 
> module autoloading.

OK, great :)

> Thanks a lot you two so far. If you want some testing on chip detection, drop 
> me a line.

I'm done with the patch adding detection support to the lm90 driver.
Here it is, if you want to give it a try. I've tested it on the dump
you provided and it worked fine, so I really expect it to work for you
too.

If you can't test a kernel patch, I can also provide a standalone
version of the lm90 driver.

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (lm90) Add support for the W83L771W/G

I was wondering if that chip ever existed publicly... Apparently yes,
so add support for it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm90 |   12 ++++++++++--
 drivers/hwmon/Kconfig    |    2 +-
 drivers/hwmon/lm90.c     |   25 +++++++++++++++++++------
 3 files changed, 30 insertions(+), 9 deletions(-)

--- linux-2.6.36-rc7.orig/Documentation/hwmon/lm90	2010-10-14 10:01:30.000000000 +0200
+++ linux-2.6.36-rc7/Documentation/hwmon/lm90	2010-10-14 10:02:42.000000000 +0200
@@ -95,6 +95,10 @@ Supported chips:
                            0x4c, 0x4d and 0x4e
     Datasheet: Publicly available at the Maxim website
                http://www.maxim-ic.com/datasheet/index.mvp/id/4199
+  * Winbond/Nuvoton W83L771W/G
+    Prefix: 'w83l771'
+    Addresses scanned: I2C 0x4c
+    Datasheet: No longer available
   * Winbond/Nuvoton W83L771AWG/ASG
     Prefix: 'w83l771'
     Addresses scanned: I2C 0x4c
@@ -169,11 +173,15 @@ MAX6695 and MAX6696:
   * Second critical temperature limit
   * Two remote sensors
 
+W83L771W/G
+  * The G variant is lead-free, otherwise similar to the W.
+  * Filter and alert configuration register at 0xBF
+  * Moving average (depending on conversion rate)
+
 W83L771AWG/ASG
+  * Successor of the W83L771W/G, same features.
   * The AWG and ASG variants only differ in package format.
-  * Filter and alert configuration register at 0xBF
   * Diode ideality factor configuration (remote sensor) at 0xE3
-  * Moving average (depending on conversion rate)
 
 All temperature values are given in degrees Celsius. Resolution
 is 1.0 degree for the local temperature, 0.125 degree for the remote
--- linux-2.6.36-rc7.orig/drivers/hwmon/Kconfig	2010-10-14 10:01:31.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/Kconfig	2010-10-14 10:34:07.000000000 +0200
@@ -580,7 +580,7 @@ config SENSORS_LM90
 	  LM86, LM89 and LM99, Analog Devices ADM1032 and ADT7461, Maxim
 	  MAX6646, MAX6647, MAX6648, MAX6649, MAX6657, MAX6658, MAX6659,
 	  MAX6680, MAX6681, MAX6692, MAX6695, MAX6696, and Winbond/Nuvoton
-	  W83L771AWG/ASG sensor chips.
+	  W83L771W/G/AWG/ASG sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
--- linux-2.6.36-rc7.orig/drivers/hwmon/lm90.c	2010-10-14 10:01:30.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/lm90.c	2010-10-14 10:56:15.000000000 +0200
@@ -88,8 +88,8 @@
  * Addresses to scan
  * Address is fully defined internally and cannot be changed except for
  * MAX6659, MAX6680 and MAX6681.
- * LM86, LM89, LM90, LM99, ADM1032, ADM1032-1, ADT7461, MAX6649, MAX6657
- * and MAX6658 have address 0x4c.
+ * LM86, LM89, LM90, LM99, ADM1032, ADM1032-1, ADT7461, MAX6649, MAX6657,
+ * MAX6658 and W83L771 have address 0x4c.
  * ADM1032-2, ADT7461-2, LM89-1, LM99-1 and MAX6646 have address 0x4d.
  * MAX6647 has address 0x4e.
  * MAX6659 can have address 0x4c, 0x4d or 0x4e.
@@ -1237,10 +1237,23 @@ static int lm90_detect(struct i2c_client
 	} else
 	if (address = 0x4C
 	 && man_id = 0x5C) { /* Winbond/Nuvoton */
-		if ((chip_id & 0xFE) = 0x10 /* W83L771AWG/ASG */
-		 && (reg_config1 & 0x2A) = 0x00
-		 && reg_convrate <= 0x08) {
-			name = "w83l771";
+		int reg_config2;
+
+		reg_config2 = i2c_smbus_read_byte_data(new_client,
+						LM90_REG_R_CONFIG2);
+		if (reg_config2 < 0)
+			return -ENODEV;
+
+		if ((reg_config1 & 0x2A) = 0x00
+		 && (reg_config2 & 0xF8) = 0x00) {
+			if ((chip_id & 0xFE) = 0x10 /* W83L771AWG/ASG */
+			 && reg_convrate <= 0x08) {
+				name = "w83l771";
+			} else
+			if (chip_id = 0x01 /* W83L771W/G */
+			 && reg_convrate <= 0x09) {
+				name = "w83l771";
+			}
 		}
 	}
 



-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
