From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 09 Jul 2007 12:42:22 +0000
Subject: [lm-sensors] PATCH: hwmon-fscher-support-fscpos.patch
Message-Id: <46922D2E.60400@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All, Stefan,

As already mentioned in various post to the lm-sensors mailing list, the fscher
and fscpos chip are very very similar, this patch adds support for the fscpos
chip to the fscher driver, so that over time the fscpos driver can be dropped.

Notice that this patch applies on top of the earlier posted max alarms patch 
for the fscher:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020301.html

Stefan, Jean told me that you ported the fscpos driver from 2.4 to 2.6, kan you 
test if the fscher driver with this patch will also work correctly on your 
fscpos machine (according to the datasheets it should).

I would like to ask you specifically to test the tempX_max attributes, try 
something like:
cat /sys/class/hwmon/hwmon0/device/temp1_max
That should give you a reasonable max temperature, on my machine it defaults to 
77. This needs testing as I reverse engineered the tempX_max registers on my 
machine and I hope they are identically on yours. We need them to be able to 
reset the temp alarms once the alarm condition is cleared, as the chip doesn't 
do this itself.

If the temp1_max look ok try:
sudo su -c "echo -n 22000 > /sys/class/hwmon/hwmon0/device/temp1_max"

And then wait 5 seconds and:
cat /sys/class/hwmon/hwmon0/device/temp1_alarm

It should be 1 now. Now put temp1_max back:
sudo su -c "echo -n 77000 > /sys/class/hwmon/hwmon0/device/temp1_max"

wait 2 seconds and then:
cat /sys/class/hwmon/hwmon0/device/temp1_alarm

This time is should still be one, but the read should have cleared the alarm, 
so again:
cat /sys/class/hwmon/hwmon0/device/temp1_alarm

It should be 0 now.

Many thanks for testing!

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
