From: decibel8@charter.net (David)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: 1250
Message-Id: <200306021011.37032.decibel8@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ls -l /proc/sys/dev/sensors
total 0
-rw-r--r--    1 root     root            0 Jun  2 10:05 chips
dr-xr-xr-x    2 root     root            0 Jun  2 09:49 via686a-isa-6000

ls -l /proc/sys/dev/sensors/via*
total 0
-r--r--r--    1 root     root            0 Jun  2 10:06 alarms
-rw-r--r--    1 root     root            0 Jun  2 10:06 fan1
-rw-r--r--    1 root     root            0 Jun  2 10:06 fan2
-rw-r--r--    1 root     root            0 Jun  2 10:06 fan_div
-rw-r--r--    1 root     root            0 Jun  2 10:06 in0
-rw-r--r--    1 root     root            0 Jun  2 10:06 in1
-rw-r--r--    1 root     root            0 Jun  2 10:06 in2
-rw-r--r--    1 root     root            0 Jun  2 10:06 in3
-rw-r--r--    1 root     root            0 Jun  2 10:06 in4
-rw-r--r--    1 root     root            0 Jun  2 10:06 temp1
-rw-r--r--    1 root     root            0 Jun  2 10:06 temp2
-rw-r--r--    1 root     root            0 Jun  2 10:06 temp3

But even when I change the via686a-isa-6000 folder to have root write 
permissions it doesn't work.

ls -l /proc/sys/dev/sensors
total 0
-rw-r--r--    1 root     root            0 Jun  2 10:07 chips
drwxr-xr-x    2 root     root            0 Jun  2 09:49 via686a-isa-6000

So still get: 
sensors -s
via686a-isa-6000: Can't access /proc file for writing;
Run as root?

I don't think the permission is staying either. Would devfs have something to 
do with this?
