From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Sep 2012 17:32:59 +0000
Subject: Re: [lm-sensors] Some doubts with fancontrol
Message-Id: <20120902173259.GA10478@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <504241C4.30701@fastmail.fm>
In-Reply-To: <504241C4.30701@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 01, 2012 at 07:11:32PM +0200, Francesco Turco wrote:
> Hello.
> 
> I have a Lenovo Thinkpad R61 laptop and I'm trying to set up
> correctly fancontrol on it.
> 
> First of all, I loaded the thinkpad-acpi kernel module with the
> fan_control=1 option, otherwise the following steps don't work.
> 
> Then I ran pwmconfig in order to generate the /etc/fancontrol file.
> 
> Finally, I started fancontrol via "rc.d start fancontrol" (I'm
> running an Arch Linux system).
> 
> When idle, I get:
> - fan1: 2604 RPM
> - temp1: +40.0C
> 
> When busy, I get:
> - fan1: 3176 RPM
> - temp1: +65.0C
> 
> If now I stop fancontrol with "rc.d stop fancontrol" and wait some
> minutes, I get (system is stil busy):
> - fan1: 4993 RPM
> - temp1: +58.0C
> 
> That is, fan speed skyrocketed without any reason.
> 
When fancontrol is stopped, it configures manual mode and sets pwm to
the maximum.

> At http://www.kernel.org/doc/Documentation/laptops/thinkpad-acpi.txt
> I learned this is called "disengaged" mode, and it's not a safe mode
> to use. Let me quote:
> 
> > There is also a "full-speed" level, also known as "disengaged" level.
> In this level, the EC disables the speed-locked closed-loop fan control,
> and drives the fan as fast as it can go, which might exceed hardware
> limits, so use this level with caution.
> 
So, either don't stop fancontrol after you started it, restore original
settings manually after stopping it, or don't start it at all.

> I also noticed that while fancontrol is running, file
> /sys/class/hwmon/hwmon2/device/pwm1_enable is set to 1 (PWM manual),
> while when it quits that file is set to 0 (PWM disabled) instead of
> 2 (PWM automatic). Why?
> 
See above. It can not select 2, since values above 1 are driver and hardware
specific. fancontrol does not know about specific hardware and has to play it
safe. Which, again, is to select manual mode and the fastest available fan
speed.

> Beside this, I also tried manually setting PWM values in
> /sys/class/hwmon/hwmon2/device/pwm1, and I found that with values
> between 32 and 255 the fan runs, while with values between 0 and 31
> the fan stops completely. My question is: MINSTART/MINSTOP should be
> both 32 in my case?
> 
Isn't that what you have configured ?

> Last thing. It seems the only values you can save into
> /sys/class/hwmon/hwmon2/device/pwm1 are: 255, 218, 182, 145, 109,
> 72, 36 and 0. Other values get mapped to those previous values. Is
> this normal?
> 
Accepted values depend on the hardware and, of course, on the driver. Some
hardware only accepts specific values and/or ranges. From looking into the
driver, the thinkpad hardware only has 8 speed settings, which are
interpolated into (0, 255).

FWIW, the driver recommends using mode 2 (auto mode). That means you don't
really need fancontrol to start with. If supported, auto mode is preferred
since it works outside the OS: it will keep working even if the OS hangs.

So the real question here is why you try to use fancontrol to start with.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
