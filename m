From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 17:10:53 +0000
Subject: [lm-sensors] Fault files naming convention
Message-Id: <20070525191053.16166460@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

We have the following naming convention documented in
Documentation/hwmon/sysfs-interface for fault files:

in[0-*]_input_fault
fan[1-*]_input_fault
temp[1-*]_input_fault

Some drivers follow this convention (lm63, lm83, lm90, smsc47m192).
However some drivers omit the "input" part and create files named
fan1_fault (pc87427) or temp1_fault (dme1737). And the new "generic"
libsensors follows this second (non-standard) convention, so it fails
to report fault conditions for drivers which follow the standard.

We need to fix it all up so that we have a single convention and
libsensors uses it. I would fix the drivers which do not follow the
standard, and libsensors, however I start wondering if the short names
aren't better. After all, we don't include the "input" part in alarm
and beep file names, so it is questionable why we do it for fault
conditions. Well, it might make some sense, but on the other hand the
short name isn't ambiguous as far as I can see, so it would work too.
So I just don't know. But what I know is that we must fix it quickly.
Anyone has an opinion on why the long or the short names would be
preferable?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
