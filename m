From: Tobias Himmer <tobias@himmer-online.de>
Date: Thu, 24 Jul 2008 09:51:50 +0000
Subject: Re: [lm-sensors] [RFC,PATCH v1] hwmon: ADC124S501 generic driver
Message-Id: <200807241151.50915.tobias@himmer-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807231307.54837.marc.pignat@hevs.ch>
In-Reply-To: <200807231307.54837.marc.pignat@hevs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, marc.pignat@hevs.ch

Hi Marc,

I just wrote a similar driver for the ADC088S052.
Yesterday I noticed your patch and successfully tested a slightly
modified version of it that supports 8 channels.
The patch below goes on top of yours.

Bye

Tobias

Signed-off-by: Tobias Himmer <tobias@himmer-online.de>
---

Index: linux-2.6.26-rc/drivers/hwmon/adcxx.c
=================================--- linux-2.6.26-rc.orig/drivers/hwmon/adcxx.c
+++ linux-2.6.26-rc/drivers/hwmon/adcxx.c
@@ -5,13 +5,15 @@
  *
  * Copyright (c) 2008 Marc Pignat <marc.pignat@hevs.ch>
  *
+ * 8 channel support added by Tobias Himmer <tobias@himmer-online.de>
+ *
  * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
  * interface. This driver supports the whole family of devices with name
  * ADC<bb><c>S<sss>, where
  * * bb is the resolution in number of bits (8, 10, 12)
- * * c is the number of channels (1, 2, 4)
- * * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
- *   and 101 for 1 MSPS)
+ * * c is the number of channels (1, 2, 4, 8)
+ * * sss is the maximum conversion speed (021 for 200 kSPS, 051 / 052 for
+ *   500 kSPS and 101 for 1 MSPS)
  *
  * Complete datasheets are available at National's website here:
  * http://www.national.com/ds/DC/ADC<bb><c>S<sss>.pdf
@@ -155,6 +157,10 @@ static struct sensor_device_attribute ad
 	SENSOR_ATTR(in1_input, S_IRUGO, adcxx_read, NULL, 1),
 	SENSOR_ATTR(in2_input, S_IRUGO, adcxx_read, NULL, 2),
 	SENSOR_ATTR(in3_input, S_IRUGO, adcxx_read, NULL, 3),
+	SENSOR_ATTR(in4_input, S_IRUGO, adcxx_read, NULL, 4),
+	SENSOR_ATTR(in5_input, S_IRUGO, adcxx_read, NULL, 5),
+	SENSOR_ATTR(in6_input, S_IRUGO, adcxx_read, NULL, 6),
+	SENSOR_ATTR(in7_input, S_IRUGO, adcxx_read, NULL, 7),
};
 
 /*----------------------------------------------------------------------*/
@@ -218,6 +224,11 @@ static int __devinit adcxx4s_probe(struc
 	return adcxx_probe(spi, 4);
}
 
+static int __devinit adcxx8s_probe(struct spi_device *spi)
+{
+	return adcxx_probe(spi, 8);
+}
+
 static int __devexit adcxx_remove(struct spi_device *spi)
{
 	struct adcxx *adc = dev_get_drvdata(&spi->dev);
@@ -259,6 +270,15 @@ static struct spi_driver adcxx4s_driver 
 	.remove	= __devexit_p(adcxx_remove),
};
 
+static struct spi_driver adcxx8s_driver = {
+	.driver = {
+		.name	= "adcxx8s",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= adcxx8s_probe,
+	.remove	= __devexit_p(adcxx_remove),
+};
+
 static int __init init_adcxx(void)
{
 	int status;
@@ -270,7 +290,11 @@ static int __init init_adcxx(void)
 	if (status)
 		return status;
 
-	return spi_register_driver(&adcxx4s_driver);
+	status = spi_register_driver(&adcxx4s_driver);
+	if (status)
+		return status;
+
+	return spi_register_driver(&adcxx8s_driver);
}
 
 static void __exit exit_adcxx(void)
@@ -278,6 +302,7 @@ static void __exit exit_adcxx(void)
 	spi_unregister_driver(&adcxx1s_driver);
 	spi_unregister_driver(&adcxx2s_driver);
 	spi_unregister_driver(&adcxx4s_driver);
+	spi_unregister_driver(&adcxx8s_driver);
}
 
 module_init(init_adcxx);
@@ -290,3 +315,4 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("adcxx1s");
 MODULE_ALIAS("adcxx2s");
 MODULE_ALIAS("adcxx4s");
+MODULE_ALIAS("adcxx8s");
Index: linux-2.6.26-rc/drivers/hwmon/Kconfig
=================================--- linux-2.6.26-rc.orig/drivers/hwmon/Kconfig
+++ linux-2.6.26-rc/drivers/hwmon/Kconfig
@@ -397,9 +397,9 @@ config SENSORS_ADCXX
 	  If you say yes here you get support for the National Semiconductor
 	  ADC<bb><c>S<sss> chip family, where
 	  * bb  is the resolution in number of bits (8, 10, 12)
-	  * c   is the number of channels (1, 2, 4)
-	  * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500
-	    kSPS and 101 for 1 MSPS)
+	  * c   is the number of channels (1, 2, 4, 8)
+	  * sss is the maximum conversion speed (021 for 200 kSPS, 051 / 052 for
+	    500 kSPS and 101 for 1 MSPS)
 
 	  Examples : ADC081S101, ADC124S501, ...
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
