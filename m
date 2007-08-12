From: Sebastian Flothow <lists@flothow.de>
Date: Sun, 12 Aug 2007 17:55:43 +0000
Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2 - mostly working
Message-Id: <02405b0feff67158070a75eb516e6b70@flothow.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
In-Reply-To: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 12. Aug 2007 um 00:43 Uhr schrieb Sebastian Flothow:
> Am 12. Aug 2007 um 00:19 Uhr schrieb George Joseph ((dev)):
>> Try ...
>> http://www.peakin.com/download/asc76xx-2.6.22.2.patch
>
> Does compile against 2.6.16.52-xen, with hwmon debugging turned on.
> I'll boot it tomorrow.

Works, debug messages appear in dmesg, and PECI is enabled by default. 
Nice.

I took a closer look at the PWM stuff this time and found it's behaving 
a bit weird.

Setting pwm?_enable to 0 should cause the fan to run at full speed, 
right? This is not really clear in Documentation/hwmon/sysfs-interface, 
though.
When setting pwm[12]_enable to 0, I can't observe any effect at all; 
setting pwm3_enable to 0 causes the fans 3 and 4 to stop.

With pwm?_enable set to 1 (manual), it seems that 51 is the effective 
minimum for pwm1 - I can set it to lower values, and read them back, 
but the fan won't get any slower than at 51. For pwm2 and pwm3, this 
limit is 76. Why is this?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
