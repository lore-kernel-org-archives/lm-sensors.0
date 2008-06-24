From: Frank Myhr <fmyhr@fhmtech.com>
Date: Tue, 24 Jun 2008 03:06:29 +0000
Subject: [lm-sensors] sysfs-interface: pwm [0-100] rather than [0-255] ?
Message-Id: <486064B5.5070704@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've added automatic pwm control to the it87.c driver and it's working
on my Gigabyte GA-MA770-DS3 motherboard with it8718f chip. I plan to
contribute the modified driver, but need to do significant cleanup and
logical patch-splitting before it's in a fit state to submit.
In my naivete I didn't read sysfs-interface until I'd already rolled
my own non-conforming interface for it87. My bad, my pain as I fix that.
I do have a comment, though:

For pwm[1-*], it seems to me to make better sense to use a range
[0, 100] ("% duty cycle"), rather than the current 8-bit range [0, 255].

Points in favor of using range [0, 100] "% duty cycle" for pwm[1-*]:

1) Consistency: other hwmon sysfs attributes that correspond to
physical quantities (temp[1-*], fan[1-*], etc.) are in physical units.

2) Freedom from chip implementation: 0-100% duty cycle remains
the same regardless of whether specific chip uses 6,7,8 or whatever
bits to represent it.

3) Meaningful value: natural for user to think in terms of 0-100% duty
cycle, rather than "255 means 100%... 60% would be... (pulls out calculator)"

Of course I remain naive, and so have some questions:

a) Is there any possibility of changing pwm[1-*] to use range [0, 100] ?*

b) If backward compatibility with [0, 255] range must be preserved,
would it be acceptable to make available an additional redundant
attribute, named something like pwm[1-*]_duty that would have range [0, 100] ?*

c) Is your [dog / cat / fish / fill in the blank] less naive than I am? :-)

*Note that the following attributes would also be affected:
pwm[1-*]_auto_point[1-*]_pwm
temp[1-*]_auto_point[1-*]_pwm

Thanks,
Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
