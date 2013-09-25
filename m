From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Sep 2013 13:18:33 +0000
Subject: Re: [lm-sensors] Tmp75 sensor installation
Message-Id: <20130925151833.3d1aecb4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
In-Reply-To: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 Sep 2013 14:55:01 -0700, Guenter Roeck wrote:
> On 09/24/2013 02:46 PM, Benjo Dans wrote:
> > I have a Texas Instrument Tmp75 installed on the smbus (Intel LynxPoint PCH). I have installed the following drivers:
> >
> > i2c-i801.c (make and make install)
> > lm75.ko (sudo insmod lm75.ko)
> >
> > I have ran "sensors" but it still cannot see my chip.  I have also installed your i2c-tools but when I run i2cdetect -l, it does not detect my smbus.  What drivers and/or files am I missing here?
>
> Did you run modprobe i2c-i801 ?

Also worth checking:

* Is i2c-dev loaded? i2cdetect needs it.

* Errors in the kernel log after loading the i2c-i801 driver. For
  example ACPI resource conflicts could be a problem.

* Kernel version. The original LynxPoint PCH is only supported since
  kernel 3.4, for the LP flavor you need something even more recent. If
  you use my standalone version you should be fine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
