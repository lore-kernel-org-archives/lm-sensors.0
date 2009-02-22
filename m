From: "armencho@gmail.com" <armencho@gmail.com>
Date: Sun, 22 Feb 2009 14:25:22 +0000
Subject: [lm-sensors] Preferred way to obtain thermal data on Linux?
Message-Id: <981b72360902220625v3ad05655j7d60254bc252a6b6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Thinkpad T61. Reading from /proc/acpi/ibm/thermal works fine
but generates too many interrupts - reading the file once per 5
seconds generates 20 interrupts waking up the CPU, wasting battery
life and outputting extra heat very strictly speaking, although many
would not care. Admittedly reading sensor data through
/sys/class/hwmon/*/device/*_input files ALSO interrupts the CPU,
albeit not so often. The /proc interface is also deprecated they say.
In light of the latter, the multitude of ways to obtain readings, and
the fact that I am trying to find battery-life optimal way to read the
sensors continually (most hardware monitors do so), i was wondering:

What interface is most reliable, generic and least resource intensive
for obtaining sensor readings in Linux (2.6.27.11)?

The reason I am asking is that it seems both documentation of
thinkpad-acpi and libsensors mentions similiar facts, and touches the
same subjects, almost hinting that the development of these two
modules shares a lot of knowledge. Both have their own separate ways
to obtain sensor readings, and both prefer this or that. Also, I have
no knowledge of internal workings of libsensors, and whether it in
fact USES thinkpad-acpi or generic acpi driver or something else to do
its job. I just want to get a piece of advice concerning the best
method, and also one that is reliable. I know thinkpad-acpi gets data
per ACPI specs, and that libsensors does chip-specific stuff, but
still that does not give me confidence using either over the other...

-amn.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
