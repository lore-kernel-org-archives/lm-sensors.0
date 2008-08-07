From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 07 Aug 2008 20:56:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add a driver for the ADT7475
Message-Id: <489B617B.9040801@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080610194818.GA21150@cosmic.amd.com>
In-Reply-To: <20080610194818.GA21150@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jordan Crouse wrote:
> Hi Mark -
> 
> Attached is a patch for the ADT7475 that has been bouncing around on
> the list for some time now.  It is suitable for the testing
> GIT tree, and I think it is a good candidate for the 2.6.26 push.
> 

Hi,

Very sorry for the long silence, it seems all of us involved in the hwmon tree 
have a bit too much on our plate. As can be witnessed from Mark Hoffman 
stepping down as hwmon subsys maintainer.

Anyways I've started reviewing your driver, but I haven't come around to 
reviewing the actual code. Thanks for writting good documentation :) As I now 
already have found quite a few cases where your driver deviates from the 
standard sysfs interface as documented in:
Documentation/hwmon/sysfs-interface

So in this initial review I'll only comment on your:
Documentation/hwmon/adt7475

And I kindly ask you todo a revised version of your driver fixing the interface 
deviations I believe to be present. When thats done I'll do a full review and I 
promise I'll be a lot quicker this time around (and when I promise something, 
you can expect it to happen!).


+This describes the interface for the ADT7475 driver:
+
+(there are 4 fans, numbered fan1 to fan4):
+
+fanX_input              Read the current speed of the fan (in RPMs)
+fanX_min                Read/write the minimum speed of the fan.  Dropping
+	   		below this sets an alarm.
+
+(there are three PWMs, numbered pwm1 to pwm3):
+
+pwmX                    Read/write the current duty cycle of the PWM.  Writes
+     			only have effect when auto mode is turned off (see
+			below).
+

Good, I assume (not looked at the code yet) this goes from 0 - 255 ? If not it 
should and that should be scaled to whatever the IC wants.

+pwmX_enable             Read/write the PWM configuration based on the following
+                        table:
+
+		        0 - Remote1 temp controls PWMx (auto mode)
+		        1 - local temp controls PWMx (auto mode)
+	 	        2 - remote2 temp controls PWMx (auto mode)
+                        3 - PWMx runs at full speed
+                        4 - PWMx is disabled
+                        5 - Use fastest speed calculated by local and remote2
+                        6 - Use fastest speed calculated by all three channels
+                        7 - Manual mode
+

Erm, this is somewhat non standard, atleast 0 and 1 have a well defined meaning 
in the sysfs-interface standard:

"pwm[1-*]_enable
                 Fan speed control method:
                 0: no fan speed control (i.e. fan at full speed)
                 1: manual fan speed control enabled (using pwm[1-*])
                 2+: automatic fan speed control enabled
                 Check individual chip documentation files for automatic mode
                 details."

Actually reading the datasheet, I think this is not what we want, what we want 
pwmX_enable to be for the adt7475 is:

0: No fan speed control (fan at full speed, iow 3 in your old table)
1: Manual fan speed control (7 in your old table)
2: Automatic fan speed control (0-2, 5-6 in your old table, see below for
    which one should be used when).

And then add a pwmX_auto_channels_temp atrribute to control which temp 
sensor(s) influence the pwm, quoting our sysfs standard doc again:

"pwm[1-*]_auto_channels_temp
                 Select which temperature channels affect this PWM output in
                 auto mode. Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
                 Which values are possible depend on the chip used.
                 RW"

So that would mean that valid values for the adt7475 are, with corresponding 
number in your old table:
1 -> 0 (I assume remote1 is temp1, local temp2 and remote2 temp3)
2 -> 1
4 -> 2
6 -> 5
7 -> 6

Note that 4 from your old table is not used, we don't want people to be able to 
  turn of the pwm (and thus the fan) through pwm_enable _ever_. If they really 
want todo something that stupid they should configure manual mode and write a 
duty cycle of 0 %.


+pwmX_freq               Read/write the PWM frequency.  The value returned is
+	  	        an index into the following table:
+
+		        0x0 - 11.0 Hz
+		        0x1 - 14.7 Hz
+		        0x2 - 22.1 Hz
+		        0x3 - 29.4 Hz
+		        0x4 - 35.3 Hz
+		        0x5 - 44.1 Hz
+		        0x6 - 58.8 Hz
+		        0x7 - 88.2 Hz
+

That table should be in the driver and userspace should read/write a value in 
Hz, to quote the docs:

"pwm[1-*]_freq   Base PWM frequency in Hz.
                 Only possibly available when pwmN_mode is PWM, but not always
                 present even then.
                 RW"



+pwmX_max                Read/write the maximum PWM duty cycle.  The PWM
+                        duty cycle will never exceed this.
+
+pwmX_min                Read/write the minimum PWM duty cycle in automatic mode
+

Good (but again 0 - 255 scale please).

+(there are three temperature settings numbered temp1 to temp3):
+
+tempX_input             Read the current temperature.  The value is in milli
+			degrees of Celsius.
+
+tempX_max               Read/write the upper temperature limit - exceeding this
+	                will cause an alarm.
+
+tempX_min               Read/write the lower temperature limit - exceeding this
+                        will cause an alarm.
+
+tempX_offset            Read/write the temperature adjustment offset
+

I assume this are all milli degrees too? If not they should be.

+tempX_crit_max        Read/write the THERM limit for remote1.  Exceeding this
+                        causes the chip to force the processor off.
+

The standardized name for this is tempX_crit, and drop the force the processor 
off language, that really depends on how the IC is hooked up on the motherboard 
and thus isn't always true.

+tempX_auto_min   	Read/write the minimum temperature where the fans will
+                        turn on in automatic mode.
+
+tempX_auto_range  	Read/write the range over which the automatic fan
+			control will be executed.  The value returned is a
+			index into the following table:
+
+			0x0 - 2 C
+			0x1 - 2.5 C
+			0x2 - 3.33 C
+			0x3 - 4 C
+			0x4 - 5 C
+			0x5 - 6.67 C
+			0x6 - 8 C
+			0x7 - 10 C
+			0x8 - 13.33 C
+			0x9 - 16 C
+			0xA - 20 C
+			0xB - 26.67 C
+			0xC - 32 C
+			0xD - 40 C
+			0xE - 53.33 C
+			0xF - 80 C
+

Please rename tempX_auto_min to

tempX_auto_point1_temp

And rename tempX_auto_range to tempX_auto_point2_temp and when 
tempX_auto_point2_temp gets read show tempX_auto_point1_temp + the range value 
looked up in the above table (in milli degrees please) and vica versa when 
tempX_auto_point2_temp gets written.

+tempX_crit_hyst 	set the temperature range below crit_max where the
+                        fans will stay on - this helps drive the temperature
+                        low enough so it doesn't stay near the edge and
+                        cause THERM to keep tripping.
+

Good, but note that this should not be an offset, but an absolute value so when
temp1_crit is for example 100000 and the temp must drop more then 10 degrees 
before the crit alarm gets cleared, then reading temp1_crit_hyst should return 
90000.

+tempX_alarm		Read a 1 if the max/min alarm is set
+tempX_crit_alarm	Read a 1 if the critical limit is exceeded
+tempX_fault		Read a 1 if either temp1 or temp3 diode has a fault
+

All good.

+(There are two voltage settings, in1 and in2):
+
+inX_input               Read the current voltage on VCC.  Value is in
+			millivolts.
+
+inX_min                 read/write the minimum voltage limit.
+			Dropping below this causes an alarm.
+
+inX_max   		read/write the maximum voltage limit.
+			Exceeding this causes an alarm.
+
+inX_alarm		Read a 1 if the max/min alarm is set.

Also all good.


Again, apologies for being so slow, esp since all I've done now is take a look 
at the API and not even at the code :(

I'll be leaving tomorrow morning for a week vacation. I hope you will have been 
able todo a new revision fixing all the API remarks I've made and then I'll do 
a full review real soon!

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
