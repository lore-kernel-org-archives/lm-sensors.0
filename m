From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Sep 2012 07:36:48 +0000
Subject: Re: [lm-sensors] Some doubts with fancontrol
Message-Id: <20120903093648.01f08ca8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <504241C4.30701@fastmail.fm>
In-Reply-To: <504241C4.30701@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Adding Henrique to Cc.

On Sun, 2 Sep 2012 10:32:59 -0700, Guenter Roeck wrote:
> On Sat, Sep 01, 2012 at 07:11:32PM +0200, Francesco Turco wrote:
> > Hello.
> > 
> > I have a Lenovo Thinkpad R61 laptop and I'm trying to set up
> > correctly fancontrol on it.
> > 
> > First of all, I loaded the thinkpad-acpi kernel module with the
> > fan_control=1 option, otherwise the following steps don't work.
> > 
> > Then I ran pwmconfig in order to generate the /etc/fancontrol file.
> > 
> > Finally, I started fancontrol via "rc.d start fancontrol" (I'm
> > running an Arch Linux system).
> > 
> > When idle, I get:
> > - fan1: 2604 RPM
> > - temp1: +40.0C
> > 
> > When busy, I get:
> > - fan1: 3176 RPM
> > - temp1: +65.0C
> > 
> > If now I stop fancontrol with "rc.d stop fancontrol" and wait some
> > minutes, I get (system is stil busy):
> > - fan1: 4993 RPM
> > - temp1: +58.0C
> > 
> > That is, fan speed skyrocketed without any reason.
>
> When fancontrol is stopped, it configures manual mode and sets pwm to
> the maximum.

Not really. If supported by the hardware, it disables PWM control
completely (pwmN_enable=0), which in turn results info the fan spinning
at full speed. For most hardware it is implemented differently (more
efficiently) than pwmN_enable=1, pwmN%5 which you were describing,
but the resulting fan speed is roughly the same. It will fallback to
pwmN_enable=1, pwmN%5 if it has too, though.

The thinkpad_acpi driver is an exception here, as pwm1_enable=0 results
in a much higher speed. This behavior is quite questionable, especially
given the documentation warnings about disengaged mode. It might be
better (as in "safer and less surprising") to not support pwm1_enable=0
at all, and only let the user switch to disengaged mode
through /proc/acpi/ibm/fan. Henrique?

(Alternatively, pwm1_enable=0 could only be supported if the driver is
loaded with fan_control=2.)

> > At http://www.kernel.org/doc/Documentation/laptops/thinkpad-acpi.txt
> > I learned this is called "disengaged" mode, and it's not a safe mode
> > to use. Let me quote:
> > 
> > There is also a "full-speed" level, also known as "disengaged" level.
> > In this level, the EC disables the speed-locked closed-loop fan control,
> > and drives the fan as fast as it can go, which might exceed hardware
> > limits, so use this level with caution.
>
> So, either don't stop fancontrol after you started it, restore original
> settings manually after stopping it, or don't start it at all.

That's a little harsh of a reply IMHO. As a general rule, stopping a
service should do its best to restore the system to its state previous
to said service being started. Failing to do so will legitimately
surprise the user. I don't think we're doing that (see proposal below.)

> > I also noticed that while fancontrol is running, file
> > /sys/class/hwmon/hwmon2/device/pwm1_enable is set to 1 (PWM manual),
> > while when it quits that file is set to 0 (PWM disabled) instead of
> > 2 (PWM automatic). Why?
>
> See above. It can not select 2, since values above 1 are driver and hardware
> specific. fancontrol does not know about specific hardware and has to play it
> safe. Which, again, is to select manual mode and the fastest available fan
> speed.

That's indeed the logic behind the current implementation. That being
said, while the fancontrol script cannot switch to pwmN_enable=2
unconditionally, we could make it remember the pwmN_enable values when
it starts, and restore these values at exit if they are 2 or above.
Guenter, what do you think?

> > Beside this, I also tried manually setting PWM values in
> > /sys/class/hwmon/hwmon2/device/pwm1, and I found that with values
> > between 32 and 255 the fan runs, while with values between 0 and 31
> > the fan stops completely. My question is: MINSTART/MINSTOP should be
> > both 32 in my case?

MINSTOP2 is correct. MINSTART depends if the fan can kick in from
still with value 32. But given that pwm1_enable=1 isn't a true manual
mode for thinkpad_acpi, I susppose the EC takes care of this for you so
MINSTART2 should be OK too. Anyway, the pwmconfig scripts lets you
test these values, so just do that if you aren't sure.

> Isn't that what you have configured ?
> 
> > Last thing. It seems the only values you can save into
> > /sys/class/hwmon/hwmon2/device/pwm1 are: 255, 218, 182, 145, 109,
> > 72, 36 and 0. Other values get mapped to those previous values. Is
> > this normal?
>
> Accepted values depend on the hardware and, of course, on the driver. Some
> hardware only accepts specific values and/or ranges. From looking into the
> driver, the thinkpad hardware only has 8 speed settings, which are
> interpolated into (0, 255).
> 
> FWIW, the driver recommends using mode 2 (auto mode). That means you don't
> really need fancontrol to start with. If supported, auto mode is preferred
> since it works outside the OS: it will keep working even if the OS hangs.
> 
> So the real question here is why you try to use fancontrol to start with.

These were my thoughts exactly. There's no good reason for touching
these settings in general. If your Thinkpad gets noisy, best is to
disassemble it (IBM/Lenovo has wonderful hardware maintenance manuals
for all their laptop lines AFAIK) and remove all the dust inside. I did
that once with two different models, with good results.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
