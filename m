From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:57:33 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (ds1621) Clean up documentation
Message-Id: <20090130185733.5a1b0090@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* The alarms sysfs file is deprecated, and individual alarm files are
  self-explanatory.
* The driver doesn't implement high-reslution temperature readings so
  don't document that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 Documentation/hwmon/ds1621 |   51 ++------------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

--- linux-2.6.29-rc3.orig/Documentation/hwmon/ds1621	2009-01-24 17:34:04.000000000 +0100
+++ linux-2.6.29-rc3/Documentation/hwmon/ds1621	2009-01-30 18:02:06.000000000 +0100
@@ -49,12 +49,9 @@ of up to +/- 0.5 degrees even when compa
 readings. Be sure to have a high vs. low temperature limit gap of al least
 1.0 degree Celsius to avoid Tout "bouncing", though!
 
-As for alarms, you can read the alarm status of the DS1621 via the 'alarms'
-/sys file interface. The result consists mainly of bit 6 and 5 of the
-configuration register of the chip; bit 6 (0x40 or 64) is the high alarm
-bit and bit 5 (0x20 or 32) the low one. These bits are set when the high or
-low limits are met or exceeded and are reset by the module as soon as the
-respective temperature ranges are left.
+The alarm bits are set when the high or low limits are met or exceeded and
+are reset by the module as soon as the respective temperature ranges are
+left.
 
 The alarm registers are in no way suitable to find out about the actual
 status of Tout. They will only tell you about its history, whether or not
@@ -64,45 +61,3 @@ with neither of the alarms set.
 
 Temperature conversion of the DS1621 takes up to 1000ms; internal access to
 non-volatile registers may last for 10ms or below.
-
-High Accuracy Temperature Reading
----------------------------------
-
-As said before, the temperature issued via the 9-bit i2c-bus data is
-somewhat arbitrary. Internally, the temperature conversion is of a
-different kind that is explained (not so...) well in the DS1621 data sheet.
-To cut the long story short: Inside the DS1621 there are two oscillators,
-both of them biassed by a temperature coefficient.
-
-Higher resolution of the temperature reading can be achieved using the
-internal projection, which means taking account of REG_COUNT and REG_SLOPE
-(the driver manages them):
-
-Taken from Dallas Semiconductors App Note 068: 'Increasing Temperature
-Resolution on the DS1620' and App Note 105: 'High Resolution Temperature
-Measurement with Dallas Direct-to-Digital Temperature Sensors'
-
-- Read the 9-bit temperature and strip the LSB (Truncate the .5 degs)
-- The resulting value is TEMP_READ.
-- Then, read REG_COUNT.
-- And then, REG_SLOPE.
-
-      TEMP = TEMP_READ - 0.25 + ((REG_SLOPE - REG_COUNT) / REG_SLOPE)
-
-Note that this is what the DONE bit in the DS1621 configuration register is
-good for: Internally, one temperature conversion takes up to 1000ms. Before
-that conversion is complete you will not be able to read valid things out
-of REG_COUNT and REG_SLOPE. The DONE bit, as you may have guessed by now,
-tells you whether the conversion is complete ("done", in plain English) and
-thus, whether the values you read are good or not.
-
-The DS1621 has two modes of operation: "Continuous" conversion, which can
-be understood as the default stand-alone mode where the chip gets the
-temperature and controls external devices via its Tout pin or tells other
-i2c's about it if they care. The other mode is called "1SHOT", that means
-that it only figures out about the temperature when it is explicitly told
-to do so; this can be seen as power saving mode.
-
-Now if you want to read REG_COUNT and REG_SLOPE, you have to either stop
-the continuous conversions until the contents of these registers are valid,
-or, in 1SHOT mode, you have to have one conversion made.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
