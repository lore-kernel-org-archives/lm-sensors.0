From: maniac@agh.nzs.pl (Rafal Ramocki)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Problem During compilation
Message-Id: <Pine.LNX.4.21.0211231644240.2346-100000@agh.nzs.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ello!

I've pached kernel using newest lm_sensors package and i2c package, but
during compilation i have following errors:

gcc -D__KERNEL__ -I/home/staff/maniac666/linux-2.4.19/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-DMODULE  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=dmi_scan  -c -o dmi_scan.o dmi_scan.c
dmi_scan.c:240: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
dmi_scan.c:240: warning: type defaults to `int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
dmi_scan.c:240: warning: data definition has no type or storage class
dmi_scan.c:241: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
dmi_scan.c:241: warning: type defaults to `int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
dmi_scan.c:241: warning: data definition has no type or storage class
make[2]: *** [dmi_scan.o] B??d 1
make[2]: Leaving directory
`/home/staff/maniac666/linux-2.4.19/drivers/i2c'
make[1]: *** [_modsubdir_i2c] B??d 2
make[1]: Leaving directory `/home/staff/maniac666/linux-2.4.19/drivers'
make: *** [_mod_drivers] B??d 2


I have to say that paches aplyeed with no errors.  And this problem doesnt
exists only if i try to compile i2c-isa module.
When I'm compiling into the kernel it compiles fine, but whatever i do i
alway have "No sensors found!"

PS: "B??d" in polish means "error"

-- 
Rafal Ramocki			IRC : #stalowka
