From: support@obsidian-studios.com (William L. Thomson Jr.)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] lm-sensors newb needs help
Message-Id: <1116388677.22757.6.camel@wlt.obsidian-studios.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Lost a machine recently not sure if temp or etc had to do with it but it
prompted me to follow up with the last aspect of my servers monitoring,
lm_sensors.

One of the machines I am working with has a PC Chips M863G mb with SIS
741GX/963L chipsets.

Now I can see a winbond chip on the board, but got nothing when I
compiled in support for it. Through trial and error I finally have the
following showing up in dmesg.

i2c /dev entries driver
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x0c00
it87: Found IT8705F chip at 0x290, revision 3

However when I do I get

root # sensors
No sensors found!
root # sensors-detect
Can't access /proc/modules! at /usr/sbin/sensors-detect line 1837.
root # i2cdetect -l
i2c-0   unknown         SiS96x SMBus adapter at 0x0c00          Algorithm unavailable

Now I have no clue what to do with the sensors.conf file with regard to
how I get the values and etc to go in there.

Do I have the stuff compiled as modules? I have all algorithms compiled
in for i2c? Not sure if I missed something or what I need to do?

Any help or pointers in the right direction is greatly appreciated. I
have a variety of machines to do this on, but if I can get the basics
down. I am sure I can get the rest.

Thanks in advance.

-- 
Sincerely,
William L. Thomson Jr.
Support Group
Obsidian-Studios, Inc.
http://www.obsidian-studios.com
	


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
