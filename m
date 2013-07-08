From: Chris Pattenden <chris@aeryon.com>
Date: Mon, 08 Jul 2013 21:18:46 +0000
Subject: [lm-sensors] Bug Report: Bus substitution causing a problem
Message-Id: <51DB2CB6.4060303@aeryon.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Howdy,

I'm working to configure lm_sensors and have notice a few strange issues.

I'm working on a TI 8148 on custom hardware.
Linux 2.6.37
lm_sensors lm_sensors-3.3.4

i2cdetect -l shows the following:

	i2c-2   i2c             OMAP I2C adapter                        I2C adapter
	i2c-4   i2c             OMAP I2C adapter                        I2C adapter



I have two TI ADC128D818 ADCs (I cobbled together my own driver while 
waiting for support -- I see that someone else requested the same driver 
last week :-). They are:
	adc128d818-i2c-4-1d
	adc128d818-i2c-4-37

	
"sensors --bus-list" shows the following:
	bus "i2c-4" "OMAP I2C adapter"
Why bus i2c-2 isn't shown, I don't know. That's likely an issue.


I started using the following sensors.conf:
	chip "adc128d818-i2c-4-1d"
	label in0 "Test"

However, I was told that the "bus was unidentified".
I used the following sensors.conf, hoping to fix the problem:
	bus "i2c-4" "OMAP I2C adapter"
	chip "adc128d818-i2c-4-1d"
	label in0 "Test"
However, none in0 was not renamed as expected -- it printed as "in0".

It turns out that sensors_substitute_busses() incorrectly renumbers 
adc128d818-i2c-4-1d to adc128d818-i2c-2-1d and then can't find the 
labels. If I use the following sensors.conf (or comment out the call to 
sensors_substitute_busses()), sensors works as expected:
	chip "adc128d818-i2c-*-1d"
	label in0 "Test"

Am I doing something wrong or is there something strange going on with 
the bus renaming. What is the point of the bus renaming?

Thanks,
Chris


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
