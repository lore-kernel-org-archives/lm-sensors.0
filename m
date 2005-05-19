From: yml@yml.com (Yermo M. Lamers)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Unresolved Symbols question lm_sensors 2.8.0/i2c 2.8.0/linux
Message-Id: <3F7DD22C.40200@yml.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F7B83FF.2060409@yml.com>
In-Reply-To: <3F7B83FF.2060409@yml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>dmi_scan_mach {} \;
>>./kernel/busses/dmi_scan.c
>>./kernel/busses/i2c-piix4.c
>>./kernel/busses/i2c-piix4.o
> 
> What about 'find . -name "*dmi_scan*"'?

Hmmmmm. It looks like that didn't get compiled .. maybe I missed some 
errors during the make?

[root@nbi_master lm_sensors-2.8.0]# find . -name "*dmi_scan*"
./kernel/busses/dmi_scan.c
./kernel/busses/dmi_scan.h

>>do the sensors-detect thing.
> 
> Looks good. Doesn't depmod -a complain about the missing symbol?

I must've missed that. It does in fact complain about the unresolved symbol.


>>How is dmi-scan linked in?
> 
> dmi_scan is a kernel module, exactly as i2c-piix4 is, and i2c-piix4
> depends on it. It looks like you were able to build the second without
> the first, which should not happend. Could you try explicitely asking
> for it? 'make kernel/busses/dmi_scan.o'

Here's what I get:

[root@nbi_master lm_sensors-2.8.0]# make kernel/busses/dmi_scan.o
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
grep: /lib/modules/2.4.20-8smp/build/.config: No such file or directory
gcc  -D__SMP__ -DMODVERSIONS -include 
/lib/modules/2.4.20-8smp/build/include/linux/modversions.h -D__KERNEL__ 
-DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include 
-I/usr/local/include -I/lib/modules/2.4.20-8smp/build/include  -nostdinc 
-I /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include  -Wall -O2   -c 
kernel/busses/dmi_scan.c -o kernel/busses/dmi_scan.o

Seems to have compiled

> give a try to i2c/lm_sensors CVS, in case it changes something? (I think
> I remember we made some adjustements to the build process right after -
> or was it right before - the 2.8.0 release.)

I can certainly do that.

If you like I can also give you an ssh login with root access on this 
box. It's not yet being used for anything ...

---------------------------------------------------------------------
DTLink Software                                 http://www.dtlink.com
---------------------------------------------------------------------
