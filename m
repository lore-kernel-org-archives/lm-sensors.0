From: Darren Hart <dvhart@linux.intel.com>
Date: Fri, 15 Apr 2011 05:30:53 +0000
Subject: Re: [lm-sensors] w83795 fan control not working
Message-Id: <4DA7D80D.4080200@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110407150007.51dd1c06@endymion.delvare>
In-Reply-To: <20110407150007.51dd1c06@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



On 04/14/2011 10:04 PM, Darren Hart wrote:
> On 04/08/2011 05:46 AM, Jean Delvare wrote:
>> The bottom line is that using the W83795 driver in a multi-master I2C
>> setup (and I strongly suspect this is what Supermicro did) is a bad
>> hardware design mistake. This hardware monitoring device wasn't
>> designed with this use case in mind.
> 
> Super Micro responded:
> "
>         Do you have an extra fan blowing air toward the northbridge
> heatsink. The temperature on northbridage heatsink must less than 75
> degree. Adding an extra fan which will help solve your issue.
>         We are not recommend user using lmsensor on X8DTL-IF. It will
> cause system crash due to lmsensor and our IPMI program getting
> information from BIOS at the same time and collide on each other. It
> won't happen immediately but definitely will happen in random time.
> "
> 
> It's a bit broken, but it sounds like they are confirming you theory.
> 
> As an experiment I removed the CPU2 fan and pointed it directly at the
> Intel 5520 chipset (technically not a Northbridge as it turns out...
> just ignore that intel.com in my email address, it means nothing ;-) and
> while I haven't been able to measure the temp1 reading from the w83795
> driver since my return, the fans no longer ramp up to 4k rpm and the
> chip is cool to the touch.
> 
> I'm seeking the recommended solution from Super Micro, failing that,
> I'll have to resort to chassis modding.... I thought that was for the
> overclocking-acrylic-window-neon-lights crowd.... sigh.

This is turning into a support issue for Super Micro, but I thought I'd
post the following for completeness.

After trying a different kernel, I was able to get reading from the
w83795 again. I applied the fan to the chipset until it reached it's
lowest point (52.5C while idle). I then positioned the fan away from the
chipset and watched the temperature rise until it reached 84.5C and the
fans sped up to > 4000RPM.

FAN 1            | 2401.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 2            | 0.000      | RPM        | nr    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 3            | 2401.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 4            | 4356.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 5            | 3969.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000


Given that the system is idle, and Super Mictro stated the chipset
should not exceed 75C, and I have no obstructions in the case and no
expansion boards to add heat, something appears to be wrong.

Here is an annotated log of the experiment, one reading every 10 seconds:

dvhart@rage:~$ while true; do sensors w83795g-i2c-0-2f | grep temp1;
sleep 10; done
temp1:       +61.2°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +59.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +57.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +56.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +55.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +54.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +53.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +52.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +52.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +53.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +55.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +56.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +58.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +60.2°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +61.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +63.2°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +64.2°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +65.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +66.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +67.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +68.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +69.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +70.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +71.2°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +72.2°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +72.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +73.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +74.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +75.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +75.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +76.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +77.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +77.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +77.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +78.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +78.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +79.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +79.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +79.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +80.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +80.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +80.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +81.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +81.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +81.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +81.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +82.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +82.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +82.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +82.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +82.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +83.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +84.5°C  (high = +127.0°C, hyst = +127.0°C)

Fan speed jumped up at this point:

FAN 1            | 2401.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 2            | 0.000      | RPM        | nr    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 3            | 2401.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 4            | 4356.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000
FAN 5            | 3969.000   | RPM        | ok    | 400.000   | 576.000
  | 784.000   | 33856.000 | 34225.000 | 34596.000

And stayed at high speed until:

temp1:       +79.2°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +79.8°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +79.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +79.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +80.0°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +80.5°C  (high = +127.0°C, hyst = +127.0°C)
temp1:       +81.0°C  (high = +127.0°C, hyst = +127.0°C)

And sped up again here.
And so on.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
