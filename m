From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 11 May 2006 14:31:15 +0000
Subject: [lm-sensors] set lines in sensors.conf.eg
Message-Id: <20060511163115.7ca1d6a5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

There have been several reports about systems getting into various
trouble after installing lm_sensors these last months. Symptoms could
be instant shutdown, beeps, or slowness. Each time, the reason why that
"sensors -s" was run at boot time, and the default sensors
configuration file would trigger an alarm, and the system would be
hardwired to react to that alarm.

References:
http://bugzilla.kernel.org/show_bug.cgi?idC32
http://bugzilla.kernel.org/show_bug.cgi?idQ86
https://bugzilla.novell.com/show_bug.cgi?id0542
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id9878
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-March/011369.html

And I'm certain I'm missing several other reports on this list and
elsewhere.

With newer systems featuring hardware protection, I expect to see this
kind of problem even more frequently in the next months. It seems
reasonable for distributions to run "sensors -s" at boot time,
sensors-config itself suggests it. So my conclusion is that the default
sensors.conf configuration file should NOT have any "set" line
activated. Any such line is likely to create an alarm condition. This
is especially true for temperature inputs.

Thus I am proposing that we comment out all "set" lines in
sensors.conf.eg. What do others think?

-- 
Jean Delvare

