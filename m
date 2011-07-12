From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jul 2011 09:01:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max1111) Avoid extra memory allocations
Message-Id: <20110712110152.4eead147@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We can allocate the tx and rx buffers as part of our data structure.
Doing so is faster and spares memory.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Can anyone with a MAX1111 device try and report please?

 drivers/hwmon/max1111.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

--- linux-3.0-rc6.orig/drivers/hwmon/max1111.c	2011-07-12 08:50:02.000000000 +0200
+++ linux-3.0-rc6/drivers/hwmon/max1111.c	2011-07-12 09:36:51.000000000 +0200
@@ -38,8 +38,8 @@ struct max1111_data {
 	struct device		*hwmon_dev;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[2];
-	uint8_t *tx_buf;
-	uint8_t *rx_buf;
+	uint8_t tx_buf[MAX1111_TX_BUF_SIZE];
+	uint8_t rx_buf[MAX1111_RX_BUF_SIZE];
 	struct mutex		drvdata_lock;
 	/* protect msg, xfer and buffers from multiple access */
 };
@@ -131,33 +131,23 @@ static const struct attribute_group max1
 	.attrs	= max1111_attributes,
 };
 
-static int setup_transfer(struct max1111_data *data)
+static int __devinit setup_transfer(struct max1111_data *data)
 {
 	struct spi_message *m;
 	struct spi_transfer *x;
 
-	data->tx_buf = kmalloc(MAX1111_TX_BUF_SIZE, GFP_KERNEL);
-	if (!data->tx_buf)
-		return -ENOMEM;
-
-	data->rx_buf = kmalloc(MAX1111_RX_BUF_SIZE, GFP_KERNEL);
-	if (!data->rx_buf) {
-		kfree(data->tx_buf);
-		return -ENOMEM;
-	}
-
 	m = &data->msg;
 	x = &data->xfer[0];
 
 	spi_message_init(m);
 
 	x->tx_buf = &data->tx_buf[0];
-	x->len = 1;
+	x->len = MAX1111_TX_BUF_SIZE;
 	spi_message_add_tail(x, m);
 
 	x++;
 	x->rx_buf = &data->rx_buf[0];
-	x->len = 2;
+	x->len = MAX1111_RX_BUF_SIZE;
 	spi_message_add_tail(x, m);
 
 	return 0;
@@ -192,7 +182,7 @@ static int __devinit max1111_probe(struc
 	err = sysfs_create_group(&spi->dev.kobj, &max1111_attr_group);
 	if (err) {
 		dev_err(&spi->dev, "failed to create attribute group\n");
-		goto err_free_all;
+		goto err_free_data;
 	}
 
 	data->hwmon_dev = hwmon_device_register(&spi->dev);
@@ -209,9 +199,6 @@ static int __devinit max1111_probe(struc
 
 err_remove:
 	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
-err_free_all:
-	kfree(data->rx_buf);
-	kfree(data->tx_buf);
 err_free_data:
 	kfree(data);
 	return err;
@@ -224,8 +211,6 @@ static int __devexit max1111_remove(stru
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
 	mutex_destroy(data->drvdata_lock);
-	kfree(data->rx_buf);
-	kfree(data->tx_buf);
 	kfree(data);
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
