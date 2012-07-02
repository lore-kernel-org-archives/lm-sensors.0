From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 02 Jul 2012 15:02:45 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <20120702150245.GA12078@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 02, 2012 at 05:25:10AM +0200, Philipp Kraus wrote:
> On 2012-07-02 04:09:16 +0200, Guenter Roeck said:
> 
> >On Mon, Jul 02, 2012 at 03:28:19AM +0200, Philipp Kraus wrote:
> >>On 2012-07-02 03:14:03 +0200, Philipp Kraus said:
> >>
> >>>On 2012-06-30 21:24:59 +0200, Guenter Roeck said:
> >>>
> >>>>On Sat, Jun 30, 2012 at 07:27:49PM +0200, Philipp Kraus wrote:
> >>>>>On 2012-06-30 19:03:44 +0200, Guenter Roeck said:
> >>>>>
> >>>>>>On Sat, Jun 30, 2012 at 06:04:53PM +0200, Philipp Kraus wrote:
> >>>>>>>On 2012-06-30 17:33:38 +0200, Guenter Roeck said:
> >>>>>>>
> >>>>>>>>On Sat, Jun 30, 2012 at 04:37:28PM +0200, Philipp Kraus wrote:
> >>>>>>>>>
> >>>>>>>>>the grep command shows
> >>>>>>>>>grep: /sys/class/hwmon/hwmon1/device/driver: Is a directory
> >>>>>>>>>grep: /sys/class/hwmon/hwmon1/device/hwmon: Is a directory
> >>>>>>>>>grep: /sys/class/hwmon/hwmon1/device/power: Is a directory
> >>>>>>>>>grep: /sys/class/hwmon/hwmon1/device/subsystem: Is a directory
> >>>>>>>>>
> >>>>>>>>>and within the directory are the in*, pwm* temp* files
> >>>>>>>>>
> >>>>>>>>Not sure I understand.
> >>>>>>>>
> >>>>>>>>I'll need the names and output for the pwm* and temp* files. They
> >>>>>>>>_should_ be in
> >>>>>>>>/sys/class/hwmon/hwmon1/device/pwm* and /sys/class/hwmon/hwmon1/device/temp*.
> >>>>>>>
> >>>>>>>the command grep /sys.... does not work, I have run an ls -l and
> >>>>>>
> >>>>>>Phil,
> >>>>>>
> >>>>>>It wasn't "grep /sys/...", it was "grep . /sys/class/hwmon/hwmon1/device/*".
> >>>>>>The "." is important. Your output gives me the file names, but I need names and
> >>>>>>content, not names and permissions.
> >>>>>
> >>>>>Sorry, my mistake, I haven't seen that it ist "grep . <space> /sys..."
> >>>>>Hope this the correct output now
> >>>>>
> >>>>>/sys/class/hwmon/hwmon1/device/pwm1:252
> >>>>
> >>>>Looks like all pwm values report the "default" pwm value.
> >>>>
> >>>>>/sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm:1
> >>>>
> >>>>If I understand the code and the data sheet correectly, this attribute
> >>>>is a bit map used to map a temperature source to one or multiple fans.
> >>>>And it looks like all temperature sources are mapped to fan1, which
> >>>>in turn means that effectively temp4 controls the speed of fan1 (the highest
> >>>>temperature determines the fan speed), and all other fans are not mapped to
> >>>>a temperature input.
> >>>>
> >>>>What you should probably do is to find the association between tempX and pwmX
> >>>>and program tempX_auto_channels_pwm such that the two map.
> >>>>For example, if temp1
> >>>>is the CPU1 temperature, and pwm4 (fan4) is connected to the CPU1 fan, write
> >>>>0b00001000 = 0x08 into /sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm.
> >>>>Similar, if temp2 is the CPU2 temperature and fan5/pwm5 controls its fan,
> >>>>write 0x10 () into /sys/class/hwmon/hwmon1/device/temp2_auto_channels_pwm.
> >>>
> >>>You are write, temp1 and temp2 are the values for the CPU 1 and CPU 2.
> >>>The fans for the CPU
> >>>are fan7 = CPU 1 and fan8 = CPU 2
> >>>
> >>>Can you explane me in detail how you create the map 0b00001000 = 0x08 ?
> >>>I think 0x08 = 0x8 = 8 is a hexadecimal value but is this 0b00001000
> >>>also a hexadecimal value, in this case both values are not equal !?
> >>>Should I write with echo -e "\x8" >
> >>>/sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm ?
> >>>
> >>>IMHO I must enable (1) the n-th bit on the auto_channels_pwm value for
> >>>the n-th fan, so in my configuration the 7 and 8 bit (begin = 0)?
> >>
> >>I have set with
> >>echo 128 >  /sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm
> >>echo 256 >  /sys/class/hwmon/hwmon1/device/temp2_auto_channels_pwm
> >>
> >>the 7th and 8th fan-bit but nothing is changed
> >>
> >Does pwm7 and pwm8 still report 252 ? If so, we must be missing something.
> >
> >What do you get if you read back
> >/sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm and
> >/sys/class/hwmon/hwmon1/device/temp2_auto_channels_pwm ?
> 
> I can insert each value [0,255] and than I can get back the value with cat
> but after setting the value, the RPM are alway around 6000, no changes also.
> I have tested on temp1 each bit value, but also no changes
> 
> I have found a file /etc/fancontrol, but no process fancontrol, can
> be create this a problem?
> 
No, I don't think so.

Time to try manual fan control. Set
/sys/class/hwmon/hwmon1/device/temp[1-5]_auto_channels_pwm to 0, then set
pwm[1-8] directly to some value and see if it affects the fnn speed.

My concern right now is that temp6 (which does not seem to be enabled in your
system) may be configured to control all fans. If it is not connected, it may
report a super-high temperature, which in turn would result in the high fan
speeds. If the above does not work, this may be the case. If so, you may have
to try a patched driver. Is this possible ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
