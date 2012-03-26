From: Stefan Roese <sr@denx.de>
Date: Mon, 26 Mar 2012 15:33:38 +0000
Subject: [lm-sensors] Location for ADC driver
Message-Id: <201203261733.38794.sr@denx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-iio@vger.kernel.org

Hi,

I'll start porting a driver for the ST SPEAr600 SoC internal ADC in a short 
while. First I thought it would be located in drivers/hwmon with its 
infrastructure. Then I noticed the drivers/staging/iio/adc directory.

So my question is, where should such an SoC internal ADC driver best be 
placed? hwmon or iio/adc? Or can I choose freely?

Thanks,
Stefan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
