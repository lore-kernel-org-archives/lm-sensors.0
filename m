From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: ADM1026 patch for CVS
Message-Id: <3EE24C87.9010100@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the ADM1026 patch for CVS.

This patch also contains code to dynamically generate sensors.h from the .c 
files in KERNELCHIPS (kernel/chips).  If you apply this patch, you'll need to 
obsolete? the sensors.h in the repository so it won't get downloaded in a 
checkout and thus get built automatically.

In looking at this, I think sensors.h really should be renamed and moved to 
/lib though.  Since it's only used by user-space, it ought to be in a 
user-space directory.  i2c-dev.h also should be moved for the same reason.

Lastly, as I looked at this I realized we have another issue to address with 
the 2.5/sysfs conversion.  If defined constants shared between the kernel and 
user space are bad, then we have to have a way to export the ALARM information 
from the drivers without requiring a set of #define constants for the bits. 
Rather than exporting a single "alarms" value from the driver, we're going to 
have to create *even more* files, one per sensor, with the "ALARM" strings in 
them.  Also, be aware that some temperature sensors have two types of "alarm" 
conditions.  One is a failed sensor (open circuit), the other is an 
out-of-range condition.  I think both of these could be in the same file (I 
used 'ALARM' and 'FAULT' in the lm85 sensors printing routine.

:v)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-cvs-adm1026-2.patch.gz
Type: application/octet-stream
Size: 24535 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030607/f4b6ed9e/lm_sensors-cvs-adm1026-2.patch.obj
