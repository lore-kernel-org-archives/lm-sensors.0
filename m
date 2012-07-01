From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Jul 2012 00:24:32 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <20120701002432.GA21694@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 01, 2012 at 02:06:27AM +0200, Philipp Kraus wrote:
> On 2012-06-30 21:24:59 +0200, Guenter Roeck said:
> 
> >On Sat, Jun 30, 2012 at 07:27:49PM +0200, Philipp Kraus wrote:
> >>On 2012-06-30 19:03:44 +0200, Guenter Roeck said:
> >>
> >>>On Sat, Jun 30, 2012 at 06:04:53PM +0200, Philipp Kraus wrote:
> >>>>On 2012-06-30 17:33:38 +0200, Guenter Roeck said:
> >>>>
> >>>>>On Sat, Jun 30, 2012 at 04:37:28PM +0200, Philipp Kraus wrote:
> >>>>>>
> >>>>>>the grep command shows
> >>>>>>grep: /sys/class/hwmon/hwmon1/device/driver: Is a directory
> >>>>>>grep: /sys/class/hwmon/hwmon1/device/hwmon: Is a directory
> >>>>>>grep: /sys/class/hwmon/hwmon1/device/power: Is a directory
> >>>>>>grep: /sys/class/hwmon/hwmon1/device/subsystem: Is a directory
> >>>>>>
> >>>>>>and within the directory are the in*, pwm* temp* files
> >>>>>>
> >>>>>Not sure I understand.
> >>>>>
> >>>>>I'll need the names and output for the pwm* and temp* files. They
> >>>>>_should_ be in
> >>>>>/sys/class/hwmon/hwmon1/device/pwm* and /sys/class/hwmon/hwmon1/device/temp*.
> >>>>
> >>>>the command grep /sys.... does not work, I have run an ls -l and
> >>>
> >>>Phil,
> >>>
> >>>It wasn't "grep /sys/...", it was "grep . /sys/class/hwmon/hwmon1/device/*".
> >>>The "." is important. Your output gives me the file names, but I need names and
> >>>content, not names and permissions.
> >>
> >>Sorry, my mistake, I haven't seen that it ist "grep . <space> /sys..."
> >>Hope this the correct output now
> >>
> >>/sys/class/hwmon/hwmon1/device/pwm1:252
> >
> >Looks like all pwm values report the "default" pwm value.
> >
> >>/sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm:1
> >
> >If I understand the code and the data sheet correectly, this attribute
> >is a bit map used to map a temperature source to one or multiple fans.
> >And it looks like all temperature sources are mapped to fan1, which
> >in turn means that effectively temp4 controls the speed of fan1 (the highest
> >temperature determines the fan speed), and all other fans are not mapped to
> >a temperature input.
> >
> >What you should probably do is to find the association between tempX and pwmX
> >and program tempX_auto_channels_pwm such that the two map. For
> >example, if temp1
> >is the CPU1 temperature, and pwm4 (fan4) is connected to the CPU1 fan, write
> >0b00001000 = 0x08 into /sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm.
> >Similar, if temp2 is the CPU2 temperature and fan5/pwm5 controls its fan,
> >write 0x10 () into /sys/class/hwmon/hwmon1/device/temp2_auto_channels_pwm.
> 
> Okay, I will test in the next days and write a report to thisl ist.
> But why fails this mapping?
> I think if I get a correct order, I must past the values on each
> boot into the hwmon files
> with a little script.
> 
Yes, that will be necessary, unless you can somehow configure it in the BIOS.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
