From: rafael.espindola@gmail.com (Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?=)
Date: Sat, 30 Jul 2005 21:52:37 +0000
Subject: [lm-sensors] pwm3_min_ctl or pwm3_auto_pwm_minctl
Message-Id: <200507301652.28356.rafael.espindola@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a MB with an emc6d102 and I want  to configure the automatic fan 
control. I was able to do so by altering the files in /sys, but wen I add (for 
example)
set pwm3_min_ctl 0

to /etc/sensors.conf and run sensors -s I get the following error:
emc6d102-i2c-0-2e: Can't access procfs/sysfs file for writing;
Run as root?

running strace I see that it is trying to 
open /sys/bus/i2c/devices/0-002e/pwm3_min_ctl. The correct name 
is /sys/bus/i2c/devices/0-002e/pwm3_auto_pwm_minctl.

I am running kernel 2.6.12 and lm-sensors 2.9.1-4 (debian).

I am doing something wrong? Does lm-sensors needs to be updated?

Thanks,
Rafael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050730/5ec39afb/attachment.bin
