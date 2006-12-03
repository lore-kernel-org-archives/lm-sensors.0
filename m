From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 03 Dec 2006 08:18:45 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file for
Message-Id: <45728865.5020308@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Since booting into 2.6.19 on my VIA SP8000 I have a small problem with
the vt1211 sensors driver:

sensors -s gives:

vt1211-isa-6000: Can't access procfs/sysfs file for writing;


Also the temperature sensors are not shown.

sysfs is of course mounted and accessible.
lm_sensors 2.10.1 we have installed before rebooting.

The vt1211 sensors stuff has moved to
/sys/bus/platform/drivers/vt1211/vt1211.24576. In that directory the
files with sensors info for rpm, voltage etc can be found.

Of course the sensor's location on the bus was not changed so I am
wondering what is wrong, why can't the sensors command find the files in
/sys/bus/platform/drivers/vt1211/vt1211.24576?

How do I fix this problem?

Kind regards,
Udo

