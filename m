From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Date: Fri, 25 Nov 2011 09:01:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: convert drivers/hwmon/* to use
Message-Id: <DB904C5425BA6F4E8424B3B51A1414D16D7629F9DF@NWD2CMBX1.ad.analog.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322205165.11718.2.camel@phoenix>
In-Reply-To: <1322205165.11718.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Marc Pignat <marc.pignat@hevs.ch>, Paul Thomas <pthomas8589@gmail.com>, Eric Miao <eric.miao@marvell.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Acked-by: Sonic Zhang <sonic.zhang@analog.com>

>-----Original Message-----
>From: Axel Lin [mailto:axel.lin@gmail.com]
>Sent: Friday, November 25, 2011 3:13 PM
>To: linux-kernel@vger.kernel.org
>Cc: Zhang, Sonic; Marc Pignat; Paul Thomas; Eric Miao; Jean
>Delvare; Guenter Roeck; lm-sensors@lm-sensors.org
>Subject: [PATCH] hwmon: convert drivers/hwmon/* to use
>module_spi_driver()
>
>This patch converts the drivers in drivers/hwmon/* to use the
>module_spi_driver() macro which makes the code smaller and a
>bit simpler.
>
>Cc: Sonic Zhang <sonic.zhang@analog.com>
>Cc: Marc Pignat <marc.pignat@hevs.ch>
>Cc: Paul Thomas <pthomas8589@gmail.com>
>Cc: Eric Miao <eric.miao@marvell.com>
>Signed-off-by: Axel Lin <axel.lin@gmail.com>
>---
> drivers/hwmon/ad7314.c  |   12 +-----------
> drivers/hwmon/adcxx.c   |   13 +------------
> drivers/hwmon/ads7871.c |   13 +------------
> drivers/hwmon/lm70.c    |   13 +------------
> drivers/hwmon/max1111.c |   12 +-----------
> 5 files changed, 5 insertions(+), 58 deletions(-)
>
>diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
>index 318e38e..4207c09 100644
>--- a/drivers/hwmon/ad7314.c
>+++ b/drivers/hwmon/ad7314.c
>@@ -168,17 +168,7 @@ static struct spi_driver ad7314_driver = {
>       .id_table = ad7314_id,
> };
>
>-static __init int ad7314_init(void)
>-{
>-      return spi_register_driver(&ad7314_driver);
>-}
>-module_init(ad7314_init);
>-
>-static __exit void ad7314_exit(void)
>-{
>-      spi_unregister_driver(&ad7314_driver);
>-}
>-module_exit(ad7314_exit);
>+module_spi_driver(ad7314_driver);
>
> MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
>MODULE_DESCRIPTION("Analog Devices AD7314, ADT7301 and ADT7302 digital"
>diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
>index b2cacbe..24f8cf4 100644
>--- a/drivers/hwmon/adcxx.c
>+++ b/drivers/hwmon/adcxx.c
>@@ -248,18 +248,7 @@ static struct spi_driver adcxx_driver = {
>       .remove = __devexit_p(adcxx_remove),
> };
>
>-static int __init init_adcxx(void)
>-{
>-      return spi_register_driver(&adcxx_driver);
>-}
>-
>-static void __exit exit_adcxx(void)
>-{
>-      spi_unregister_driver(&adcxx_driver);
>-}
>-
>-module_init(init_adcxx);
>-module_exit(exit_adcxx);
>+module_spi_driver(adcxx_driver);
>
> MODULE_AUTHOR("Marc Pignat");
> MODULE_DESCRIPTION("National Semiconductor adcxx8sxxx Linux
>driver"); diff --git a/drivers/hwmon/ads7871.c
>b/drivers/hwmon/ads7871.c index 5231934..6a2ce1e4 100644
>--- a/drivers/hwmon/ads7871.c
>+++ b/drivers/hwmon/ads7871.c
>@@ -235,18 +235,7 @@ static struct spi_driver ads7871_driver = {
>       .remove = __devexit_p(ads7871_remove),  };
>
>-static int __init ads7871_init(void)
>-{
>-      return spi_register_driver(&ads7871_driver);
>-}
>-
>-static void __exit ads7871_exit(void)
>-{
>-      spi_unregister_driver(&ads7871_driver);
>-}
>-
>-module_init(ads7871_init);
>-module_exit(ads7871_exit);
>+module_spi_driver(ads7871_driver);
>
> MODULE_AUTHOR("Paul Thomas <pthomas8589@gmail.com>");
>MODULE_DESCRIPTION("TI ADS7871 A/D driver"); diff --git
>a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c index
>c274ea2..b813022d 100644
>--- a/drivers/hwmon/lm70.c
>+++ b/drivers/hwmon/lm70.c
>@@ -213,18 +213,7 @@ static struct spi_driver lm70_driver = {
>       .remove = __devexit_p(lm70_remove),
> };
>
>-static int __init init_lm70(void)
>-{
>-      return spi_register_driver(&lm70_driver);
>-}
>-
>-static void __exit cleanup_lm70(void)
>-{
>-      spi_unregister_driver(&lm70_driver);
>-}
>-
>-module_init(init_lm70);
>-module_exit(cleanup_lm70);
>+module_spi_driver(lm70_driver);
>
> MODULE_AUTHOR("Kaiwan N Billimoria");
> MODULE_DESCRIPTION("NS LM70 / TI TMP121/TMP123 Linux
>driver"); diff --git a/drivers/hwmon/max1111.c
>b/drivers/hwmon/max1111.c index 5586cca..d0f4ef6 100644
>--- a/drivers/hwmon/max1111.c
>+++ b/drivers/hwmon/max1111.c
>@@ -227,17 +227,7 @@ static struct spi_driver max1111_driver = {
>       .remove         = __devexit_p(max1111_remove),
> };
>
>-static int __init max1111_init(void)
>-{
>-      return spi_register_driver(&max1111_driver);
>-}
>-module_init(max1111_init);
>-
>-static void __exit max1111_exit(void)
>-{
>-      spi_unregister_driver(&max1111_driver);
>-}
>-module_exit(max1111_exit);
>+module_spi_driver(max1111_driver);
>
> MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
> MODULE_DESCRIPTION("MAX1111 ADC Driver");
>--
>1.7.5.4
>
>
>
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
