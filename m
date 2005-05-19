From: b.stolk@chello.nl (Bram Stolk)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: status of i2c in 2.5.70 kernel
Message-Id: <20030609114202.19c1002e.b.stolk@chello.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,


First: I'm not using your lm-sensor/i2c package, but I am
using the i2c stuff from a stock 2.5.70 kernel.

The stock 2.5.70 kernel does not seem to support PROC_FS for
i2c any more. It used to be in i2c-core.c, but now it has been
removed.

Browsing your CVS, I saw that your package includes a 
i2c-proc.c

Has the new proc interface been offered for inclusion
with future 2.5 kernels yet?

Also, there seems to be a duality: sysfs vs procfs.
When I mount sysfs, I get a /sys/bus/i2c dir, which contains
dirs only, and no files. However, I do have a working i2c
adapter, as I can read /dev/i2c-0:
Opening device...
Done
I2C_FUNC_SMBUS_BYTE
i2c chip found at: 2d, val = 1
i2c chip found at: 50, val = 0
i2c chip found at: 69, val = 8
When running on my via686 system, with support for
CONFIG_I2C_VIAPRO=y
CONFIG_SENSORS_VIA686A=y
CONFIG_I2C_SENSOR=y
CONFIG_I2C_CHARDEV=y

Shouldn't I get some entries in /sys/bus/i2c, or do I have to wait for
a better i2c support in future 2.5 kernels?

Thanks,

        Bram Stolk
