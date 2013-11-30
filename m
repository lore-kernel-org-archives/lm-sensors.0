From: Brian Carnes <bmcarnes@gmail.com>
Date: Sat, 30 Nov 2013 07:57:49 +0000
Subject: [lm-sensors] w83l786ng driver bug, questions, and 1st round patch
Message-Id: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Below is a description of two problems, some questions about how best
to resolve them, a transcript showing the behaviour, a minimal patch that
fixes just the first problem, and a transcript showing the improved
behaviour.

Problem #1:
There is a bug preventing setting the mode of the w83l786ng fan control.
sysfs will forever report mode 1.
The driver can do a one-way set of the hardware to mode 2, even though
that will never be reflected in sysfs.
It is then impossible to set hardware back to mode 1 via the driver.

Problem #2:
The "enable" and "mode" sysfs files are hooked up to the bitfields backward.
Do we want to fix this?
I'd worry about backward-compatibility, except that the current driver does
not
work with fan-control outside of mode 1, so perhaps there are no users of
the
advanced modes or PWM/DC switch, and thus no backward-compatibility
to break?  Although some people may have figured out the reversal, and
count on
setting pwmX_mode -> 0 to turn off PWM enable and drive the fan in DC mode?

While I'm submitting a patch to fix #1 and perhaps next for #2, are there
any
other updates or conventions to follow to normalize this driver against the
rest?
Perhaps:
  a) make the mode 0-based (0,1,2,3) instead of (1,2,forbidden,forbidden)
  b) make the mode named? (manual, cruise, smart, set)
  c) have the fan control naming convention not tied to 'pwm'
     (the chip supports pwm and DC modes.  I'm actually using it in DC mode)

In my own source tree, I've got a quick'n'dirty version exposing the duty
cycles and temp limits for thermal cruise and smart fan modes, permitting
modes 3 and 4, and supporting configurable voltage scaling.

Let me know your thoughts on problems #1 and #2 and naming conventions.
If the additional modes and functionality are desired, I can clean that up
and submit it, once the first round of questions and conventions are
settled.

Transcript:

# The original author is using pwmX_enable to control the FANx_MODE
#  fields, in bits 2-3, and 4-5 of register 0x80
# And is using pwmX_mode to control the EN_PWMx fields, in
#  bits 6, and 7.
# The naming is backwards, but there is also a bug after coping
#  with the reversal.
# Consider the following:

$ cat pwm1_enable pwm2_enable
1
1
$ i2cget -f -y 0 0x2e 0x80
0x00

# Everything is consistent so far.  The original author's comments in the
# code state that he allows the first two 'modes' in pwmX_enable, 1 and 2.
# His sysfs reflection of them are 1-based, so:
# bits 2-3 = 0b00 -> pwm1_enable = 0 (+1) = 1
# bits 4-5 = 0b00 -> pwm2_enable = 0 (+1) = 1
# and he is intentionally restricting us from modes 3 and 4.  Now:

$ echo 1 > pwm1_enable
$ cat pwm1_enable pwm2_enable
1
1
$ i2cget -f -y 0 0x2e 0x80
0x00

# Everything's still OK.  He's mapping his 1-based mode into the
# register correctly.  But now:

$ echo 2 > pwm1_enable
$ cat pwm1_enable pwm2_enable
1
1
$ i2cget -f -y 0 0x2e 0x80
0x04

# The bit got set - hardware is now in "mode 2" (thermal cruise)
# But the sysfs file still says we're in mode 1
# Let's try to go back:

$ echo 1 > pwm1_enable
$ cat pwm1_enable pwm2_enable
1
1
$ i2cget -f -y 0 0x2e 0x80
0x04

# Nope, we're now forever stuck in mode 2 on the hardware, but
# sysfs will forever say we're in mode 1.

# Note the power up default is actually mode 4, which is even more
# confusing (sysfs would tell you we're in mode 3, until you first
# touch the mode, then it would lock back into mode 1 behavior.
# For the above I made things less confusing for the reader by
# first forcing mode 1.)

A copy of the datasheet can be found at:

http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/CloudAndComputingIC/HardwareMonitor/HWMonitorforGraphicCardNBAndIA/Documents/W83L786NG_W83L786NR.pdf

The pertinent section is:
   8.23 Fan Control Register - Index 80h, on page 30.

Possibly related mailing list reference to w83l786ng problems:
  http://marc.info/?l=lm-sensors&m6974114501850

Patch addressing just problem #1:
--- a/w83l786ng.c
+++ b/w83l786ng.c
@@ -523,7 +523,7 @@ store_pwm_enable(struct device *dev, struct
device_attribute *attr,
        mutex_lock(&data->update_lock);
        reg = w83l786ng_read_value(client, W83L786NG_REG_FAN_CFG);
        data->pwm_enable[nr] = val;
-       reg &= ~(0x02 << W83L786NG_PWM_ENABLE_SHIFT[nr]);
+       reg &= ~(0x03 << W83L786NG_PWM_ENABLE_SHIFT[nr]);
        reg |= (val - 1) << W83L786NG_PWM_ENABLE_SHIFT[nr];
        w83l786ng_write_value(client, W83L786NG_REG_FAN_CFG, reg);
        mutex_unlock(&data->update_lock);
@@ -790,7 +790,7 @@ static struct w83l786ng_data
*w83l786ng_update_device(struct device *dev)
                            ((pwmcfg >> W83L786NG_PWM_MODE_SHIFT[i]) & 1)
                            ? 0 : 1;
                        data->pwm_enable[i] -                           ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 2)
+ 1;
+                           ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 3)
+ 1;
                        data->pwm[i] = w83l786ng_read_value(client,
                            W83L786NG_REG_PWM[i]);
                }
-----PATCH END-----

In short:
chunk 1 used to clear just bit 2 (so no modes 3 or 4), then always OR in
bit 1.
  Once set, no going back!  Now we clear both bits, and then OR in the mode.
chunk 2 used to always request bit 2 (which this driver always set to zero),
  and add one.  Thus you always appeared to be in "mode 1", unless the
hardware
  was in mode 3 or 4 by means other than the driver, then you would
  appear to be in mode 3...
  Now the driver will correctly report the mode (1, 2, 3, or 4).

Transcript after loading patched module:

$ sudo rmmod w83l786ng
$ sudo insmod ./w83l786ng.ko
$ cat pwm1_enable pwm2_enable
1
1
$ i2cget -f -y 0 0x2e 0x80
0x00
$ echo 1 > pwm1_enable
$ cat pwm1_enable pwm2_enable
1
1
$ i2cget -f -y 0 0x2e 0x80
0x00
$ echo 2 > pwm1_enable
$ cat pwm1_enable pwm2_enable
2
1
$ i2cget -f -y 0 0x2e 0x80
0x04
$ echo 1 > pwm1_enable
$ cat pwm1_enable pwm2_enable
1
1
$ i2cget -f -y 0 0x2e 0x80
0x00

Which is the expected behaviour.

Regards,

  Brian
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
