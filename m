From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Wed, 12 Nov 2008 22:06:03 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081112220603.GA15914@roarinelk.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good evening,

On Wed, Nov 12, 2008 at 09:39:49PM +0100, Jean Delvare wrote:
> Hi Manuel,
> 
> On Thu, 23 Oct 2008 16:00:32 +0200, Manuel Lauss wrote:
> > > Ah, yes, the lack of an i2c_driver.id_table parameter was why I originally
> > > wrote a separate driver.  I suppose I could add another struct spi_driver
> > > for the TMP121 and sort out chip types internally.
> > 
> > Does this look acceptable?
> > 
> > --- 
> > 
> > From: Manuel Lauss <mano@roarinelk.homelinux.net>
> > Subject: [PATCH] hwmon: Extend LM70 with TMP121/TMP123 support.
> > 
> > The Texas Instruments TMP121 is a SPI temperature sensor very similar
> > to the LM70, with slightly higher resolution.  This patch extends the
> > LM70 driver to support the TMP121.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> > ---
> >  Documentation/hwmon/lm70 |    7 +++-
> >  drivers/hwmon/Kconfig    |    5 ++-
> >  drivers/hwmon/lm70.c     |   85 +++++++++++++++++++++++++++++++++++++++-------
> >  3 files changed, 81 insertions(+), 16 deletions(-)
> 
> Yes, this version of the patch looks all OK to me. It simply needed
> some fixes to apply properly on top of Kaiwan's lm70 fixes.
> 
> Can you please test the following two patches:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-01-fix-byte-order.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-02-ti-tmp121-support.patch
> 
> and confirm that things work fine for you with them applied?

Actually I made a new one fixing a few things David pointed out and rebased
on top of Kaiwan's patch.  And, it's run-tested too ;-)

Thanks!
	Manuel Lauss

--- 

From 1a28a0df02deff221004ea5e8b48984a122968fe Mon Sep 17 00:00:00 2001
From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 27 Oct 2008 19:00:04 +0100
Subject: [PATCH] hwmon: Extend LM70 with TMP121/TMP123 support.

The Texas Instruments TMP121 is a SPI temperature sensor very similar
to the LM70, with slightly higher resolution.  This patch extends the
LM70 driver to support the TMP121.  The TMP123 differs in pin assign-
ment.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 Documentation/hwmon/lm70 |    8 ++++-
 drivers/hwmon/Kconfig    |    5 ++-
 drivers/hwmon/lm70.c     |   84 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/lm70 b/Documentation/hwmon/lm70
index dc5c975..4fb18fd 100644
--- a/Documentation/hwmon/lm70
+++ b/Documentation/hwmon/lm70
@@ -1,9 +1,11 @@
 Kernel driver lm70
 =========
 
-Supported chip:
+Supported chips:
   * National Semiconductor LM70
     Datasheet: http://www.national.com/pf/LM/LM70.html
+  * Texas Instruments TMP121/TMP123
+    Information: http://focus.ti.com/docs/prod/folders/print/tmp121.html
 
 Author:
         Kaiwan N Billimoria <kaiwan@designergraphix.com>
@@ -29,6 +31,10 @@ As a real (in-tree) example of this "logical SPI protocol driver" interfacing
 with a "physical SPI master controller" driver, see drivers/spi/spi_lm70llp
 and it's associated documentation.
 
+The TMP121/TMP123 are very similar; main differences are 4 wire SPI inter-
+face (read only) and 13-bit temperature data (0.0625 degrees celsius reso-
+lution).
+
 Thanks to
 ---------
 Jean Delvare <khali@linux-fr.org> for mentoring the hwmon-side driver
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6de1e0f..f86923d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -407,11 +407,12 @@ config SENSORS_LM63
 	  will be called lm63.
 
 config SENSORS_LM70
-	tristate "National Semiconductor LM70"
+	tristate "National Semiconductor LM70 / Texas Instruments TMP121"
 	depends on SPI_MASTER && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the National Semiconductor
-	  LM70 digital temperature sensor chip.
+	  LM70 and Texas Instruments TMP121/TMP123 digital temperature
+	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm70.
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 8618014..d31522b 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -37,9 +37,13 @@
 
 #define DRVNAME		"lm70"
 
+#define LM70_CHIP_LM70		0	/* original NS LM70 */
+#define LM70_CHIP_TMP121	1	/* TI TMP121/TMP123 */
+
 struct lm70 {
 	struct device *hwmon_dev;
 	struct mutex lock;
+	unsigned int chip;
 };
 
 /* sysfs hook function */
@@ -47,7 +51,7 @@ static ssize_t lm70_sense_temp(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	int status, val;
+	int status, val = 0;
 	u8 rxbuf[2];
 	s16 raw=0;
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
@@ -70,6 +74,7 @@ static ssize_t lm70_sense_temp(struct device *dev,
 		rxbuf[0], rxbuf[1], raw);
 
 	/*
+	 * LM70:
 	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
 	 * complement value. Only the MSB 11 bits (1 sign + 10 temperature
 	 * bits) are meaningful; the LSB 5 bits are to be discarded.
@@ -79,8 +84,21 @@ static ssize_t lm70_sense_temp(struct device *dev,
 	 * by 0.25. Also multiply by 1000 to represent in millidegrees
 	 * Celsius.
 	 * So it's equivalent to multiplying by 0.25 * 1000 = 250.
+	 *
+	 * TMP121/TMP123:
+	 * 13 bits of 2's complement data, discard LSB 3 bits,
+	 * resolution 0.0625 degrees celsius.
 	 */
-	val = ((int)raw/32) * 250;
+	switch (p_lm70->chip) {
+	case LM70_CHIP_LM70:
+		val = ((int)raw / 32) * 250;
+		break;
+
+	case LM70_CHIP_TMP121:
+		val = ((int)raw / 8) * 625 / 10;
+		break;
+	}
+
 	status = sprintf(buf, "%d\n", val); /* millidegrees Celsius */
 out:
 	mutex_unlock(&p_lm70->lock);
@@ -92,27 +110,37 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
 static ssize_t lm70_show_name(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
-	return sprintf(buf, "lm70\n");
+	struct lm70 *p_lm70 = dev_get_drvdata(dev);
+	int ret;
+
+	switch (p_lm70->chip) {
+	case LM70_CHIP_LM70:
+		ret = sprintf(buf, "lm70\n");
+		break;
+	case LM70_CHIP_TMP121:
+		ret = sprintf(buf, "tmp121\n");
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static DEVICE_ATTR(name, S_IRUGO, lm70_show_name, NULL);
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit lm70_probe(struct spi_device *spi)
+static int __devinit common_probe(struct spi_device *spi, int chip)
 {
 	struct lm70 *p_lm70;
 	int status;
 
-	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
-	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
-		return -EINVAL;
-
 	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
 	if (!p_lm70)
 		return -ENOMEM;
 
 	mutex_init(&p_lm70->lock);
+	p_lm70->chip = chip;
 
 	/* sysfs hook */
 	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
@@ -140,6 +168,24 @@ out_dev_reg_failed:
 	return status;
 }
 
+static int __devinit lm70_probe(struct spi_device *spi)
+{
+	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
+	if ((spi->mode & (SPI_CPOL | SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
+		return -EINVAL;
+
+	return common_probe(spi, LM70_CHIP_LM70);
+}
+
+static int __devinit tmp121_probe(struct spi_device *spi)
+{
+	/* signaling is SPI_MODE_0 with only MISO connected */
+	if (spi->mode & (SPI_CPOL | SPI_CPHA))
+		return -EINVAL;
+
+	return common_probe(spi, LM70_CHIP_TMP121);
+}
+
 static int __devexit lm70_remove(struct spi_device *spi)
 {
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
@@ -153,6 +199,15 @@ static int __devexit lm70_remove(struct spi_device *spi)
 	return 0;
 }
 
+static struct spi_driver tmp121_driver = {
+	.driver = {
+		.name	= "tmp121",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= tmp121_probe,
+	.remove	= __devexit_p(lm70_remove),
+};
+
 static struct spi_driver lm70_driver = {
 	.driver = {
 		.name	= "lm70",
@@ -164,17 +219,26 @@ static struct spi_driver lm70_driver = {
 
 static int __init init_lm70(void)
 {
-	return spi_register_driver(&lm70_driver);
+	int ret = spi_register_driver(&lm70_driver);
+	if (ret)
+		return ret;
+
+	ret = spi_register_driver(&tmp121_driver);
+	if (ret)
+		spi_unregister_driver(&lm70_driver);
+
+	return ret;
 }
 
 static void __exit cleanup_lm70(void)
 {
 	spi_unregister_driver(&lm70_driver);
+	spi_unregister_driver(&tmp121_driver);
 }
 
 module_init(init_lm70);
 module_exit(cleanup_lm70);
 
 MODULE_AUTHOR("Kaiwan N Billimoria");
-MODULE_DESCRIPTION("National Semiconductor LM70 Linux driver");
+MODULE_DESCRIPTION("NS LM70 / TI TMP121/TMP123 Linux driver");
 MODULE_LICENSE("GPL");
-- 
1.6.0.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
