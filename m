From: brian@shoptalkforums.com (Brian Wagener)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: Need support for Ticket #: 1643
Message-Id: <63715.192.91.147.36.1082567214.squirrel@www.shoptalkforums.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I searched the lists, and tickets but could not find the solution.  And
was told to email if I still needed help.  The problem as reported in the
help ticket is below.
Thanks,
Brian

This is probably releated to my other problem where sensors -s says "No
sensors found!", but I found that the /proc/sys/dev/sensors/vt1211 is
updating.  But I notice that if I do a ls in the sensors diretory chips
shows up twice.
lsmod:
vt1211                  6736   0  (unused)
i2c-proc                6836   0  [vt1211]
i2c-isa                  748   0  (unused)
i2c-core               15652   0  [vt1211 i2c-proc i2c-isa]

ls -l
total 0
-rw-r--r--    1 root     root            0 Apr  4 19:52 chips
-rw-r--r--    1 root     root            0 Apr  4 19:52 chips
dr-xr-xr-x    2 root     root            0 Apr  4 19:52 vt1211-isa-6000
