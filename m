From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: RFC: adm9240 documentation and introducing myself
Message-Id: <7oht215j4adlraeao1ro9t1oq1m4p9ni33@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <tqgo21thqjk57b1hn3he7srfoi81b3sjaf@4ax.com>
In-Reply-To: <tqgo21thqjk57b1hn3he7srfoi81b3sjaf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 8 Mar 2005 13:52:40 +0100 (CET), you wrote:

>Hello,
>
>FYI how planned documentation will look like (really soon)

Here is my second version for comments.
Cheers,
Grant.


diff -Naur linux-2.6.11-mm2/Documentation/i2c/chips/adm9240 linux-2.6.11-mm2-p2x/Documentation/i2c/chips/adm9240
--- linux-2.6.11-mm2/Documentation/i2c/chips/adm9240	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.11-mm2-p2x/Documentation/i2c/chips/adm9240	2005-03-09 20:38:42.000000000 +1100
@@ -0,0 +1,123 @@
+Kernel driver adm9240
+==========+
+Status: Port to 2.6 in progress.
+
+Supported chips:
+  * Analog Devices ADM9240
+    Prefix `adm9240'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the Analog Devices website
+	       http://www.analog.com/
+
+  * Dallas Semiconductor DS1780
+    Prefix `ds1780'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the Dallas Semiconductor (Maxim) website
+	       http://pdfserv.maxim-ic.com/
+
+  * National Semiconductor LM81
+    Prefix `lm81'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the National Semiconductor website
+	       http://www.national.com/
+
+The I2C addresses listed above assume BIOS has not changed the 
+chip MSB 5-bit address.  Each chip reports a unique manufacturer 
+identification code as well as the chip revision/stepping level.
+
+Authors:
+	Frodo Looijaard <frodol@dds.nl>,
+	 Philip Edelbrock <phil@netroedge.com>
+	Michiel Rook <michiel@grendelproject.nl>
+	Grant Coady <gcoady@gmail.com> with guidance from 
+	 Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+[From ADM9240] The ADM9240 is a complete system hardware monitor for 
+microprocessor-based systems, providing measurement and limit comparison 
+of up to four power supplies and two processor core voltages, plus 
+temperature, two fan speeds and chassis intrusion.  Measured values can 
+be read out via an I2C-compatible serial System Management Bus, and values 
+for limit comparisons can be programmed in over the same serial bus.  The 
+high speed successive approximation ADC allows frequent sampling of all 
+analog channels to ensure a fast interrupt response to any out-of-limit 
+measurement.
+
+
+On chip temperature is reported as degrees Celsius as 9-bit signed data 
+with resolution of 0.5 degrees Celsius.  High and low temperature limits 
+are 8-bit signed data with resolution of one degree Celsius.  The driver 
+sets temperature interrupt to comparator mode (per lm_sensors standard) 
+so that an alarm is asserted while the temperature exceeds the high limit, 
+in comparator mode the low temperature limit is ignored.
+
+
+Two fan tacho inputs are provided, the ADM9240 gates an internal 22.5kHz 
+via a divisor to an 8-bit counter.  Fan speed (rpm) is calculated by:
+
+rpm = (22.5 x 10^3 x 60) / (count x divisor)
+    = 1350000 / (count x divisor)  where divisor is 1, 2, 4 or 8.
+    = 1350000 / (count << setting) where setting is 0, 1, 2 or 3.
+
+The slow fan speed alarm is asserted when the fan revolution period 
+exceeds the limit value.  Fan speed limit value is scaled by the 
+divisor setting for fan speed measurement.
+
+
+An analog output provides a 0 to 1.25 volt signal intended for an external 
+fan speed amplifier circuit.  The analog output is set to maximum value on 
+power up or reset.
+
+
+Voltage (IN) measurement is internally scaled:
+
+	nr	label		 nominal	maximum
+				   mV		  mV
+	0	+2.5V		  2500		 3320
+	1	Vccp1		  2700		 3600
+	2	+3.3V		  3300		 4380
+	3	+5V		  5000		 6640
+	4	+12V		 12000		15940
+	5	Vccp2		  2700		 3600
+
+The reading is an unsigned 8-bit value, nominal voltage measurement is 
+represented by a reading of 192, being 3/4 of the measurement range.
+
+An error is asserted for any voltage going below or above the set limits.
+
+The driver reports and accepts voltage limits scaled to the above table.
+
+The chip may also be used to measure negative voltages, usually on Vccp2.  
+In this case user-space tools will scale their readings based on the 
+maximum mV values from the table above and transpose the high and low 
+limit values.  
+
+
+Chassis Intrusion alarm is asserted when the CI pin goes active high.
+The ADM9240 Datasheet has an example of an external temperature sensor 
+driving this pin.  On an Intel SE440BX-2 the Chassis Intrusion header 
+is expected to be connected to a normally closed switch.
+
+The ADM9240 provides an internal open drain on this line, and may output 
+a 20 ms active low pulse to reset an external Chassis Intrusion latch.
+
+Chip differences
+----------------
+ADM9240 has a very fast 320us temperature and voltage measurement cycle 
+with independent fan speed measurement cycles counting alternating rising 
+edges of the fan tacho inputs.  Comparisons are described as "exceeds 
+limit."
+
+DS1780 measurement cycle is about once per second including fan speed.
+"For the high limits of the voltages, the device is doing a greater than 
+comparison. For the low limits, however, it is doing a less than or equal 
+comparison."
+
+LM81 measurement cycle is about once per 400ms including fan speed, the 
+LM81 also has an unsupported 12-bit extended temperature measurement mode.
+"For voltage input high limits, the device is doing a greater than comparison.
+For low limits, however, it is doing a less than or equal to comparison."
+
