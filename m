From: David Brownell <david-b@pacbell.net>
Date: Thu, 13 Nov 2008 08:53:05 +0000
Subject: Re: [lm-sensors] [PATCH] SPI lm70: Code streamlining and cleanup
Message-Id: <200811130053.05828.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1226474799.18411.21.camel@kaiwan-1>
In-Reply-To: <1226474799.18411.21.camel@kaiwan-1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 12 November 2008, Jean Delvare wrote:
> David, can we get this patch reviewed and pushed upstream quickly? So
> that I can finally take Manuel's patch adding support for the TMP121.

Yeah, appended.  I made some minor updates, notably:

 - using URLs from National's website
 - listing the real name of the eval board (!)
 - there is no "D9" bit in any byte; explain that change better
 - restore a comment of mine :)

And different patch comments -- sorry, I lost the first set.

Jean, I think it's best if you merge this through your tree
along with Manuel's patch.

- Dave


====== CUT HERE
From: Kaiwan N Billimoria <kaiwan@designergraphix.com>

This fixes a byteswap bug in the LM70 temperature sensor driver,
which was previously covered up by a converse bug in the driver
for the LM70EVAL-LLP board (which is also fixed).

Other fixes:  doc updates, remove an annoying msleep(), and improve
three-wire protocol handling.

Signed-off-by: Kaiwan N Billimoria <kaiwan@designergraphix.com>
[ dbrownell@users.sourceforge.net: doc and whitespace tweaks ]
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 Documentation/hwmon/lm70      |    4 ++++
 Documentation/spi/spi-lm70llp |   10 ++++++++++
 drivers/hwmon/lm70.c          |    9 +++++----
 drivers/spi/spi_lm70llp.c     |   33 ++++++++++++---------------------
 4 files changed, 31 insertions(+), 25 deletions(-)

--- a/Documentation/hwmon/lm70
+++ b/Documentation/hwmon/lm70
@@ -25,6 +25,10 @@ complement digital temperature (sent via
 driver for interpretation. This driver makes use of the kernel's in-core
 SPI support.
 
+As a real (in-tree) example of this "SPI protocol driver" interfacing
+with a "SPI master controller driver", see drivers/spi/spi_lm70llp.c
+and its associated documentation.
+
 Thanks to
 ---------
 Jean Delvare <khali@linux-fr.org> for mentoring the hwmon-side driver
--- a/Documentation/spi/spi-lm70llp
+++ b/Documentation/spi/spi-lm70llp
@@ -13,10 +13,20 @@ Description
 This driver provides glue code connecting a National Semiconductor LM70 LLP
 temperature sensor evaluation board to the kernel's SPI core subsystem.
 
+This is a SPI master controller driver. It can be used in conjunction with
+(layered under) the LM70 logical driver (a "SPI protocol driver").
 In effect, this driver turns the parallel port interface on the eval board
 into a SPI bus with a single device, which will be driven by the generic
 LM70 driver (drivers/hwmon/lm70.c).
 
+
+Hardware Interfacing
+--------------------
+The schematic for this particular board (the LM70EVAL-LLP) is
+available (on page 4) here:
+
+  http://www.national.com/appinfo/tempsensors/files/LM70LLPEVALmanual.pdf
+
 The hardware interfacing on the LM70 LLP eval board is as follows:
 
    Parallel                 LM70 LLP
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -65,10 +65,9 @@ static ssize_t lm70_sense_temp(struct de
 		"spi_write_then_read failed with status %d\n", status);
 		goto out;
 	}
-	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
-
-	raw = (rxbuf[1] << 8) + rxbuf[0];
-	dev_dbg(dev, "raw=0x%x\n", raw);
+	raw = (rxbuf[0] << 8) + rxbuf[1];
+	dev_dbg(dev, "rxbuf[0] : 0x%02x rxbuf[1] : 0x%02x raw=0x%04x\n",
+		rxbuf[0], rxbuf[1], raw);
 
 	/*
 	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
@@ -109,6 +108,8 @@ static int __devinit lm70_probe(struct s
 	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
 		return -EINVAL;
 
+	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
+
 	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
 	if (!p_lm70)
 		return -ENOMEM;
--- a/drivers/spi/spi_lm70llp.c
+++ b/drivers/spi/spi_lm70llp.c
@@ -1,5 +1,5 @@
 /*
- * spi_lm70llp.c - driver for lm70llp eval board for the LM70 sensor
+ * spi_lm70llp.c - driver for LM70EVAL-LLP board for the LM70 sensor
  *
  * Copyright (C) 2006 Kaiwan N Billimoria <kaiwan@designergraphix.com>
  *
@@ -40,8 +40,12 @@
  * master controller driver.  The hwmon/lm70 driver is a "SPI protocol
  * driver", layered on top of this one and usable without the lm70llp.
  *
+ * Datasheet and Schematic:
  * The LM70 is a temperature sensor chip from National Semiconductor; its
  * datasheet is available at http://www.national.com/pf/LM/LM70.html
+ * The schematic for this particular board (the LM70EVAL-LLP) is
+ * available (on page 4) here:
+ *  http://www.national.com/appinfo/tempsensors/files/LM70LLPEVALmanual.pdf
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
@@ -106,12 +110,16 @@ static inline struct spi_lm70llp *spidev
 static inline void deassertCS(struct spi_lm70llp *pp)
 {
 	u8 data = parport_read_data(pp->port);
+
+	data &= ~0x80;		/* pull D7/SI-out low while de-asserted */
 	parport_write_data(pp->port, data | nCS);
 }
 
 static inline void assertCS(struct spi_lm70llp *pp)
 {
 	u8 data = parport_read_data(pp->port);
+
+	data |= 0x80;		/* pull D7/SI-out high so lm70 drives SO-in */
 	parport_write_data(pp->port, data & ~nCS);
 }
 
@@ -184,22 +192,7 @@ static void lm70_chipselect(struct spi_d
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
@@ -293,10 +286,9 @@ static void spi_lm70llp_attach(struct pa
 		status = -ENODEV;
 		goto out_bitbang_stop;
 	}
-	pp->spidev_lm70->bits_per_word = 16;
+	pp->spidev_lm70->bits_per_word = 8;
 
 	lm70llp = pp;
-
 	return;
 
 out_bitbang_stop:
@@ -326,7 +318,6 @@ static void spi_lm70llp_detach(struct pa
 
 	/* power down */
 	parport_write_data(pp->port, 0);
-	msleep(10);
 
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
