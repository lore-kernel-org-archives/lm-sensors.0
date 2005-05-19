From: Matthias.Sutter@kaufland.de (Matthias.Sutter@kaufland.de)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: experience with the 2.4.26
Message-Id: <OF042BDD97.61ACBC24-ONC1256E77.0031DAA1-C1256E77.00323804@kaufland.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org





Hi all,

Have you any experience the the 2.4.26 kernel?
I'd tried to installed the lm_sensors-2.8.6 but i got the follow compiler
erros message:

gcc  -D__SMP__ -DMODVERSIONS -include /lib/modules/2.4.26
/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB
-fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include
-I/lib/modules/2.4.26/build/include -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include  -Wall -O2  -c
kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
kernel/busses/i2c-nforce2.c: In function `nforce2_access':
kernel/busses/i2c-nforce2.c:140: `I2C_CLIENT_PEC' undeclared (first use in
this function)
kernel/busses/i2c-nforce2.c:140: (Each undeclared identifier is reported
only once
kernel/busses/i2c-nforce2.c:140: for each function it appears in.)
kernel/busses/i2c-nforce2.c:204: `I2C_SMBUS_BLOCK_PROC_CALL' undeclared
(first use in this function)
kernel/busses/i2c-nforce2.c:219: `I2C_SMBUS_WORD_DATA_PEC' undeclared
(first use in this function)
kernel/busses/i2c-nforce2.c:220: `I2C_SMBUS_BLOCK_DATA_PEC' undeclared
(first use in this function)
kernel/busses/i2c-nforce2.c:221: `I2C_SMBUS_PROC_CALL_PEC' undeclared
(first use in this function)
kernel/busses/i2c-nforce2.c:222: `I2C_SMBUS_BLOCK_PROC_CALL_PEC' undeclared
(first use in this function)
kernel/busses/i2c-nforce2.c:247: warning: implicit declaration of function
`i2c_delay'
kernel/busses/i2c-nforce2.c:134: warning: `pec' might be used uninitialized
in this function
kernel/busses/i2c-nforce2.c: In function `nforce2_probe_smb':
kernel/busses/i2c-nforce2.c:325: `I2C_HW_SMBUS_NFORCE2' undeclared (first
use in this function)
make: *** [kernel/busses/i2c-nforce2.o] Error 1

Is the kernel the cause?

Best regards

Matthias Sutter
