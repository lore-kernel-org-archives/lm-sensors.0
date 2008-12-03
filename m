From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Dec 2008 17:22:16 +0000
Subject: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <20081203182216.5be504cf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Over the past few days, I have been working a lot on sensors-detect. I
implemented ideas I had exposed months ago but did not have the time to
implement back then:

id	summary
2322	The probe order in sensors-detect doesn't make sense
2325	sensors-detect: Drop support for Linux 2.4
2327	sensors-detect: Fix the bus numbering prediction magic
2328	sensors-detect: Get the bus driver names from the kernel
2329	sensors-detect: Unload drivers which we loaded ourselves

I also made a huge amount of cleanups (including a complete
reindentation of the source code), reducing the size of the
sensors-detect script from 185 kB to roughly 145 kB.

With so many changes, both in functionality and implementation, I
expect some fallouts. I tested my work on several machines already, but
there are so many possible combinations of devices that it is rather
unlikely that I managed to get everything right.

So, I would like users to give a try to the latest version of
sensors-detect and report if it works fine for them or not. You can get
the latest version of sensors-detect using the following svn command:

svn export http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect

Alternatively, you can get a copy from trac:
http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt

The behavior should be essentially the same as before, with the
difference that probes are done in reverse order (CPU, Super I/O, ISA,
SMBus), and ISA and SMBus probes default to no if a working Super I/O
was found (as was discussed on the list before [1].)

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023056.html

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
