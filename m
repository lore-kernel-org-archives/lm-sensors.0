From: Benjo Dans <bdans@acromag.com>
Date: Tue, 24 Sep 2013 21:46:14 +0000
Subject: [lm-sensors] Tmp75 sensor installation
Message-Id: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Texas Instrument Tmp75 installed on the smbus (Intel LynxPoint PCH). I have installed the following drivers:

i2c-i801.c (make and make install)
lm75.ko (sudo insmod lm75.ko)

I have ran "sensors" but it still cannot see my chip.  I have also installed your i2c-tools but when I run i2cdetect -l, it does not detect my smbus.  What drivers and/or files am I missing here?

Benjo Dans
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
