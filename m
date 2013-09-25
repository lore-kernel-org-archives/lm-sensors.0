From: Benjo Dans <bdans@acromag.com>
Date: Wed, 25 Sep 2013 21:45:38 +0000
Subject: Re: [lm-sensors] Tmp75 sensor installation
Message-Id: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B569C@ex01.acromag.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
In-Reply-To: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean/Guenter,

I am not sure where I got the version from but it is working a little bit better after getting the one from your link.  Thank you for noticing that difference.  I now get the following using i2cdetect -l after loading i2c-dev and the newer i2c-i801.

I2c-0	i2c	i915 gmbus ssc					I2C adapter
I2c-1	i2c	i915 gmbus vga					I2C adapter 
I2c-2	i2c	i915 gmbus panel				I2C adapter
I2c-3	i2c	i915 gmbus dpc 				I2C adapter
I2c-4	i2c	i915 gmbus dpb				I2C adapter
I2c-5	i2c	i915 gmbus dpd				I2C adapter
I2c-6	i2c	i915 gmbus DPDDC-D				I2C adapter

Although I do see devices on i2c-1, I still do not see the smbus anywhere.  This aligns with my not seeing any activity on the smbus with an oscilloscope during the i2cdetect process.  What am I missing on why it is not communicating and/or finding my Lynx Point PCH as well as the devices connected to that smbus?

As always, thank you, everyone.

Benjo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
