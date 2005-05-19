From: p5yke@optusnet.com.au (p5yke)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: LM99 support
Message-Id: <1083128873.3486.48.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
In-Reply-To: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, hope you are well.

I finnaly have 4 days off again to spend on this :)
I have a number of questions. Sorry about this.
I hope I am not asking anything too stupid.

1) Do I need to apply the patch u sent me or is it now in the CVS? When
attempting to apply the path i get this:

[kernel] # patch -p1 < linux-2.6.3-i2c-lm99.diff
can't find file to patch at input line 3
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|--- linux-2.6.3/drivers/i2c/chips/lm90.c       Fri Apr 23 19:55:03 2004
|+++ linux-2.6.6-rc2/drivers/i2c/chips/lm90.c   Fri Apr 23 19:40:28 2004
--------------------------

** So I haven't done the patch.

2) when I do 'make user' and 'make user_install' i see no references to
lm90 (or any other modules) being compiled or installed. The original
modules are still in my
/lib/modules/2.6.3-7mdk/kernel/drivers/i2c/chips.
The documentation states: "The kernel modules in this package will not
compile for 2.6/2.5; use the drivers already in the 2.5 kernel
development tree." 

** How do i compile the LM90 module?

3) These issues are probably a victim of question 2. After removing my
lm_sensors and liblm_sensors RPM and getting the files from the CVS and
doing 'make user', 'make user_install' and doing sensors-detect and
following the instructions to do ldconfig and removing libsensors.* from
/usr/lib i get this:

# lsmod |grep i2c
i2c-viapro              6860  0
i2c-dev                10080  0
i2c-algo-bit            9512  1 rivatv
i2c-sensor              2944  3 eeprom,asb100,lm90
i2c-core               23044  9
eeprom,asb100,i2c-viapro,lm90,i2c-dev,saa7108e,rivatv,i2c-algo-bit,i2c-sensor

--------------------------------------------------------------
# sensors -s
asb100-i2c-3-2d: Can't access procfs/sysfs file for writing;
Run as root?

# ls /sys
block/  bus/  cdev/  class/  devices/  firmware/  power/

--------------------------------------------------------------
from logs:
Apr 28 14:22:20 c211-30-214-50 kernel: i2c_adapter i2c-2: sendbytes:
error - bailout.
Apr 28 14:23:00 c211-30-214-50 last message repeated 240 times

-------------------------------------------------------------
# sensors
eeprom-i2c-2-57
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (255).

eeprom-i2c-2-56
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (255).

eeprom-i2c-2-55
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (255).

eeprom-i2c-2-54
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (255).

eeprom-i2c-2-53
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (255).

eeprom-i2c-2-52
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (255).

eeprom-i2c-2-51
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (255).

eeprom-i2c-2-50
Adapter: NVIDIA display adapter bus 0
Unknown EEPROM type (81)

eeprom-i2c-1-57
Adapter: NVIDIA display adapter bus 1

eeprom-i2c-1-56
Adapter: NVIDIA display adapter bus 1

eeprom-i2c-1-55
Adapter: NVIDIA display adapter bus 1

eeprom-i2c-1-54
Adapter: NVIDIA display adapter bus 1

eeprom-i2c-1-53
Adapter: NVIDIA display adapter bus 1

eeprom-i2c-1-52
Adapter: NVIDIA display adapter bus 1

eeprom-i2c-1-51
Adapter: NVIDIA display adapter bus 1

eeprom-i2c-1-50
Adapter: NVIDIA display adapter bus 1
Either use the ddcmon driver instead of the eeprom driver,
or run the decode-edid.pl script.

asb100-i2c-3-2d
Adapter: SMBus Via Pro adapter at e800
ERROR: Can't get IN data! (0x0001)
ERROR: Can't get IN data! (0x0002)
ERROR: Can't get IN data! (0x0003)
ERROR: Can't get IN data! (0x0004)
ERROR: Can't get IN data! (0x0005)
ERROR: Can't get IN data! (0x0006)
ERROR: Can't get IN data! (0x0007)
ERROR: Can't get FAN data! (0x0031)
ERROR: Can't get FAN data! (0x0032)
ERROR: Can't get FAN data! (0x0033)
ERROR: Can't get TEMP data! (0x0051)
ERROR: Can't get TEMP data! (0x0054)
ERROR: Can't get TEMP data! (0x0057)
ERROR: Can't get TEMP data! (0x005a)
ERROR: Can't get VID data!
alarms:

Philips SAA7108E-i2c-0-21
Adapter: NVIDIA display adapter bus 2
---------------------------------------------------------------

Thanks alot for your help,
Scott.
