From: marco.schwarz@gmx.net (Marco Schwarz)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Compiling i2c-2.9.1
Message-Id: <21521.1113399154@www44.gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am trying to install i2c-2.9.1 and lm_sensors-2.9.1 on my machine running
SLES8.

However when I try to compile i2c I get the following error codes:

gcc -D__SMP__ -DMODVERSIONS -include
/lib/modules/2.4.21-278-smp/build/include/linux/modversions.h
-I/lib/modules/2.4.21-278-smp/build/include -nostdinc -I
/usr/lib/gcc-lib/i486-suse-linux/3.2.2/include -Wall -O2 -D__KERNEL__
-DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -fno-strict-aliasing -c
kernel/i2c-philips-par.c -o kernel/i2c-philips-par.o
kernel/i2c-philips-par.c:156: initializer element is not constant
kernel/i2c-philips-par.c:156: (near initialization for
`bit_lp_data.timeout')
kernel/i2c-philips-par.c:165: initializer element is not constant
kernel/i2c-philips-par.c:165: (near initialization for
`bit_lp_data2.timeout')
make: *** [kernel/i2c-philips-par.o] Error 1

Can someone help me with this ? 

Best regards, 
Marco Schwarz
