From: cl@auo.psy.ruhr-uni-bochum.de (Christian Leson)
Date: Fri, 30 Sep 2005 15:46:18 +0000
Subject: [lm-sensors] gl520sm-i2c vin4
Message-Id: <433D2869.2090509@auo.psy.ruhr-uni-bochum.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello support,

after an installation of lm_sensors on a Debian system Kernel 2.6.12
(testing) I've the following problem:

sensord won't start, error message:
Sep 30 13:50:42 debian sensord: Error getting sensor data: gl520sm/vin4:
Can't access procfs/sysfs file
Sep 30 13:50:42 debian sensord: sensord failed

All the other sensors can be read.

sensors -s gives the following error.

debian:/home/cl# sensors -c /etc/sensors.conf -s
gl520sm-i2c-0-2d: Can't access procfs/sysfs file for writing;
Run as root?

I already commented out the vin4 lines in sensors.conf, no effect.
"set two_temps 1" is already in sensors.conf.
How can I get sensord started?

-- 
Mit freundlichen Gr??en,

Christian Leson
Administrator A&O-Psychologie
Fakult?t f?r Psychologie
Ruhr-Universit?t Bochum

