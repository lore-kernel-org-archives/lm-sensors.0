From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Mar 2006 22:11:05 +0000
Subject: [lm-sensors] Proposal to individual alarm/beep sysfs files
Message-Id: <20060305231105.97f9085a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Last week, in the course of writing a hardware monitoring driver for the
SMSC LPC47M192 chip, Hartmut Rick and I discussed how alarms could be
represented under sysfs in a standard way, so that no knowledge of the
chip is needed for userspace libraries and tools. I'll try to summarize
our conclusion here, and also add a few thoughts I had since. Hopefully
this can lead us to a fully standard solution; this is the last step I
am aware of before a chip-independant library can be written.

The original discussion was between per-type files versus per-channel
files. I think we agreed that individual files were better, allowing a
much cleaner implementation. Per-type files would require us to reorder
all bits when the chip has them in a random order (which is most often
the case, unfortunately). With per-channel files, we just have to
extract the correct bit, which is easy. We can even use the same
callback for all alarms, as demonstrated at the end of this post.

Now, some chips offer more than one alarm for a given channel. For
example the LM90/ADM1032 has a separate alarm for low limit crossed,
high limit crossed and critical limit crossed. It was suggested that we
could have non-boolean alarm files, and it makes some sense. However,
on second though, it means that we would have to define a standard bit
order inside such alarm files, and we'll have to build the contents
from the registers. This won't be easier than having per-type files,
which we said we did not want to do.

So my new suggestion is to have per-limit alarm files for chips which
implement things that way. This makes every alarm file a boolean. The
only drawback I can think of is that we'll end up with many more sysfs
files defined in each driver. However, the size increase seems to be
acceptable, thanks to the dynamic sysfs callbacks and the array of
attributes which we can use now.

Fault conditions and beep masks can be handled exactly the same way.

Here is a proposed patch to sysfs-interface which summarizes my views.
It's only a draft for now, comments are welcome.

--- linux-2.6.16-rc5.orig/Documentation/hwmon/sysfs-interface	2006-03-05 17:41:07.000000000 +0100
+++ linux-2.6.16-rc5/Documentation/hwmon/sysfs-interface	2006-03-05 22:38:34.000000000 +0100
@@ -246,9 +246,68 @@
 		Read only.
 
 
-*********
-* Other *
-*********
+**********
+* Alarms *
+**********
+
+Each channel or limit may have an associated alarm file, containing a
+boolean value. 1 means than an alarm condition exists, 0 means no alarm.
+
+Usually a given chip will either use channel-related alarms, or
+limit-related alarms, not both. The driver should just reflect the hardware
+implementation.
+
+in[0-n]_alarm
+fan[1-n]_alarm
+temp[1-n]_alarm
+		Channel alarm
+		Boolean
+		Read-only
+
+OR
+
+in[0-n]_min_alarm
+in[0-n]_max_alarm
+fan[1-n]_min_alarm
+temp[1-n]_min_alarm
+temp[1-n]_max_alarm
+temp[1-n]_crit_alarm
+		Limit alarm
+		Boolean
+		Read-only
+
+In theory, a chip could provide per-limit beep masking, but no such chip
+was seen so far.
+
+Each input channel may have an associated fault file. This can be used
+to notify open diodes, unconnected fans etc. where the hardware
+supports it. When this boolean has value 1, the measurement for that
+channel should not be trusted.
+
+fan[1-n]_input_fault
+temp[1-n]_input_fault
+		Input fault condition
+		Boolean
+		Read-only
+
+Some chips also offer the possibility to get beeped when an alarm occurs:
+
+beep_enable	Master beep enable
+		0 to disable.
+		1 to enable.
+		Read/Write
+
+in[0-n]_beep
+fan[1-n]_beep
+temp[1-n]_beep
+		Channel beep
+		0 to disable.
+		1 to enable.
+		Read/write
+
+Old drivers provided a different, non-standard interface to alarms and
+beeps. These interface files are deprecated, but will be kept around
+for compatibility reasons:
 
 alarms		Alarm bitmask.
 		Read only.
@@ -259,33 +318,22 @@
 		if it is still valid.
 		Generally a direct representation of a chip's internal
 		alarm registers; there is no standard for the position
-		of individual bits.
+		of individual bits. For this reason, the use of this
+		interface file for new drivers is discouraged. Use
+		individual *_alarm and *_fault files instead.
 		Bits are defined in kernel/include/sensors.h.
 
-alarms_in	Alarm bitmask relative to in (voltage) channels
-		Read only
-		A '1' bit means an alarm, LSB corresponds to in0 and so on
-		Prefered to 'alarms' for newer chips
-
-alarms_fan	Alarm bitmask relative to fan channels
-		Read only
-		A '1' bit means an alarm, LSB corresponds to fan1 and so on
-		Prefered to 'alarms' for newer chips
-
-alarms_temp	Alarm bitmask relative to temp (temperature) channels
-		Read only
-		A '1' bit means an alarm, LSB corresponds to temp1 and so on
-		Prefered to 'alarms' for newer chips
-
-beep_enable	Beep/interrupt enable
-		0 to disable.
-		1 to enable.
-		Read/Write
-
 beep_mask	Bitmask for beep.
-		Same format as 'alarms' with the same bit locations.
+		Same format as 'alarms' with the same bit locations,
+		use discouraged for the same reason. Use individual
+		*_beep files instead.
 		Read/Write
 
+
+*********
+* Other *
+*********
+
 eeprom		Raw EEPROM data in binary form.
 		Read only.
 

Additionally, you can check these three driver conversions I did
already as an experiment:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-f71805f-individual-alarm-files.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-lm63-individual-alarm-files.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-lm90-individual-alarm-files.patch

Note that we will have to leave all old "alarms" files in place anyway,
as they have been there for so long now, and we don't want to rewrite
libsensors and sensors anyway. But the new files will make it possible
to write a new library... someday. New drivers will also only have the
individual files.

Thanks,
-- 
Jean Delvare

