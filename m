From: dconradin@gmx.net (Detlef Conradin)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-i810.c
Message-Id: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

The drivers for the I2C and DCC Busses don't work (at least on my
Computer).

With ver 2.7.0 nothing worked and no devices were detected by
i2cdetect. But i2c-algo-bit's bit_test succeded.

With ver 2.8.0 my Chrontel TV encoder was detected, but
communication did not work and i2c-algo-bit's bit_test failed.
(SDA stuck high). The driver got the first ACK (after sending the DAB),
but never got the second one after sending the RAB.

Using the attached patch everything works.

My Chipset (from lspci):
00:01.0 Class 0300: 8086:7121 (rev 02)

00:01.0 VGA compatible controller: Intel Corp. 82810 CGC [Chipset Graphics
Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Intel Corp. 82810 CGC [Chipset Graphics Controller]
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
        Memory at d0000000 (32-bit, prefetchable) [sizedM]
        Memory at d6000000 (32-bit, non-prefetchable) [sizeQ2K]
        Capabilities: <available only to root>

Detlef Conradin
-------------- next part --------------
diff -ur lm_sensors-2.8.0/kernel/busses/i2c-i810.c lm_sensors-2.8.0p/kernel/busses/i2c-i810.c
--- lm_sensors-2.8.0/kernel/busses/i2c-i810.c	2003-07-03 03:30:13.000000000 +0200
+++ lm_sensors-2.8.0p/kernel/busses/i2c-i810.c	2003-07-18 16:05:04.000000000 +0200
@@ -95,18 +95,39 @@
 /* The i810 GPIO registers have individual masks for each bit
    so we never have to read before writing. Nice. */
 
+/* The masks defined at the beginning of the file are wrong.
+   They seem to be according to the documentation,
+   but at least for me they don't work. I think
+   the documentation is incorrect.
+
+   D. Conradin <skyline@despammed.com>, 18.7.03 */
+ 
 static void bit_i810i2c_setscl(void *data, int val)
 {
-	outlong((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
-	     I810_GPIOB);
-	readlong(I810_GPIOB);	/* flush posted write */
+//	outlong((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
+//	     I810_GPIOB);
+//	readlong(I810_GPIOB);	/* flush posted write */
+	if (val) {
+		outlong(0x5, I810_GPIOB);
+		outlong(0x4, I810_GPIOB);
+	} else {
+		outlong(0x7, I810_GPIOB);
+		outlong(0x6, I810_GPIOB);
+	}
 }
 
 static void bit_i810i2c_setsda(void *data, int val)
 {
- 	outlong((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
-	     I810_GPIOB);
-	readlong(I810_GPIOB);	/* flush posted write */
+// 	outlong((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
+//	     I810_GPIOB);
+//	readlong(I810_GPIOB);	/* flush posted write */
+	if (val) {
+		outlong(0x500, I810_GPIOB);
+		outlong(0x400, I810_GPIOB);
+	} else {
+		outlong(0x700, I810_GPIOB);
+		outlong(0x600, I810_GPIOB);
+	}
 }
 
 /* The GPIO pins are open drain, so the pins could always remain outputs.
@@ -121,42 +142,56 @@
 
 static int bit_i810i2c_getscl(void *data)
 {
-	outlong(SCL_DIR_MASK, I810_GPIOB);
+//	outlong(SCL_DIR_MASK, I810_GPIOB);
 	outlong(0, I810_GPIOB);
 	return (0 != (readlong(I810_GPIOB) & SCL_VAL_IN));
 }
 
 static int bit_i810i2c_getsda(void *data)
 {
-	outlong(SDA_DIR_MASK, I810_GPIOB);
+//	outlong(SDA_DIR_MASK, I810_GPIOB);
 	outlong(0, I810_GPIOB);
 	return (0 != (readlong(I810_GPIOB) & SDA_VAL_IN));
 }
 
 static void bit_i810ddc_setscl(void *data, int val)
 {
-	outlong((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
-	     I810_GPIOA);
-	readlong(I810_GPIOA);	/* flush posted write */
+//	outlong((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
+//	     I810_GPIOA);
+//	readlong(I810_GPIOA);	/* flush posted write */
+	if (val) {
+		outlong(0x5, I810_GPIOA);
+		outlong(0x4, I810_GPIOA);
+	} else {
+		outlong(0x7, I810_GPIOA);
+		outlong(0x6, I810_GPIOA);
+	}
 }
 
 static void bit_i810ddc_setsda(void *data, int val)
 {
- 	outlong((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
-	     I810_GPIOA);
-	readlong(I810_GPIOA);	/* flush posted write */
+// 	outlong((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
+//	     I810_GPIOA);
+//	readlong(I810_GPIOA);	/* flush posted write */
+	if (val) {
+		outlong(0x500, I810_GPIOA);
+		outlong(0x400, I810_GPIOA);
+	} else {
+		outlong(0x700, I810_GPIOA);
+		outlong(0x600, I810_GPIOA);
+	}
 }
 
 static int bit_i810ddc_getscl(void *data)
 {
-	outlong(SCL_DIR_MASK, I810_GPIOA);
+//	outlong(SCL_DIR_MASK, I810_GPIOA);
 	outlong(0, I810_GPIOA);
 	return (0 != (readlong(I810_GPIOA) & SCL_VAL_IN));
 }
 
 static int bit_i810ddc_getsda(void *data)
 {
-	outlong(SDA_DIR_MASK, I810_GPIOA);
+//	outlong(SDA_DIR_MASK, I810_GPIOA);
 	outlong(0, I810_GPIOA);
 	return (0 != (readlong(I810_GPIOA) & SDA_VAL_IN));
 }
