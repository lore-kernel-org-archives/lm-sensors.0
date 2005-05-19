From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: sensors-detect segmentation fault.
Message-Id: <20030820214335.GB28515@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF2A643F2F.52CE6915-ONC1256D86.0058E32A-C1256D86.005966AD@nl.ibm.com>
In-Reply-To: <OF2A643F2F.52CE6915-ONC1256D86.0058E32A-C1256D86.005966AD@nl.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Bram Havers <Bram_Havers@nl.ibm.com> [2003-08-18 18:14:14 +0200]:
> Hi,
> I've installed lm_sensors and i2c on my Via Epia ME6000 with Red Hat 9.
> When i run sensors-detect it ends with a segmentation fault after which 
> only a reboot helps to kill the processes
> Below i've posted what appears on the console, dmseg and lsmod.
> Hope you can help. Thanks.

<snip>

> ----------dmesg ----
> via82cxxx: board #1 at 0xE400, IRQ 10
> i2c-core.o: i2c core module version 2.8.0 (20030714)
> i2c-viapro.o version 2.6.5 (20020915)
> i2c-viapro.o: Found Via VT8233A/8235 device
> i2c-viapro.o: Via Pro SMBus detected and initialized
> i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714)
> i2c-dev.o: Registered 's Via Pro adapter at 0500' as minor 0

<snip>

You have version 2.8.0 of I2C but only 2.6.5 of sensors, not sure how.
Make sure to remove the sensors RH package, then rebuild and reinstall
from the 2.8.0 source - first i2c, then lm_sensors2.

OT: How is the Linux support for the rest of that board?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
