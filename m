From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Date: Wed, 12 Nov 2008 08:30:30 +0000
Subject: Re: [lm-sensors] [PATCH] SPI lm70: Code streamlining and cleanup
Message-Id: <1226477910.18411.41.camel@kaiwan-1>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-czAF1TbG7Wfn1BnG7tJA"
List-Id: <lm-sensors.vger.kernel.org>
References: <1226474799.18411.21.camel@kaiwan-1>
In-Reply-To: <1226474799.18411.21.camel@kaiwan-1>
To: lm-sensors@vger.kernel.org


--=-czAF1TbG7Wfn1BnG7tJA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2008-11-11 at 23:59 -0800, David Brownell wrote:
> On Tuesday 11 November 2008, Kaiwan N Billimoria wrote:
> > +As a real (in-tree) example of this "logical SPI protocol driver"
> > interfacing
> > +with a "physical SPI master controller" driver, see
> > drivers/spi/spi_lm70llp 
> > +and it's associated documentation.
> 
> This patch arrived badly word wrapped.  Could you resend?
> Attachment is OK.

Sigh. sorry..

Pl find the patch attached.

Regards,
-kaiwan.


--=-czAF1TbG7Wfn1BnG7tJA
Content-Disposition: attachment; filename=spi_lm70.nov08.patch
Content-Type: text/x-patch; name=spi_lm70.nov08.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -uprN -X a/Documentation/dontdiff a/Documentation/hwmon/lm70 b/Documentation/hwmon/lm70
--- a/Documentation/hwmon/lm70	2008-10-10 03:43:53.000000000 +0530
+++ b/Documentation/hwmon/lm70	2008-11-12 12:17:21.000000000 +0530
@@ -25,6 +25,10 @@ complement digital temperature (sent via
 driver for interpretation. This driver makes use of the kernel's in-core
 SPI support.
 
+As a real (in-tree) example of this "logical SPI protocol driver" interfacing
+with a "physical SPI master controller" driver, see drivers/spi/spi_lm70llp 
+and it's associated documentation.
+
 Thanks to
 ---------
 Jean Delvare <khali@linux-fr.org> for mentoring the hwmon-side driver
diff -uprN -X a/Documentation/dontdiff a/Documentation/spi/spi-lm70llp b/Documentation/spi/spi-lm70llp
--- a/Documentation/spi/spi-lm70llp	2008-10-10 03:43:53.000000000 +0530
+++ b/Documentation/spi/spi-lm70llp	2008-11-12 12:13:50.000000000 +0530
@@ -13,10 +13,19 @@ Description
 This driver provides glue code connecting a National Semiconductor LM70 LLP
 temperature sensor evaluation board to the kernel's SPI core subsystem.
 
+This is an SPI master controller driver. It can be used in conjunction with 
+(layered under) the LM70 logical driver (an "SPI protocol driver").
 In effect, this driver turns the parallel port interface on the eval board
 into a SPI bus with a single device, which will be driven by the generic
 LM70 driver (drivers/hwmon/lm70.c).
 
+
+Hardware Interfacing
+--------------------
+The schematic for this particular board (the LM70LLP eval board) is 
+available (on page 4) here:
+http://www.designergraphix.com/pull/spi_lm70/LM70LLPEVALmanual.pdf
+
 The hardware interfacing on the LM70 LLP eval board is as follows:
 
    Parallel                 LM70 LLP
@@ -67,3 +76,4 @@ Thanks to
 o David Brownell for mentoring the SPI-side driver development.
 o Dr.Craig Hollabaugh for the (early) "manual" bitbanging driver version.
 o Nadir Billimoria for help interpreting the circuit schematic.
+
diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
--- a/drivers/hwmon/lm70.c	2008-10-10 03:43:53.000000000 +0530
+++ b/drivers/hwmon/lm70.c	2008-11-12 12:18:34.000000000 +0530
@@ -65,10 +65,9 @@ static ssize_t lm70_sense_temp(struct de
 		"spi_write_then_read failed with status %d\n", status);
 		goto out;
 	}
-	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
-
-	raw = (rxbuf[1] << 8) + rxbuf[0];
-	dev_dbg(dev, "raw=0x%x\n", raw);
+	raw = (rxbuf[0] << 8) + rxbuf[1];
+	dev_dbg(dev, "rxbuf[0] : 0x%x rxbuf[1] : 0x%x raw=0x%08x\n", 
+		rxbuf[0], rxbuf[1], raw);
 
 	/*
 	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
diff -uprN -X a/Documentation/dontdiff a/drivers/spi/spi_lm70llp.c b/drivers/spi/spi_lm70llp.c
--- a/drivers/spi/spi_lm70llp.c	2008-10-10 03:43:53.000000000 +0530
+++ b/drivers/spi/spi_lm70llp.c	2008-11-12 12:12:16.000000000 +0530
@@ -1,5 +1,5 @@
 /*
- * spi_lm70llp.c - driver for lm70llp eval board for the LM70 sensor
+ * spi_lm70llp.c - driver for LM70LLP eval board for the LM70 sensor
  *
  * Copyright (C) 2006 Kaiwan N Billimoria <kaiwan@designergraphix.com>
  *
@@ -27,11 +27,9 @@
 #include <linux/sysfs.h>
 #include <linux/workqueue.h>
 
-
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 
-
 /*
  * The LM70 communicates with a host processor using a 3-wire variant of
  * the SPI/Microwire bus interface. This driver specifically supports an
@@ -40,8 +38,14 @@
  * master controller driver.  The hwmon/lm70 driver is a "SPI protocol
  * driver", layered on top of this one and usable without the lm70llp.
  *
+ * Datasheet and Schematic:
  * The LM70 is a temperature sensor chip from National Semiconductor; its
  * datasheet is available at http://www.national.com/pf/LM/LM70.html
+ * You can also find it here: 
+ *  http://www.designergraphix.com/pull/spi_lm70/LM70.pdf
+ * The schematic for this particular board (the LM70LLP eval board) is 
+ * available (on page 4) here:
+ *  http://www.designergraphix.com/pull/spi_lm70/LM70LLPEVALmanual.pdf
  *
  * Also see Documentation/spi/spi-lm70llp.  The SPI<->parport code here is
  * (heavily) based on spi-butterfly by David Brownell.
@@ -64,7 +68,7 @@
  *
  * Note that parport pin 13 actually gets inverted by the transistor
  * arrangement which lets either the parport or the LM70 drive the
- * SI/SO signal.
+ * SI/SO signal (see the schematic for details).
  */
 
 #define DRVNAME		"spi-lm70llp"
@@ -106,12 +110,14 @@ static inline struct spi_lm70llp *spidev
 static inline void deassertCS(struct spi_lm70llp *pp)
 {
 	u8 data = parport_read_data(pp->port);
+	data &= ~0x80; /* keep D9 low while de-asserted */
 	parport_write_data(pp->port, data | nCS);
 }
 
 static inline void assertCS(struct spi_lm70llp *pp)
 {
 	u8 data = parport_read_data(pp->port);
+	data |= 0x80; /* keep D9 high while asserted */
 	parport_write_data(pp->port, data & ~nCS);
 }
 
@@ -184,22 +190,7 @@ static void lm70_chipselect(struct spi_d
  */
 static u32 lm70_txrx(struct spi_device *spi, unsigned nsecs, u32 word, u8 bits)
 {
-	static u32 sio=0;
-	static int first_time=1;
-
-	/* First time: perform SPI bitbang and return the LSB of
-	 * the result of the SPI call.
-	 */
-	if (first_time) {
-		sio = bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
-		first_time=0;
-		return (sio & 0x00ff);
-	}
-	/* Return the MSB of the result of the SPI call */
-	else {
-		first_time=1;
-		return (sio >> 8);
-	}
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
 }
 
 static void spi_lm70llp_attach(struct parport *p)
@@ -293,10 +284,9 @@ static void spi_lm70llp_attach(struct pa
 		status = -ENODEV;
 		goto out_bitbang_stop;
 	}
-	pp->spidev_lm70->bits_per_word = 16;
+	pp->spidev_lm70->bits_per_word = 8;
 
 	lm70llp = pp;
-
 	return;
 
 out_bitbang_stop:
@@ -326,7 +316,6 @@ static void spi_lm70llp_detach(struct pa
 
 	/* power down */
 	parport_write_data(pp->port, 0);
-	msleep(10);
 
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);

--=-czAF1TbG7Wfn1BnG7tJA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-czAF1TbG7Wfn1BnG7tJA--

