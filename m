From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 30 Mar 2015 07:25:21 +0000
Subject: Re: [lm-sensors] Report: fan control for IT8620E
Message-Id: <20150330092521.694e70bd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKkLDw6p8auatr7YNMM5aO0v=qA8bkXpznLPwbh0PBo8Z8dpiQ@mail.gmail.com>
In-Reply-To: <CAKkLDw6p8auatr7YNMM5aO0v=qA8bkXpznLPwbh0PBo8Z8dpiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dan,

On Thu, 19 Mar 2015 17:44:40 +0200, Dan Moinescu wrote:
> Here's a report on how I managed to control the CPU fan on a
> motherboard with the IT8620E chip, as suggested by the lm-sensors
> wiki: `you can try loading the it87 driver with force_id=0x8728 and
> see how it goes. If you do, please report, including the output of
> "sensors"`.
> 
> First, a quick word on the hardware used. The motherboard is a
> Gigabyte GA-B85M-DS3H
> (http://www.gigabyte.com/products/product-page.aspx?pidG31)  and the
> CPU cooler is an Arctic Cooling Alpine 11 Plus
> (http://www.arctic.ac/eu_en/alpine-11-plus.html)
> According to the cooler's technical data, the fan can run at speeds
> between 500 - 2,000 RPM. However, the BIOS/EFI/UEFI (whatever the
> proper name is nowadays) would not let me set the PWM value to less
> than 70, which produces a fan speed of about 1300 RPM (too noisy for
> my taste).
> So below is a description of what I did to bring the fan to minimum
> speed. This was done strictly by trial and error; I do not claim this
> is the only (or the best) method, it just works for me.
> 
> sensors-detect reported "Found unknown chip with ID 0x8620".
> I inserted the it87 module as directed by the wiki page:
> modprobe it87 force_id=0x8728
> After this I tried pwmconfig, but it didn't succeed in controlling the
> fan (it brought it up to full speed and left it in that state). So
> then I tried a manual approach.
> 
> Inserting the module creates a directory inside /sys, such as
> /sys/devices/platform/it87.2608/:
>     sysdir=$(find /sys/ -name it87.\* -type d)
> Controlling the fans is possible by modifying various files (mainly
> pwm1) inside that directory.
> 
> The first step is to modify the value inside pwm1_enable from 2 to 1.
> This is needed because if pwm1_enable is left at its initial value
> (2), pwm1 cannot be changed (attempting to do that produces a "Device
> or resource busy" error).
>     echo 1 > $sysdir/pwm1_enable

This is expected, mode 2 is an automatic (hardware-driven) fan control
mode so the pwm1 file is essentially read-only in that mode.

> Next the desired pwm value can be written into $sysdir/pwm1. Anything
> from 0-8 puts the fan at full speed, and 9 puts it to around 1600 RPM.
> Values from 10-255 seem to act as actual pwm values. Initial value was
> 70 (the value set in BIOS).
>     echo 10 > $sysdir/pwm1

Now that is weird and this is why pwmconfig got confused. The script
typically sets pwmN to 0 and checks if any fan speed wnet down. If
setting pwm1 to 0 puts the fan to full speed then the script
erroneously concluded that the pwm1 output did not control any fan.

We do not have a datasheet for this part (although Gigabyte offered to
provide some information about it) and from your results it's hard to
figure out how the register works. I would understand if values 0-127
do something and values 128-255 do something else (high bit has a
special meaning) or if odd values do something and even values do
something else (low bit has a special meaning) but your findings are
nothing like that.

> This set the fan speed to around 600 RPM, which was a lot better but
> still above minimum.

As a workaround we could prohibit values < 9 for pwmN attributes for
that chip. But it would of course be better if we can get a complete
description of the register so that we can support all the features
properly.

> It turned out that the speed can be reduced further by changing the
> value in the pwm1_freq file from the initial 46875 to a value less
> than 35157:
>     echo 35000 >$sysdir/pwm1_freq
> After this, the fan speed was reduced to about 470 RPM.

Yes, this is expected, the duty cycle frequency always has some impact
on the actual fan speed.

> Every time the system wakes up from sleep, all 3 files (pwm1_enable,
> pwm1, pwm1_freq) get restored to their initial values, so they need to
> be re-written.

The it87 kernel driver lacks support for suspend/resume, but that could
be added.

> In the absence of fancontrol functionality, I wrote a small script
> that presumably emulates fancontrol behaviour - it monitors the
> temperature output of "sensors" and sets the pwm1 value accordingly.

You should be able to use fancontrol even with the weird behavior you
described.

When pwmconfig tells you it did not find any correlation for pwm1,
it'll ask you if you heard the fan spin down. Claim you did and boldly
answer "y". That will let you configure pwm1.

Then during the configuration you will have the possibility to set
start, stop and minimum PWM values for the fan output. Say "9" for all
of them, to prevent fancontrol from ever writing a value 0-8 to the
pwm1 attribute.

After that fancontrol should just behave.

> Hope this helps.

Yes it does, thanks a lot for reporting your findings.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
