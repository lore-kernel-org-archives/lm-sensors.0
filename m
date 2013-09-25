From: Benjo Dans <bdans@acromag.com>
Date: Wed, 25 Sep 2013 13:18:47 +0000
Subject: Re: [lm-sensors] Tmp75 sensor installation
Message-Id: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5666@ex01.acromag.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
In-Reply-To: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter,

Yes. Both lm75 and i2c-i801 appear when I run lsmod  both of them are listed as shown below ...

Module     Size   Used by
lm75         13435  0
i2c-i801    18136  0

I also noticed that under /dev,  I do not see any i2c* devices at all.

By the way, I am using Fedora with kernel 3.11.1.200.fc19.x86_64.  Thank you, Guenter.

Benjo

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Tuesday, September 24, 2013 5:55 PM
To: Benjo Dans
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Tmp75 sensor installation

On 09/24/2013 02:46 PM, Benjo Dans wrote:
> I have a Texas Instrument Tmp75 installed on the smbus (Intel LynxPoint PCH). I have installed the following drivers:
>
> i2c-i801.c (make and make install)
> lm75.ko (sudo insmod lm75.ko)
>
> I have ran "sensors" but it still cannot see my chip.  I have also installed your i2c-tools but when I run i2cdetect -l, it does not detect my smbus.  What drivers and/or files am I missing here?
>
Did you run modprobe i2c-i801 ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
