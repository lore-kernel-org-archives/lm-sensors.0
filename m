From: jackie_lola@yahoo.fr (jackie)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Installation   lm_sensors-2.9.0, sur Suse 9.2 , noyau 2.6
Message-Id: <200502131137.43844.jackie_lola@yahoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Impossible to install with the two commands  make user and make user_install.
 I have a mother board  Asus P4PE-X with Pentium Celeron 2,4 Ghz


When in the good rep :

ip-10:/home/jackie/Documents/Paquetages/Ksensors/lm_sensors-2.9.0/lm_sensors-2.9.0
 
Doing :  make 

here is the second part of errors message.

Makefile:250: kernel/chips/lm85.d: Aucun fichier ou
r?pertoire de ce type
Makefile:250: kernel/chips/lm87.d: Aucun fichier ou
r?pertoire de ce type
Makefile:250: kernel/chips/lm90.d: Aucun fichier ou
r?pertoire de ce type
Makefile:250: kernel/chips/lm92.d: Aucun fichier ou
r?pertoire de ce type
Makefile:250: kernel/chips/matorb.d: Aucun fichier o
u r?pertoire de ce type
Makefile:250: kernel/chips/max6650.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/maxilife.d: Aucun fichier
 ou r?pertoire de ce type
Makefile:250: kernel/chips/mtp008.d: Aucun fichier o
u r?pertoire de ce type
Makefile:250: kernel/chips/pc87360.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/pca9540.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/pcf8574.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/pcf8591.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/sis5595.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/smsc47m1.d: Aucun fichier
 ou r?pertoire de ce type
Makefile:250: kernel/chips/thmc50.d: Aucun fichier o
u r?pertoire de ce type
Makefile:250: kernel/chips/w83781d.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/via686a.d: Aucun fichier
ou r?pertoire de ce type
Makefile:250: kernel/chips/vt1211.d: Aucun fichier o
u r?pertoire de ce type
Makefile:250: kernel/chips/vt8231.d: Aucun fichier o
u r?pertoire de ce type
Makefile:250: kernel/chips/w83627hf.d: Aucun fichier
 ou r?pertoire de ce type
Makefile:250: kernel/chips/w83l785ts.d: Aucun fichie
r ou r?pertoire de ce type
Makefile:250: kernel/chips/xeontemp.d: Aucun fichier
 ou r?pertoire de ce type
Makefile:250: kernel/include/sensors.hd: Aucun fichi
er ou r?pertoire de ce type
Makefile:250: lib/data.ld: Aucun fichier ou r?pertoi
re de ce type
Makefile:250: lib/general.ld: Aucun fichier ou r?per
toire de ce type
Makefile:250: lib/error.ld: Aucun fichier ou r?perto
ire de ce type
Makefile:250: lib/chips.ld: Aucun fichier ou r?perto
ire de ce type
Makefile:250: lib/proc.ld: Aucun fichier ou r?pertoi
re de ce type
Makefile:250: lib/access.ld: Aucun fichier ou r?pert
oire de ce type
Makefile:250: lib/init.ld: Aucun fichier ou r?pertoi
re de ce type
Makefile:250: lib/data.ad: Aucun fichier ou r?pertoi
re de ce type
Makefile:250: lib/general.ad: Aucun fichier ou r?per
toire de ce type
Makefile:250: lib/error.ad: Aucun fichier ou r?perto
ire de ce type
Makefile:250: lib/chips.ad: Aucun fichier ou r?perto
ire de ce type
Makefile:250: lib/proc.ad: Aucun fichier ou r?pertoi
re de ce type
Makefile:250: lib/access.ad: Aucun fichier ou r?pert
oire de ce type
Makefile:250: lib/init.ad: Aucun fichier ou r?pertoi
re de ce type
Makefile:250: prog/detect/i2cdetect.rd: Aucun fichie
r ou r?pertoire de ce type
Makefile:250: prog/dump/i2cdump.rd: Aucun fichier ou
 r?pertoire de ce type
Makefile:250: prog/dump/i2cset.rd: Aucun fichier ou
r?pertoire de ce type
Makefile:250: prog/dump/i2cbusses.rd: Aucun fichier
ou r?pertoire de ce type
Makefile:250: prog/dump/isadump.rd: Aucun fichier ou
 r?pertoire de ce type
Makefile:250: prog/dump/isaset.rd: Aucun fichier ou
r?pertoire de ce type
Makefile:250: prog/sensors/main.rd: Aucun fichier ou
 r?pertoire de ce type
Makefile:250: prog/sensors/chips.rd: Aucun fichier o
u r?pertoire de ce type
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/sensors/chips.
c | \
        sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd
prog/sensors/chips.ro: Makefile '`dirname prog/senso
rs/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/sensors/main.c
 | \
        sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd p
rog/sensors/main.ro: Makefile '`dirname prog/sensors
/main.rd`/Module.mk' @' > prog/sensors/main.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/dump/isaset.c
| \
        sed -e 's@^\(.*\)\.o:@prog/dump/isaset.rd pr
og/dump/isaset.ro: Makefile '`dirname prog/dump/isas
et.rd`/Module.mk' @' > prog/dump/isaset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/dump/isadump.c
 | \
        sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd p
rog/dump/isadump.ro: Makefile '`dirname prog/dump/is
adump.rd`/Module.mk' @' > prog/dump/isadump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/dump/i2cbusses
.c | \
        sed -e 's@^\(.*\)\.o:@prog/dump/i2cbusses.rd
 prog/dump/i2cbusses.ro: Makefile '`dirname prog/dum
p/i2cbusses.rd`/Module.mk' @' > prog/dump/i2cbusses.
rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/dump/i2cset.c
| \
        sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd pr
og/dump/i2cset.ro: Makefile '`dirname prog/dump/i2cs
et.rd`/Module.mk' @' > prog/dump/i2cset.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/dump/i2cdump.c
 | \
        sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd p
rog/dump/i2cdump.ro: Makefile '`dirname prog/dump/i2
cdump.rd`/Module.mk' @' > prog/dump/i2cdump.rd
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/detect/i2cdete
ct.c | \
        sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.
rd prog/detect/i2cdetect.ro: Makefile '`dirname prog
/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2
cdetect.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/init.c | \
        sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.a
o: Makefile '`dirname lib/init.ad`/Module.mk' @' > l
ib/init.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/access.c | \
        sed -e 's@^\(.*\)\.o:@lib/access.ad lib/acce
ss.ao: Makefile '`dirname lib/access.ad`/Module.mk'
@' > lib/access.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/proc.c | \
        sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.a
o: Makefile '`dirname lib/proc.ad`/Module.mk' @' > l
ib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/chips.c | \
        sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips
.ao: Makefile '`dirname lib/chips.ad`/Module.mk' @'
> lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/error.c | \
        sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error
.ao: Makefile '`dirname lib/error.ad`/Module.mk' @'
> lib/error.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/general.c | \
        sed -e 's@^\(.*\)\.o:@lib/general.ad lib/gen
eral.ao: Makefile '`dirname lib/general.ad`/Module.m
k' @' > lib/general.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/data.c | \
        sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.a
o: Makefile '`dirname lib/data.ad`/Module.mk' @' > l
ib/data.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -fpic -Wall -O2  lib/init.c | \
        sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.l
o: Makefile '`dirname lib/init.ld`/Module.mk' @' > l
ib/init.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -fpic -Wall -O2  lib/access.c | \
        sed -e 's@^\(.*\)\.o:@lib/access.ld lib/acce
ss.lo: Makefile '`dirname lib/access.ld`/Module.mk'
@' > lib/access.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -fpic -Wall -O2  lib/proc.c | \
        sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.l
o: Makefile '`dirname lib/proc.ld`/Module.mk' @' > l
ib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -fpic -Wall -O2  lib/chips.c | \
        sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips
.lo: Makefile '`dirname lib/chips.ld`/Module.mk' @'
> lib/chips.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -fpic -Wall -O2  lib/error.c | \
        sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error
.lo: Makefile '`dirname lib/error.ld`/Module.mk' @'
> lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -fpic -Wall -O2  lib/general.c | \
        sed -e 's@^\(.*\)\.o:@lib/general.ld lib/gen
eral.lo: Makefile '`dirname lib/general.ld`/Module.m
k' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -fpic -Wall -O2  lib/data.c | \
        sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.l
o: Makefile '`dirname lib/data.ld`/Module.mk' @' > l
ib/data.ld
( grep 'SENSORS SYSCTL START' /dev/null kernel/chips
/*.c | \
  sed -e 's/:.*//' -e 's#^#kernel/include/sensors.h:
 #' ) > kernel/include/sensors.hd
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/xeontemp.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/xeontemp.
d kernel/chips/xeontemp.o: Makefile '`dirname kernel
/chips/xeontemp.d`/Module.mk' @' > kernel/chips/xeon
temp.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/w83l785ts.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/w83l785ts
.d kernel/chips/w83l785ts.o: Makefile '`dirname kern
el/chips/w83l785ts.d`/Module.mk' @' > kernel/chips/w
83l785ts.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/w83627hf.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/w83627hf.
d kernel/chips/w83627hf.o: Makefile '`dirname kernel
/chips/w83627hf.d`/Module.mk' @' > kernel/chips/w836
27hf.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/vt8231.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/vt8231.d
kernel/chips/vt8231.o: Makefile '`dirname kernel/chi
ps/vt8231.d`/Module.mk' @' > kernel/chips/vt8231.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/vt1211.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/vt1211.d
kernel/chips/vt1211.o: Makefile '`dirname kernel/chi
ps/vt1211.d`/Module.mk' @' > kernel/chips/vt1211.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/via686a.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/via686a.d
 kernel/chips/via686a.o: Makefile '`dirname kernel/c
hips/via686a.d`/Module.mk' @' > kernel/chips/via686a
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/w83781d.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/w83781d.d
 kernel/chips/w83781d.o: Makefile '`dirname kernel/c
hips/w83781d.d`/Module.mk' @' > kernel/chips/w83781d
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/thmc50.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/thmc50.d
kernel/chips/thmc50.o: Makefile '`dirname kernel/chi
ps/thmc50.d`/Module.mk' @' > kernel/chips/thmc50.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/smsc47m1.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/smsc47m1.
d kernel/chips/smsc47m1.o: Makefile '`dirname kernel
/chips/smsc47m1.d`/Module.mk' @' > kernel/chips/smsc
47m1.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/sis5595.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/sis5595.d
 kernel/chips/sis5595.o: Makefile '`dirname kernel/c
hips/sis5595.d`/Module.mk' @' > kernel/chips/sis5595
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/pcf8591.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8591.d
 kernel/chips/pcf8591.o: Makefile '`dirname kernel/c
hips/pcf8591.d`/Module.mk' @' > kernel/chips/pcf8591
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/pcf8574.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8574.d
 kernel/chips/pcf8574.o: Makefile '`dirname kernel/c
hips/pcf8574.d`/Module.mk' @' > kernel/chips/pcf8574
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/pca9540.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/pca9540.d
 kernel/chips/pca9540.o: Makefile '`dirname kernel/c
hips/pca9540.d`/Module.mk' @' > kernel/chips/pca9540
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/pc87360.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/pc87360.d
 kernel/chips/pc87360.o: Makefile '`dirname kernel/c
hips/pc87360.d`/Module.mk' @' > kernel/chips/pc87360
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/mtp008.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/mtp008.d
kernel/chips/mtp008.o: Makefile '`dirname kernel/chi
ps/mtp008.d`/Module.mk' @' > kernel/chips/mtp008.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/maxilife.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/maxilife.
d kernel/chips/maxilife.o: Makefile '`dirname kernel
/chips/maxilife.d`/Module.mk' @' > kernel/chips/maxi
life.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/max6650.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/max6650.d
 kernel/chips/max6650.o: Makefile '`dirname kernel/c
hips/max6650.d`/Module.mk' @' > kernel/chips/max6650
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/matorb.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/matorb.d
kernel/chips/matorb.o: Makefile '`dirname kernel/chi
ps/matorb.d`/Module.mk' @' > kernel/chips/matorb.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm92.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm92.d ke
rnel/chips/lm92.o: Makefile '`dirname kernel/chips/l
m92.d`/Module.mk' @' > kernel/chips/lm92.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm90.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm90.d ke
rnel/chips/lm90.o: Makefile '`dirname kernel/chips/l
m90.d`/Module.mk' @' > kernel/chips/lm90.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm87.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm87.d ke
rnel/chips/lm87.o: Makefile '`dirname kernel/chips/l
m87.d`/Module.mk' @' > kernel/chips/lm87.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm85.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm85.d ke
rnel/chips/lm85.o: Makefile '`dirname kernel/chips/l
m85.d`/Module.mk' @' > kernel/chips/lm85.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm83.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm83.d ke
rnel/chips/lm83.o: Makefile '`dirname kernel/chips/l
m83.d`/Module.mk' @' > kernel/chips/lm83.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm80.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm80.d ke
rnel/chips/lm80.o: Makefile '`dirname kernel/chips/l
m80.d`/Module.mk' @' > kernel/chips/lm80.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm78.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm78.d ke
rnel/chips/lm78.o: Makefile '`dirname kernel/chips/l
m78.d`/Module.mk' @' > kernel/chips/lm78.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm75.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm75.d ke
rnel/chips/lm75.o: Makefile '`dirname kernel/chips/l
m75.d`/Module.mk' @' > kernel/chips/lm75.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/it87.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/it87.d ke
rnel/chips/it87.o: Makefile '`dirname kernel/chips/i
t87.d`/Module.mk' @' > kernel/chips/it87.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/gl520sm.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/gl520sm.d
 kernel/chips/gl520sm.o: Makefile '`dirname kernel/c
hips/gl520sm.d`/Module.mk' @' > kernel/chips/gl520sm
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/gl518sm.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/gl518sm.d
 kernel/chips/gl518sm.o: Makefile '`dirname kernel/c
hips/gl518sm.d`/Module.mk' @' > kernel/chips/gl518sm
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/fscscy.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/fscscy.d
kernel/chips/fscscy.o: Makefile '`dirname kernel/chi
ps/fscscy.d`/Module.mk' @' > kernel/chips/fscscy.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/fscpos.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/fscpos.d
kernel/chips/fscpos.o: Makefile '`dirname kernel/chi
ps/fscpos.d`/Module.mk' @' > kernel/chips/fscpos.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/fscher.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/fscher.d
kernel/chips/fscher.o: Makefile '`dirname kernel/chi
ps/fscher.d`/Module.mk' @' > kernel/chips/fscher.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/eeprom.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/eeprom.d
kernel/chips/eeprom.o: Makefile '`dirname kernel/chi
ps/eeprom.d`/Module.mk' @' > kernel/chips/eeprom.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/ds1621.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/ds1621.d
kernel/chips/ds1621.o: Makefile '`dirname kernel/chi
ps/ds1621.d`/Module.mk' @' > kernel/chips/ds1621.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/ddcmon.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/ddcmon.d
kernel/chips/ddcmon.o: Makefile '`dirname kernel/chi
ps/ddcmon.d`/Module.mk' @' > kernel/chips/ddcmon.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/bt869.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/bt869.d k
ernel/chips/bt869.o: Makefile '`dirname kernel/chips
/bt869.d`/Module.mk' @' > kernel/chips/bt869.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/asb100.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/asb100.d
kernel/chips/asb100.o: Makefile '`dirname kernel/chi
ps/asb100.d`/Module.mk' @' > kernel/chips/asb100.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/adm9240.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/adm9240.d
 kernel/chips/adm9240.o: Makefile '`dirname kernel/c
hips/adm9240.d`/Module.mk' @' > kernel/chips/adm9240
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/adm1026.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/adm1026.d
 kernel/chips/adm1026.o: Makefile '`dirname kernel/c
hips/adm1026.d`/Module.mk' @' > kernel/chips/adm1026
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/adm1025.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/adm1025.d
 kernel/chips/adm1025.o: Makefile '`dirname kernel/c
hips/adm1025.d`/Module.mk' @' > kernel/chips/adm1025
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/adm1024.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/adm1024.d
 kernel/chips/adm1024.o: Makefile '`dirname kernel/c
hips/adm1024.d`/Module.mk' @' > kernel/chips/adm1024
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/adm1021.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/adm1021.d
 kernel/chips/adm1021.o: Makefile '`dirname kernel/c
hips/adm1021.d`/Module.mk' @' > kernel/chips/adm1021
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/smbus-arp.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/smbus-arp
.d kernel/chips/smbus-arp.o: Makefile '`dirname kern
el/chips/smbus-arp.d`/Module.mk' @' > kernel/chips/s
mbus-arp.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/smartbatt.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/smartbatt
.d kernel/chips/smartbatt.o: Makefile '`dirname kern
el/chips/smartbatt.d`/Module.mk' @' > kernel/chips/s
martbatt.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/saa1064.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/saa1064.d
 kernel/chips/saa1064.o: Makefile '`dirname kernel/c
hips/saa1064.d`/Module.mk' @' > kernel/chips/saa1064
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/max1619.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/max1619.d
 kernel/chips/max1619.o: Makefile '`dirname kernel/c
hips/max1619.d`/Module.mk' @' > kernel/chips/max1619
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/ltc1710.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/ltc1710.d
 kernel/chips/ltc1710.o: Makefile '`dirname kernel/c
hips/ltc1710.d`/Module.mk' @' > kernel/chips/ltc1710
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm93.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm93.d ke
rnel/chips/lm93.o: Makefile '`dirname kernel/chips/l
m93.d`/Module.mk' @' > kernel/chips/lm93.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/lm63.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/lm63.d ke
rnel/chips/lm63.o: Makefile '`dirname kernel/chips/l
m63.d`/Module.mk' @' > kernel/chips/lm63.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/ds1307.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/ds1307.d
kernel/chips/ds1307.o: Makefile '`dirname kernel/chi
ps/ds1307.d`/Module.mk' @' > kernel/chips/ds1307.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/bmcsensors.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/bmcsensor
s.d kernel/chips/bmcsensors.o: Makefile '`dirname ke
rnel/chips/bmcsensors.d`/Module.mk' @' > kernel/chip
s/bmcsensors.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/chips/adm1031.c | \
        sed -e 's@^\(.*\)\.o:@kernel/chips/adm1031.d
 kernel/chips/adm1031.o: Makefile '`dirname kernel/c
hips/adm1031.d`/Module.mk' @' > kernel/chips/adm1031
.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-voodoo3.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-vood
oo3.d kernel/busses/i2c-voodoo3.o: Makefile '`dirnam
e kernel/busses/i2c-voodoo3.d`/Module.mk' @' > kerne
l/busses/i2c-voodoo3.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-viapro.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-viap
ro.d kernel/busses/i2c-viapro.o: Makefile '`dirname
kernel/busses/i2c-viapro.d`/Module.mk' @' > kernel/b
usses/i2c-viapro.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-via.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-via.
d kernel/busses/i2c-via.o: Makefile '`dirname kernel
/busses/i2c-via.d`/Module.mk' @' > kernel/busses/i2c
-via.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-savage4.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sava
ge4.d kernel/busses/i2c-savage4.o: Makefile '`dirnam
e kernel/busses/i2c-savage4.d`/Module.mk' @' > kerne
l/busses/i2c-savage4.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/dmi_scan.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/dmi_scan
.d kernel/busses/dmi_scan.o: Makefile '`dirname kern
el/busses/dmi_scan.d`/Module.mk' @' > kernel/busses/
dmi_scan.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-piix4.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-piix
4.d kernel/busses/i2c-piix4.o: Makefile '`dirname ke
rnel/busses/i2c-piix4.d`/Module.mk' @' > kernel/buss
es/i2c-piix4.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-sis645.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis6
45.d kernel/busses/i2c-sis645.o: Makefile '`dirname
kernel/busses/i2c-sis645.d`/Module.mk' @' > kernel/b
usses/i2c-sis645.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-sis630.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis6
30.d kernel/busses/i2c-sis630.o: Makefile '`dirname
kernel/busses/i2c-sis630.d`/Module.mk' @' > kernel/b
usses/i2c-sis630.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-sis5595.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis5
595.d kernel/busses/i2c-sis5595.o: Makefile '`dirnam
e kernel/busses/i2c-sis5595.d`/Module.mk' @' > kerne
l/busses/i2c-sis5595.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-nforce2.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-nfor
ce2.d kernel/busses/i2c-nforce2.o: Makefile '`dirnam
e kernel/busses/i2c-nforce2.d`/Module.mk' @' > kerne
l/busses/i2c-nforce2.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-isa.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-isa.
d kernel/busses/i2c-isa.o: Makefile '`dirname kernel
/busses/i2c-isa.d`/Module.mk' @' > kernel/busses/i2c
-isa.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-i810.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i810
.d kernel/busses/i2c-i810.o: Makefile '`dirname kern
el/busses/i2c-i810.d`/Module.mk' @' > kernel/busses/
i2c-i810.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-i801.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i801
.d kernel/busses/i2c-i801.o: Makefile '`dirname kern
el/busses/i2c-i801.d`/Module.mk' @' > kernel/busses/
i2c-i801.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-hydra.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-hydr
a.d kernel/busses/i2c-hydra.o: Makefile '`dirname ke
rnel/busses/i2c-hydra.d`/Module.mk' @' > kernel/buss
es/i2c-hydra.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-amd8111.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-amd8
111.d kernel/busses/i2c-amd8111.o: Makefile '`dirnam
e kernel/busses/i2c-amd8111.d`/Module.mk' @' > kerne
l/busses/i2c-amd8111.d
kernel/busses/i2c-amd8111.c:26:2: #error Your i2c is
 too old - i2c-2.7.0 or greater required!
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-amd756-s4882.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-amd7
56-s4882.d kernel/busses/i2c-amd756-s4882.o: Makefil
e '`dirname kernel/busses/i2c-amd756-s4882.d`/Module
.mk' @' > kernel/busses/i2c-amd756-s4882.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-amd756.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-amd7
56.d kernel/busses/i2c-amd756.o: Makefile '`dirname
kernel/busses/i2c-amd756.d`/Module.mk' @' > kernel/b
usses/i2c-amd756.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-ali15x3.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1
5x3.d kernel/busses/i2c-ali15x3.o: Makefile '`dirnam
e kernel/busses/i2c-ali15x3.d`/Module.mk' @' > kerne
l/busses/i2c-ali15x3.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-ali1535.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1
535.d kernel/busses/i2c-ali1535.o: Makefile '`dirnam
e kernel/busses/i2c-ali1535.d`/Module.mk' @' > kerne
l/busses/i2c-ali1535.d
gcc -M -MG  -DMODVERSIONS -include /lib/modules/2.6.
8-24.11-default/build/include/linux/modversions.h -D
__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-poi
nter -I. -Ikernel/include -I/usr/local/include  -I/l
ib/modules/2.6.8-24.11-default/build/include -nostdi
nc -I /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include
  -Wall -O2  kernel/busses/i2c-ipmi.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ipmi
.d kernel/busses/i2c-ipmi.o: Makefile '`dirname kern
el/busses/i2c-ipmi.d`/Module.mk' @' > kernel/busses/
i2c-ipmi.d
cat kernel/include/sensors.h.template > kernel/inclu
de/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' ke
rnel/chips/*.c >> kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
-I/usr/local/include  -Wall -O2  prog/sensors/chips.
c | \
        sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd
prog/sensors/chips.ro: Makefile '`dirname prog/senso
rs/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
  -Wall -O2  lib/proc.c | \
        sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.a
o: Makefile '`dirname lib/proc.ad`/Module.mk' @' > l
ib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -Wall -O2  lib/chips.c | 
\
        sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname 
lib/chips.ad`/Module.mk' @'> lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -fpic -Wall -O2  
lib/proc.c | \
        sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname 
lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -fpic -Wall -O2  
lib/chips.c | \
        sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname 
lib/chips.ld`/Module.mk' @'> lib/chips.ld
make: *** Pas de r?gle pour fabriquer la cible 
? /lib/modules/2.6.8-24.11-default/build/include/linux/modversions.h ?, 
n?cessaire pour ? kernel/chips/xeontemp.d ?. Arr?t.
ip-10:/home/jackie/Documents/Paquetages/Ksensors/lm_sensors-2.9.0/lm_sensors-2.9.0
 #

I can't install   lm_sensors , following the "read me" for 2.6

 Congratulations
 
Jacqueline
