From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Tue, 25 Oct 2005 00:47:46 +0000
Subject: [lm-sensors] Support for SMSC 47M15x/192
Message-Id: <200510250046.42719.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510162303.21468.pavouk@pavouk.org>
In-Reply-To: <200510162303.21468.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> It is expected due to the hardware implementation. The lowest speed that
> can be monitored (and thus the lowest limit you can set) depends on an
> internal clock speed and a clock divider. For a divider of 8, this is
> (32768*60)/(2*8*192) = 640. For lower dividers, the value is even
> greater.

Thanks for good explaining.

> > smsc47m1-isa-0800
> > Adapter: ISA adapter
> > fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
> > fan2:     1050 RPM  (min = 1280 RPM, div = 4)          ALARM
>
> This is more surprising, as the driver should try to preserve the low
> limit on divider increment. Unless you actually did it the other way
> around (4 then 1)? I took a look at the code and it looks correct to me.
>
> Anyway, you can set the value again by writing it to fan2_min.

Other experiment:
-----
[root@home 1-0800]# echo 4 >fan2_div
fan2:     1041 RPM  (min = 1280 RPM, div = 4)          ALARM
[root@home 1-0800]# echo 1 >fan2_div
fan2:        0 RPM  (min = 5120 RPM, div = 1)          ALARM
[root@home 1-0800]# echo 4 >fan2_div
fan2:        0 RPM  (min = 5120 RPM, div = 4)          ALARM
[root@home 1-0800]# echo 8 >fan2_div
fan2:        0 RPM  (min = 5120 RPM, div = 8)          ALARM
[root@home 1-0800]# echo 640 >fan2_min
fan2:     1059 RPM  (min =  640 RPM, div = 8)          ALARM
-----

>
> That's expected, as libsensors doesn't know about fan speed control
> except for a few chips. Typically, PWM operations are done directly
> through sysfs. Check in /sys/bus/i2c/devices, you should find a
> directory for your chip and pwm files here. Use with caution, of course.

Yes, it works perfectly!

I can set values 1 to 252 for pwm.
With echo 0 >pwm2_enable my secondary fan totally stops.

There is some experiments:
-------------
[root@home 1-0800]# pwd
/sys/bus/i2c/devices/1-0800
[root@home 1-0800]# cat pwm2
144
[root@home 1-0800]# echo 10 >pwm2
fan2:     3072 RPM  (min =  640 RPM, div = 8)
[root@home 1-0800]# cat pwm2
8
[root@home 1-0800]# echo 128 >pwm2
fan2:     1307 RPM  (min =  640 RPM, div = 8)
[root@home 1-0800]# cat pwm2_enable
1
[root@home 1-0800]# echo 0 >pwm2_enable
fan2:        0 RPM  (min =  640 RPM, div = 8)          ALARM
[root@home 1-0800]# echo 1 >pwm2_enable
fan2:     1307 RPM  (min =  640 RPM, div = 8)
--------------

> Anyway, the tests above are sufficient to convince me that your chip is
> compatible with the LPC47M192 as fan as fan control and monitoring is
> concerned. We will have to update our documentation accordingly.

Thank you very much.

Best regards,

Pavel Ruzicka
