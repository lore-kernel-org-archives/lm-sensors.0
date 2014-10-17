From: R Kimber <richardkimber@btinternet.com>
Date: Fri, 17 Oct 2014 12:36:08 +0000
Subject: [lm-sensors] Can't load it87 module
Message-Id: <5436E69B010BDEA6@rgout03.bt.lon5.cpcloud.co.uk (added by postmaster@btinternet.com)>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm using Ubuntu 14.04 with 3.13.0-37-generic. MB is Gigabyte Z97X-UD3H
LGA1150; CPU is i7 4.0GHz.  I have installed 1:3.3.4-2ubuntu1 version of
lm-sensors. Sensors-detect indicates I have a chip of the ITE family:

Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x8620

though sensors-detect does not suggest adding it87 to /etc/modules

I also have:-
/lib/modules/3.13.0-37-generic/kernel/drivers/hwmon/it87.ko

But when I do:
sudo modprobe it87
I get:
modprobe: ERROR: could not insert 'it87': No such device.

Is there a way of loading this module?  I'd like to monitor my CPU fan
speed.  lm-sensors is just returning temperature data, presumably using
coretemp which is loaded.

- Richard.
-- 
Richard Kimber


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
