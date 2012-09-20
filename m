From: Jack Kelly <jack-list@xlk.org.uk>
Date: Thu, 20 Sep 2012 00:19:13 +0000
Subject: [lm-sensors] CPU fan rapidly turns on and off
Message-Id: <CALHKqSXP=Qkeor_orw+Cu5B9jaBb9O6EHicZUp_OP2nWcJGLpg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear lm-sensors list,

Please may I ask for a bit of technical support (the problem I'm
experiencing may be the result of a bug but I'm not sure... it might
also be me being an idiot!)

I am using lm-sensors and coretemp on an HP ProBook 6450b laptop with
an Intel i5 quad-core CPU.  I'm running Ubuntu 12.04 with all the
latest updates:

$ uname -a
Linux probook 3.2.0-31-generic #50-Ubuntu SMP Fri Sep 7 16:16:45 UTC
2012 x86_64 x86_64 x86_64 GNU/Linux

The CPU fan is off when the system is idling.  When I stress the
system the fan starts running when the CPU gets to 105 degrees C
(which seems rather high but never mind...).  The problem is that the
system appears to be  failing to provide a constant current to the
fan.  Instead the fan is being turned on and off very rapidly which
results in a "clicking" noise which sounds a little like a hard disk
seeking.  I have manually measured the voltage supplied to the fan and
it does indeed turn on and off rapidly.

I wonder if this problem could be fixed by enabling a hysteresis
setting in coretemp?

This "clicking fan" problem does not occur if I run Windows7 or if I
boot Linux using apci=off.

Alternatively, is there a way for me to manually set the max and crit
temperatures for my CPU?  I've tried

sudo bash -c "echo 90000 > /sys/class/hwmon/hwmon1/device/temp2_max"

But I get a "permission denied" error.

I've also tried adding "set temp2_max 90000" to sensors3.conf but I
get a "Failed to set value" error.

Any help would be wonderful!

Many thanks,
Jack

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
