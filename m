From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 22:16:02 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <4946D722.8080302@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Chuan-kai Lin wrote:
> On Mon, Dec 15, 2008 at 04:32:09PM +0100, Hans de Goede wrote:
>> I got your email address from Jean Delvare. I'm the f71882fg maintainer 
>> and I've been working on adding f8000 support to the f71882fg driver. 
>> That work is now finished.
> 
> Hi Hans,
> 
> Thank you for your great work!  The module builds and loads fine in
> 2.6.27.8 on my Dell Studio Slim 540s desktop computer, and sensors shows
> fan speed, voltage, and temperature measurements.  Very cool!!  I have
> attached two files showing the driver in action:
> 
> idle.txt - sysfs contents on an idle system right after bootup
> loaded.txt - sysfs contents + sensors output on a loaded system
> 
> Here are some issues I found:
> 
>  1. There are only two fans in my system.  The driver reports 0 RPM for
>     the third fan (which sounds right), and some absurdly high RPM for
>     the fourth fan (which sounds wrong).
> 

Okay, well the IC can measure up to 4 fans, so 4 will be reported, one can 
disable them in /etc/sensors.conf .

>  2. When the driver loads into the kernel, it reports that there are
>     three fans, and they are all in duty-cycle mode.  However, only the
>     CPU fan (fan2) uses a 4-pin connector; the case fan (fan1) uses a
>     3-pin connector.  I seem to recall that a fan on a 3-pin connector
>     can be controlled through only DC voltage?
> 

4 pins fans allow more accurate fan speed measurement when controlled with pwm, 
but 3 pin pans can be controlled with pwm too.


>  3. The full-speed number seems to record the maximum measured fan speed
>     instead of the maximum possible fan speed.
> 

So this gets updated by hardware? This is not mentioned anywhere in the dcos, 
but if that is the case that would be good!

>  4. I cannot change fan speed by altering tempX_auto_pointY_pwm values.
>     However, both the CPU fan and the case fan do speed up when the
>     system gets warm.

what does cat pwmX_enable give you, if it gives 3, the relevant pwm is in 
thermostat mode see the documentation I also attached.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
