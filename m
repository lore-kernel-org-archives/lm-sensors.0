From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Jun 2006 21:17:55 +0000
Subject: [lm-sensors] ACPI temperature in libsensors
Message-Id: <20060606231755.a6e528b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Last saturday I played a bit with libsensors. My idea was to integrate
the hardware monitoring data which is available from ACPI
(/proc/acpi/{thermal_zone,fan}). There are many reason why I think this
would be valuable:

* User space applications would no more have to handle the ACPI side of
things on their own.

* Many recent systems (especially laptops) only have ACPI to report
system temperature, and people complain that lm_sensors doesn't work
for them. This would make sensors display some minimal information and
hopefully make them happy.

* There are more and more reports of systems where i2c or hwmon drivers
conflict with ACPI. If libsensors supports the ACPI interface, we'll
see the ACPI stuff immediately when people report their sensors output,
and this will help us spot potential conflicts.

Now, the problem is that the ACPI interface was never meant to be
integrated into libsensors. It uses procfs, and in a human-oriented
way, so I had to parse the files. Additionally, ACPI has no concept of
chips, it creates one subdirectory for each thermal zone and each fan.
This approach doesn't fit too well into libsensors, at least for my
naive approach. I've created one pseudo-chip for each thermal zone and
each fan entry, using the 4-letter ACPI identifier as an address.
We're lucky enough that 4 letters fit just fine in a 32-bit integer.
Given that ACPI isn't a bus, I've used the "dummy" bus type. I don't
remember it being ever used, but it came in quite handy :) I had to add
a few hacks in libsensors for it to work properly though.

I've attached the patch I have come up with, which does work good
enough for me. Note that the patch should be applied on top of SVN,
else it won't work for systems with only acpi temperature (no working
hwmon driver).

Example, on my laptop:

khali at arrakis:~> sensors
thermal-acpi-ATF0
Adapter: Dummy adapter
temperature:   +52?C  (high =   +85?C, crit =   +90?C)  

khali at arrakis:~>

I've made a number of choices as far as the temperature limits are
concerned. I've made ACPI's "passive" trip point the high limit, and
ACPI's "critical" trip point the critical limit. Both are optional (or
at least I have one laptop with none of them.) ACPI additionally
defines 0 to 10 "active" trip points, which are more about fan speed
control than temperature, as I understand it; my current implementation
doesn't support them. I've made an alarm out of the "state" interface
file.

Setting temperature limits is not supported at the moment. I'm not sure
it will ever be, due to the way the acpi interface works.

For fans, there seems to be only a status flag, saying if the fan is on
or off. Another example:

khali at hyperion:~> sensors "*-acpi-*"
thermal-acpi-THRM
Adapter: Dummy adapter
temperature:    +9?C  (high =   +68?C, crit =   +70?C)  

fan-acpi-FAN
Adapter: Dummy adapter
status:         on

khali at hyperion:~>

(Yes, temperature is stuck at 9 degrees C on that machine, presumably
since I upgraded the BIOS...)

One completely different approach would be to implement an hwmon-acpi
driver in the Linux kernel itself, which would register with the hwmon
class and would export the ACPI data using the standard interface. I've
not looked into feasability yet, though.

Thoughts anyone?

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: libsensors-acpi-support.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060606/10488445/attachment-0001.pl 
