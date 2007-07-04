From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 04 Jul 2007 04:56:23 +0000
Subject: [lm-sensors] Handling of fault files in generic print code
Message-Id: <468B2877.9010305@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I noticed that currently the temp code prints a faults in the place where 
normally an alarm gets printed, and ignores alarms. I mimicked this for the 
fault support I added to the fan code.

But is this wise, since the reading are bogus when a FAULT is raised, shouldn't 
the reading be omitted, just like were omitting the alarm?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
