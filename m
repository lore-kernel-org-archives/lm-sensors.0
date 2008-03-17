From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Mar 2008 11:21:34 +0000
Subject: Re: [lm-sensors] W83627DHG driver on MSI 975x board
Message-Id: <20080317122134.2fc9e598@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1205271362.6571.9.camel@montecristo>
In-Reply-To: <1205271362.6571.9.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joakim,

On Mon, 17 Mar 2008 00:05:36 +0100, Joakim Larsson wrote:
> Hi Jean,
> 
> I got rid of all the Alarms now by tweaking the sensors3.conf
> 
> On Sun, 2008-03-16 at 10:53 +0100, Jean Delvare wrote:
> > > Case Fan:      0 RPM  (min =  376 RPM, div = 64)  ALARM
> > > CPU Fan:    2481 RPM  (min = 2109 RPM, div = 16)
> > > Aux Fan:    1298 RPM  (min =  439 RPM, div = 16)
> > > fan4:          0 RPM  (min = 8881 RPM, div = 4)  ALARM
> > > fan5:          0 RPM  (min = 10227 RPM, div = 4)  ALARM
> > 
> > I guess that you have only 2 fans in this system, so you can add:
> 
> There are three including the one in the power supply. The big case fan
> has a manual speed control that I have set to "low".

In most cases, the fan in the PSU is not connected to a motherboard fan
header and thus can neither be monitored nor controlled by the hardware
monitoring chip.

> > These are very reasonable fan speeds and I have to admit that I am
> > surprised the one the fans "sounds like your vacuum cleaner".
> 
> I have read about the motherboard that it has only speed control for the
> CPU fan but so far I have not been able to find the control i/o for it
> with pwmconfig (see output below), so I need to dig further.

Where did you read this? Different revisions of the same motherboard
may behave differently in this respect. On top of that, users don't
always realize the difference between thermo-regulated fans and fans
controlled by a hardware monitoring chip. That being said...

> Maybe I got a silent vacuum cleaner but there is a sustained/constant
> noise when the computer is heated up. When the Smart Fan is enabled in
> BIOS the computer is somewhat less noisy between 30 degrees and up with
> 2-3 distinctive steps in speeds for the CPU fan before it reaches
> cruising temperature.

... if your BIOS advertises a "Smart Fan" feature, your motherboard can
certainly control the fans. So I am very surprised that pwmconfig
didn't find any pwm/fan correlation. This could mean that the fan
speed control is done by ACPI, in which case you probably shouldn't use
the w83627ehf driver at all :( You can figure out by disassembling your
DSDT and looking for references to thermal zones (TZ), fans, etc.

> I will try to
> - upgrade BIOS (Need to boot into Window$!!!, Grrrr....)
> - set the silent chassi fan to mid or high to help CPU fan

I have done that on both my workstation and my home server and I
confirm that it helps a lot. Large case fans can lower the case
temperature significantly for almost no increase in noise level.

> - check air flows including heat pipe from CPU fan
> - turn off Smart Fan and try to get CPU fan control to work

I am really curious what this "Smart Fan" option does exactly (and
how), and trying without it is a good idea.

> 
> Do you know where to find info on how to set the target temp for the
> Smart Fan feature from Linux? I know there is no support in lm-sensors
> yet but it would be fun to try it out.

It really depends on how this "Smart Fan" feature is implemented. If it
is handled by the W83627DHG it's only a matter of writing the target
temperature value to some sysfs file under /sys/class/hwmon. If it's
handled by ACPI, older kernels would let you override the thermal trip
points, but this is no longer possible. If control is achieved by yet
another mean I can't even think of, I really can't help.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
