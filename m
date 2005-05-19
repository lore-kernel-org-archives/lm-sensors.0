From: app@mail.writecode.org (app@mail.writecode.org)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: lm_sensors on kernel 2.6.6
Message-Id: <20040530155539.5BF6218FD9B@mail.writecode.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hey,
I've been trying to install lm_sensors on kernel 2.6.6. 
All the modules were compiled and loaded from the kernel and in lm_sensors I ran make user && make user_install

now, when I try to run the sensors binary it seems to be trying to get data from the wrong files.

open("/sys/bus/i2c/devices/0-002d/in_input6", O_RDONLY) = -1 ENOENT (No such file or directory)

This is one example of many. while on my machine the file:
/sys/bus/i2c/devices/0-002d/in6_input exists

The output I get not under strace:
root@writecode:~# sensors -s
as99127f-i2c-0-2d: Can't access procfs/sysfs file for writing;
Run as root?
root@writecode:~#

root@writecode:~# sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
Algorithm: Unavailable from sysfs
ERROR: Can't get IN0 data!
ERROR: Can't get IN1 data!
ERROR: Can't get IN2 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
ERROR: Can't get IN5 data!
ERROR: Can't get IN6 data!
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
ERROR: Can't get VID data!
alarms:
beep_enable:
          Sound alarm enabled

root@writecode:~#

Yours,
Eli Shmer.
