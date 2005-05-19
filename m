From: alexander.pohl@tu-berlin.de (Alexander Pohl)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Intel 82801DA ICH4
Message-Id: <32792.62.246.191.31.1061925341.squirrel@mailbox.TU-Berlin.DE>
List-Id: <lm-sensors.vger.kernel.org>
References: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
In-Reply-To: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

yes, the module p4b_smbus.o compiles now. But the lm-sensors package
itself won't compile anymore.

Best reguards
Alexander Pohl

gcc  -D__SMP__ -DMODVERSIONS -include
/lib/modules/2.4.20-smp/build/include/linux/modversions.h -D__KERNEL__
-DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include
-I/usr/local/include  -I/lib/modules/2.4.20-smp/build/include -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include  -Wall -O2   -c
kernel/chips/xeontemp.c -o kernel/chips/xeontemp.o
kernel/chips/xeontemp.c:112: `I2C_DRIVERID_XEONTEMP' undeclared here (not
in a function)
kernel/chips/xeontemp.c:112: initializer element is not constant
kernel/chips/xeontemp.c:112: (near initialization for `xeontemp_driver.id')
make: *** [kernel/chips/xeontemp.o] Error 1

<Zitiere wer="Mark D. Studebaker ">
> I've hopefully fixed the SMP compile problem in CVS if you would like to
> try it.




