From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Apr 2007 13:51:02 +0000
Subject: [lm-sensors] Proposal /sys/bus/class/hwmon/hwmon#/device/foo#_label
Message-Id: <4618F346.3000404@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

The abituguru3 driver, of which I've just submitted a second version for 
review, has a new feature / sysfs file, which I would like to discuss, before 
people think I'm trying to keep this new sysfs entry below the radar.

The abituguru3 has a register which contains a motherboard ID. The current 
driver uses this ID, to look up info about the motherboard in a somewhat lenght 
table in the driver. This is done this way because the uguru3 has 48 sensors, 
and the only way to know which one are actually connected and wether they are 
connected to voltage / temp / fan is by using this table. The added advantage 
of this is that since we know exactly on which motherboard the driver is 
running, additional stuff can be don. Like always correct values in mV / milli 
degress celcius / RPM at the sysfs level without libsensors needing todo any 
conversion. An other additional feature this enables, is telling userspace 
which voltage / temp / fan is actually being monitored. So the abituguru3 
driver has sysfs entries like:
/sys/class/hwmon/hwmon0/in0_label

Catting this file will result (depependend on motherboard) in for example:
CPU Core
being returned

I personally like this, as with proper userspace support this makes the end 
user experience pretty plug and play. so what do you think, good or bad?

Currently libsensors cannot handle this, but I don't think that is an argument 
either way.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
