From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: lm_sensors 2.8.5 on i2c 2.8.2: `I2C_DRIVERID_ADM1026' undeclared
Message-Id: <20040309090846.GG17881@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I tried to build lm_sensors for the RH9 kernels, for which I have i2c
2.8.2. The build fails with

gcc  -DMODVERSIONS -include /amd/heretic/1/data_nobkp/bach/bach-kernel/rh9/2.4.20-30_37.rh9.at-i686/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomi
t-frame-pointer -I. -Ikernel/include -I/amd/heretic/1/data_nobkp/bach/bach-kernel/rh9/2.4.20-30_37.rh9.at-i686/include  -I/amd/heretic/1/data_nobkp/bach/bach-kernel/rh9/2.
4.20-30_37.rh9.at-i686/include -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include  -Wall -O2  -c kernel/chips/adm1026.c -o kernel/chips/adm1026.o
kernel/chips/adm1026.c:385: `I2C_DRIVERID_ADM1026' undeclared here (not in a function)
kernel/chips/adm1026.c:385: initializer element is not constant
kernel/chips/adm1026.c:385: (near initialization for `adm1026_driver.id')
make: *** [kernel/chips/adm1026.o] Error 1

Did I do something wrong, or does lm_sensors still need newer i2c in the kernel?

Thanks!
P.S. lm_sensors 2.8.5 for FC1 build fine and will be upload later today.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040309/c7716222/attachment.bin
