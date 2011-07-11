From: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Mon, 11 Jul 2011 18:47:31 +0000
Subject: [lm-sensors] [PATCH v2] MAX1111: Fix Race condition causing NULL
Message-Id: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

spi_sync call uses its spi_message parameter to keep completion information,
having this structure static is not thread-safe, potentially causing one
thread having pointers to memory on or above other threads stack. use mutex
to prevent multiple access

Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Cyril Hrubis <metan@ucw.cz>
---
 drivers/hwmon/max1111.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index 12a54aa..d872f57 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -40,6 +40,7 @@ struct max1111_data {
 	struct spi_transfer	xfer[2];
 	uint8_t *tx_buf;
 	uint8_t *rx_buf;
+	struct mutex		msg_lock_mutex;
 };
 
 static int max1111_read(struct device *dev, int channel)
@@ -48,6 +49,11 @@ static int max1111_read(struct device *dev, int channel)
 	uint8_t v1, v2;
 	int err;
 
+	/* spi_sync requires data not to be freed before function returns
+	 * for static data, any access is dangerous, use locks
+	 */
+	mutex_lock(&data->msg_lock_mutex);
+
 	data->tx_buf[0] = (channel << MAX1111_CTRL_SEL_SH) |
 		MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
 		MAX1111_CTRL_SGL | MAX1111_CTRL_UNI | MAX1111_CTRL_STR;
@@ -55,12 +61,15 @@ static int max1111_read(struct device *dev, int channel)
 	err = spi_sync(data->spi, &data->msg);
 	if (err < 0) {
 		dev_err(dev, "spi_sync failed with %d\n", err);
+		mutex_unlock(&data->msg_lock_mutex);
 		return err;
 	}
 
 	v1 = data->rx_buf[0];
 	v2 = data->rx_buf[1];
 
+	mutex_unlock(&data->msg_lock_mutex);
+
 	if ((v1 & 0xc0) || (v2 & 0x3f))
 		return -EINVAL;
 
@@ -176,6 +185,8 @@ static int __devinit max1111_probe(struct spi_device *spi)
 	if (err)
 		goto err_free_data;
 
+	mutex_init(&data->msg_lock_mutex);
+
 	data->spi = spi;
 	spi_set_drvdata(spi, data);
 
@@ -213,6 +224,7 @@ static int __devexit max1111_remove(struct spi_device *spi)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
+	mutex_destroy(data->msg_lock_mutex);
 	kfree(data->rx_buf);
 	kfree(data->tx_buf);
 	kfree(data);
-- 
1.7.5.rc3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
