From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Thu, 23 Oct 2008 14:00:32 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081023140032.GA23831@roarinelk.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

I wrote:
> On Thu, Oct 23, 2008 at 03:20:30PM +0200, Jean Delvare wrote:
> > On Thu, 23 Oct 2008 15:13:23 +0200, Manuel Lauss wrote:
> > > On Thu, Oct 23, 2008 at 02:57:10PM +0200, Jean Delvare wrote:
> > > > I don't know much about the SPI side of things so I would like someone
> > > > else to comment on that aspect of the patch (in particular the way
> > > > different device types are supported by the same driver.) David, can
> > > > you please take a look and let us know if you have any objection?
> > > 
> > > I'd be more than happy to just use a number cast to void * for 
> > > spi platform_data and get rid of this header.  I'm not sure however
> > > whether this is acceptable style for kernel code.
> > 
> > Err, no, that's not what I was suggesting. Abusing pointers to store
> > integers is bad, please don't do that.
> > 
> > I was more curious about the need to have such arbitrary numbers to
> > differentiate between chip types. For i2c, we can just tell a driver to
> > support several chip names. But maybe the spi subsystem doesn't support
> > that.
> 
> Ah, yes, the lack of an i2c_driver.id_table parameter was why I originally
> wrote a separate driver.  I suppose I could add another struct spi_driver
> for the TMP121 and sort out chip types internally.

Does this look acceptable?

--- 

From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] hwmon: Extend LM70 with TMP121/TMP123 support.

The Texas Instruments TMP121 is a SPI temperature sensor very similar
to the LM70, with slightly higher resolution.  This patch extends the
LM70 driver to support the TMP121.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 Documentation/hwmon/lm70 |    7 +++-
 drivers/hwmon/Kconfig    |    5 ++-
 drivers/hwmon/lm70.c     |   85 +++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/lm70 b/Documentation/hwmon/lm70
index 2bdd3fe..80716d2 100644
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
@@ -25,6 +27,9 @@ complement digital temperature (sent via the SIO line), is available in the
 driver for interpretation. This driver makes use of the kernel's in-core
 SPI support.
 
+The TMP121 is very similar; main differences are 4 wire SPI interface
+and 13-bit temperature data (0.0625 degrees celsius resolution).
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
index d435f00..8c7651b 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -37,9 +37,13 @@
 
 #define DRVNAME		"lm70"
 
+#define LM70_CHIP_LM70		0
+#define LM70_CHIP_TMP121	1
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
@@ -67,10 +71,8 @@ static ssize_t lm70_sense_temp(struct device *dev,
 	}
 	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
 
-	raw = (rxbuf[1] << 8) + rxbuf[0];
-	dev_dbg(dev, "raw=0x%x\n", raw);
-
 	/*
+	 * LM70:
 	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
 	 * complement value. Only the MSB 11 bits (1 sign + 10 temperature
 	 * bits) are meaningful; the LSB 5 bits are to be discarded.
@@ -80,8 +82,23 @@ static ssize_t lm70_sense_temp(struct device *dev,
 	 * by 0.25. Also multiply by 1000 to represent in millidegrees
 	 * Celsius.
 	 * So it's equivalent to multiplying by 0.25 * 1000 = 250.
+	 *
+	 * TMP121:
+	 * 13 bits of 2's complement data, discard LSB 3 bits.  Chip
+	 * transmits high byte first.  Resolution 0.0625 degrees celsius.
 	 */
-	val = ((int)raw/32) * 250;
+	switch (p_lm70->chip) {
+	case LM70_CHIP_LM70:
+		raw = (rxbuf[1] << 8) + rxbuf[0];
+		val = ((int)raw/32) * 250;
+		break;
+
+	case LM70_CHIP_TMP121:
+		raw = (rxbuf[0] << 8) + rxbuf[1];
+		val = (raw / 8) * 625 / 10;
+		break;
+	}
+	dev_dbg(dev, "raw=0x%x\n", raw);
 	status = sprintf(buf, "%d\n", val); /* millidegrees Celsius */
 out:
 	mutex_unlock(&p_lm70->lock);
@@ -93,27 +110,37 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
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
@@ -141,6 +168,20 @@ out_dev_reg_failed:
 	return status;
 }
 
+static int __devinit lm70_probe(struct spi_device *spi)
+{
+	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
+	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
+		return -EINVAL;
+
+	return common_probe(spi, LM70_CHIP_LM70);
+}
+
+static int __devinit tmp121_probe(struct spi_device *spi)
+{
+	return common_probe(spi, LM70_CHIP_TMP121);
+}
+
 static int __devexit lm70_remove(struct spi_device *spi)
 {
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
@@ -154,6 +195,15 @@ static int __devexit lm70_remove(struct spi_device *spi)
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
@@ -165,17 +215,26 @@ static struct spi_driver lm70_driver = {
 
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
+MODULE_DESCRIPTION("National Semiconductor LM70 / TI TMP121 Linux driver");
 MODULE_LICENSE("GPL");
-- 
1.6.0.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
