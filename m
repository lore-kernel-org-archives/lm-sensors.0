From: ben@wblogan.net (Ben Logan)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Ticket #956 partly solved.
Message-Id: <20020730111750.A5705@wblogan.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I found at least part of the problem which I wrote about in ticket
#956.  When I install my kernels, I have been creating a symlink from
/boot/kernel.h -> /usr/include/linux/kernel.h.  That's a bad thing to
do for reasons which I'm sure you already know, but I just discovered.
:)

Now there's one more problem.  I can compile lm_sensors fine as long
as I edit the Makefile, and run make.  However, if I try to build the
rpm, I get some different parse error.  I've configured the spec
file with the same values as the Makefile, so I don't get it.  I've
included the full output from both running just 'make', and from
running 'rpm -bb lm_sensors.spec'.  I've also attached my specfile and
Makefile.

-------------------------------------------------------
[ben@mach1 lm_sensors-2.6.4] $ make
Makefile:221: kernel/busses/i2c-ali1535.d: No such file or directory
Makefile:221: kernel/busses/i2c-ali15x3.d: No such file or directory
Makefile:221: kernel/busses/i2c-amd756.d: No such file or directory
Makefile:221: kernel/busses/i2c-hydra.d: No such file or directory
Makefile:221: kernel/busses/i2c-i801.d: No such file or directory
Makefile:221: kernel/busses/i2c-i810.d: No such file or directory
Makefile:221: kernel/busses/i2c-isa.d: No such file or directory
Makefile:221: kernel/busses/i2c-sis5595.d: No such file or directory
Makefile:221: kernel/busses/i2c-piix4.d: No such file or directory
Makefile:221: kernel/busses/i2c-savage4.d: No such file or directory
Makefile:221: kernel/busses/i2c-via.d: No such file or directory
Makefile:221: kernel/busses/i2c-viapro.d: No such file or directory
Makefile:221: kernel/busses/i2c-voodoo3.d: No such file or directory
Makefile:221: kernel/chips/smbus-arp.d: No such file or directory
Makefile:221: kernel/chips/adm1021.d: No such file or directory
Makefile:221: kernel/chips/adm1024.d: No such file or directory
Makefile:221: kernel/chips/adm1025.d: No such file or directory
Makefile:221: kernel/chips/adm9240.d: No such file or directory
Makefile:221: kernel/chips/bt869.d: No such file or directory
Makefile:221: kernel/chips/ddcmon.d: No such file or directory
Makefile:221: kernel/chips/ds1621.d: No such file or directory
Makefile:221: kernel/chips/eeprom.d: No such file or directory
Makefile:221: kernel/chips/fscpos.d: No such file or directory
Makefile:221: kernel/chips/fscscy.d: No such file or directory
Makefile:221: kernel/chips/gl518sm.d: No such file or directory
Makefile:221: kernel/chips/gl520sm.d: No such file or directory
Makefile:221: kernel/chips/it87.d: No such file or directory
Makefile:221: kernel/chips/lm75.d: No such file or directory
Makefile:221: kernel/chips/lm78.d: No such file or directory
Makefile:221: kernel/chips/lm80.d: No such file or directory
Makefile:221: kernel/chips/lm87.d: No such file or directory
Makefile:221: kernel/chips/lm92.d: No such file or directory
Makefile:221: kernel/chips/ltc1710.d: No such file or directory
Makefile:221: kernel/chips/matorb.d: No such file or directory
Makefile:221: kernel/chips/maxilife.d: No such file or directory
Makefile:221: kernel/chips/mtp008.d: No such file or directory
Makefile:221: kernel/chips/pcf8574.d: No such file or directory
Makefile:221: kernel/chips/pcf8591.d: No such file or directory
Makefile:221: kernel/chips/sis5595.d: No such file or directory
Makefile:221: kernel/chips/smsc47m1.d: No such file or directory
Makefile:221: kernel/chips/thmc50.d: No such file or directory
Makefile:221: kernel/chips/w83781d.d: No such file or directory
Makefile:221: kernel/chips/via686a.d: No such file or directory
Makefile:221: kernel/chips/vt1211.d: No such file or directory
Makefile:221: lib/data.ld: No such file or directory
Makefile:221: lib/general.ld: No such file or directory
Makefile:221: lib/error.ld: No such file or directory
Makefile:221: lib/chips.ld: No such file or directory
Makefile:221: lib/proc.ld: No such file or directory
Makefile:221: lib/access.ld: No such file or directory
Makefile:221: lib/init.ld: No such file or directory
Makefile:221: lib/data.ad: No such file or directory
Makefile:221: lib/general.ad: No such file or directory
Makefile:221: lib/error.ad: No such file or directory
Makefile:221: lib/chips.ad: No such file or directory
Makefile:221: lib/proc.ad: No such file or directory
Makefile:221: lib/access.ad: No such file or directory
Makefile:221: lib/init.ad: No such file or directory
Makefile:221: prog/sensors/main.rd: No such file or directory
Makefile:221: prog/sensors/chips.rd: No such file or directory
Makefile:221: prog/dump/isadump.rd: No such file or directory
Makefile:221: prog/dump/i2cdump.rd: No such file or directory
Makefile:221: prog/dump/i2cset.rd: No such file or directory
Makefile:221: prog/detect/i2cdetect.rd: No such file or directory
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   prog/detect/i2cdetect.c | \
       	sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd prog/detect/i2cdetect.ro: Makefile '`dirname prog/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2cdetect.rd
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   prog/dump/i2cset.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd prog/dump/i2cset.ro: Makefile '`dirname prog/dump/i2cset.rd`/Module.mk' @' > prog/dump/i2cset.rd
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   prog/dump/i2cdump.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd prog/dump/i2cdump.ro: Makefile '`dirname prog/dump/i2cdump.rd`/Module.mk' @' > prog/dump/i2cdump.rd
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   prog/dump/isadump.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro: Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' > prog/dump/isadump.rd
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   prog/sensors/chips.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   prog/sensors/main.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro: Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' > prog/sensors/main.rd
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   lib/init.c | \
       	sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.ao: Makefile '`dirname lib/init.ad`/Module.mk' @' > lib/init.ad
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   lib/access.c | \
       	sed -e 's@^\(.*\)\.o:@lib/access.ad lib/access.ao: Makefile '`dirname lib/access.ad`/Module.mk' @' > lib/access.ad
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   lib/error.c | \
       	sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error.ao: Makefile '`dirname lib/error.ad`/Module.mk' @' > lib/error.ad
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   lib/general.c | \
       	sed -e 's@^\(.*\)\.o:@lib/general.ad lib/general.ao: Makefile '`dirname lib/general.ad`/Module.mk' @' > lib/general.ad
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   lib/data.c | \
       	sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile '`dirname lib/data.ad`/Module.mk' @' > lib/data.ad
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   lib/init.c | \
       	sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile '`dirname lib/init.ld`/Module.mk' @' > lib/init.ld
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   lib/access.c | \
       	sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile '`dirname lib/access.ld`/Module.mk' @' > lib/access.ld
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname lib/chips.ld`/Module.mk' @' > lib/chips.ld
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   lib/error.c | \
       	sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile '`dirname lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   lib/general.c | \
       	sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile '`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   lib/data.c | \
       	sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname lib/data.ld`/Module.mk' @' > lib/data.ld
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/vt1211.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/vt1211.d kernel/chips/vt1211.o: Makefile '`dirname kernel/chips/vt1211.d`/Module.mk' @' > kernel/chips/vt1211.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/via686a.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/via686a.d kernel/chips/via686a.o: Makefile '`dirname kernel/chips/via686a.d`/Module.mk' @' > kernel/chips/via686a.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/w83781d.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/w83781d.d kernel/chips/w83781d.o: Makefile '`dirname kernel/chips/w83781d.d`/Module.mk' @' > kernel/chips/w83781d.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/thmc50.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/thmc50.d kernel/chips/thmc50.o: Makefile '`dirname kernel/chips/thmc50.d`/Module.mk' @' > kernel/chips/thmc50.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/smsc47m1.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/smsc47m1.d kernel/chips/smsc47m1.o: Makefile '`dirname kernel/chips/smsc47m1.d`/Module.mk' @' > kernel/chips/smsc47m1.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/sis5595.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/sis5595.d kernel/chips/sis5595.o: Makefile '`dirname kernel/chips/sis5595.d`/Module.mk' @' > kernel/chips/sis5595.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/pcf8591.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8591.d kernel/chips/pcf8591.o: Makefile '`dirname kernel/chips/pcf8591.d`/Module.mk' @' > kernel/chips/pcf8591.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/pcf8574.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8574.d kernel/chips/pcf8574.o: Makefile '`dirname kernel/chips/pcf8574.d`/Module.mk' @' > kernel/chips/pcf8574.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/mtp008.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/mtp008.d kernel/chips/mtp008.o: Makefile '`dirname kernel/chips/mtp008.d`/Module.mk' @' > kernel/chips/mtp008.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/maxilife.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/maxilife.d kernel/chips/maxilife.o: Makefile '`dirname kernel/chips/maxilife.d`/Module.mk' @' > kernel/chips/maxilife.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/matorb.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/matorb.d kernel/chips/matorb.o: Makefile '`dirname kernel/chips/matorb.d`/Module.mk' @' > kernel/chips/matorb.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/ltc1710.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ltc1710.d kernel/chips/ltc1710.o: Makefile '`dirname kernel/chips/ltc1710.d`/Module.mk' @' > kernel/chips/ltc1710.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/lm92.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm92.d kernel/chips/lm92.o: Makefile '`dirname kernel/chips/lm92.d`/Module.mk' @' > kernel/chips/lm92.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/lm87.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm87.d kernel/chips/lm87.o: Makefile '`dirname kernel/chips/lm87.d`/Module.mk' @' > kernel/chips/lm87.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/lm80.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm80.d kernel/chips/lm80.o: Makefile '`dirname kernel/chips/lm80.d`/Module.mk' @' > kernel/chips/lm80.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/lm78.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm78.d kernel/chips/lm78.o: Makefile '`dirname kernel/chips/lm78.d`/Module.mk' @' > kernel/chips/lm78.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/lm75.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm75.d kernel/chips/lm75.o: Makefile '`dirname kernel/chips/lm75.d`/Module.mk' @' > kernel/chips/lm75.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/it87.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/it87.d kernel/chips/it87.o: Makefile '`dirname kernel/chips/it87.d`/Module.mk' @' > kernel/chips/it87.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/gl520sm.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/gl520sm.d kernel/chips/gl520sm.o: Makefile '`dirname kernel/chips/gl520sm.d`/Module.mk' @' > kernel/chips/gl520sm.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/gl518sm.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/gl518sm.d kernel/chips/gl518sm.o: Makefile '`dirname kernel/chips/gl518sm.d`/Module.mk' @' > kernel/chips/gl518sm.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/fscscy.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/fscscy.d kernel/chips/fscscy.o: Makefile '`dirname kernel/chips/fscscy.d`/Module.mk' @' > kernel/chips/fscscy.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/fscpos.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/fscpos.d kernel/chips/fscpos.o: Makefile '`dirname kernel/chips/fscpos.d`/Module.mk' @' > kernel/chips/fscpos.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/eeprom.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/eeprom.d kernel/chips/eeprom.o: Makefile '`dirname kernel/chips/eeprom.d`/Module.mk' @' > kernel/chips/eeprom.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/ds1621.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ds1621.d kernel/chips/ds1621.o: Makefile '`dirname kernel/chips/ds1621.d`/Module.mk' @' > kernel/chips/ds1621.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/ddcmon.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ddcmon.d kernel/chips/ddcmon.o: Makefile '`dirname kernel/chips/ddcmon.d`/Module.mk' @' > kernel/chips/ddcmon.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/bt869.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/bt869.d kernel/chips/bt869.o: Makefile '`dirname kernel/chips/bt869.d`/Module.mk' @' > kernel/chips/bt869.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/adm9240.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm9240.d kernel/chips/adm9240.o: Makefile '`dirname kernel/chips/adm9240.d`/Module.mk' @' > kernel/chips/adm9240.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/adm1025.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1025.d kernel/chips/adm1025.o: Makefile '`dirname kernel/chips/adm1025.d`/Module.mk' @' > kernel/chips/adm1025.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/adm1024.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1024.d kernel/chips/adm1024.o: Makefile '`dirname kernel/chips/adm1024.d`/Module.mk' @' > kernel/chips/adm1024.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/adm1021.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1021.d kernel/chips/adm1021.o: Makefile '`dirname kernel/chips/adm1021.d`/Module.mk' @' > kernel/chips/adm1021.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/chips/smbus-arp.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/smbus-arp.d kernel/chips/smbus-arp.o: Makefile '`dirname kernel/chips/smbus-arp.d`/Module.mk' @' > kernel/chips/smbus-arp.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-voodoo3.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-voodoo3.d kernel/busses/i2c-voodoo3.o: Makefile '`dirname kernel/busses/i2c-voodoo3.d`/Module.mk' @' > kernel/busses/i2c-voodoo3.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-viapro.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-viapro.d kernel/busses/i2c-viapro.o: Makefile '`dirname kernel/busses/i2c-viapro.d`/Module.mk' @' > kernel/busses/i2c-viapro.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-via.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-via.d kernel/busses/i2c-via.o: Makefile '`dirname kernel/busses/i2c-via.d`/Module.mk' @' > kernel/busses/i2c-via.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-savage4.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-savage4.d kernel/busses/i2c-savage4.o: Makefile '`dirname kernel/busses/i2c-savage4.d`/Module.mk' @' > kernel/busses/i2c-savage4.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-piix4.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-piix4.d kernel/busses/i2c-piix4.o: Makefile '`dirname kernel/busses/i2c-piix4.d`/Module.mk' @' > kernel/busses/i2c-piix4.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-sis5595.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis5595.d kernel/busses/i2c-sis5595.o: Makefile '`dirname kernel/busses/i2c-sis5595.d`/Module.mk' @' > kernel/busses/i2c-sis5595.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-isa.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-isa.d kernel/busses/i2c-isa.o: Makefile '`dirname kernel/busses/i2c-isa.d`/Module.mk' @' > kernel/busses/i2c-isa.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-i810.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i810.d kernel/busses/i2c-i810.o: Makefile '`dirname kernel/busses/i2c-i810.d`/Module.mk' @' > kernel/busses/i2c-i810.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-i801.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i801.d kernel/busses/i2c-i801.o: Makefile '`dirname kernel/busses/i2c-i801.d`/Module.mk' @' > kernel/busses/i2c-i801.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-hydra.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-hydra.d kernel/busses/i2c-hydra.o: Makefile '`dirname kernel/busses/i2c-hydra.d`/Module.mk' @' > kernel/busses/i2c-hydra.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-amd756.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-amd756.d kernel/busses/i2c-amd756.o: Makefile '`dirname kernel/busses/i2c-amd756.d`/Module.mk' @' > kernel/busses/i2c-amd756.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-ali15x3.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali15x3.d kernel/busses/i2c-ali15x3.o: Makefile '`dirname kernel/busses/i2c-ali15x3.d`/Module.mk' @' > kernel/busses/i2c-ali15x3.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   kernel/busses/i2c-ali1535.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d kernel/busses/i2c-ali1535.o: Makefile '`dirname kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-ali15x3.c -o kernel/busses/i2c-ali15x3.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-amd756.c -o kernel/busses/i2c-amd756.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-hydra.c -o kernel/busses/i2c-hydra.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-i801.c -o kernel/busses/i2c-i801.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-i810.c -o kernel/busses/i2c-i810.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-isa.c -o kernel/busses/i2c-isa.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-sis5595.c -o kernel/busses/i2c-sis5595.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-piix4.c -o kernel/busses/i2c-piix4.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-savage4.c -o kernel/busses/i2c-savage4.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-via.c -o kernel/busses/i2c-via.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-viapro.c -o kernel/busses/i2c-viapro.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-voodoo3.c -o kernel/busses/i2c-voodoo3.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/smbus-arp.c -o kernel/chips/smbus-arp.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/adm1021.c -o kernel/chips/adm1021.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/adm1024.c -o kernel/chips/adm1024.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/adm1025.c -o kernel/chips/adm1025.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/adm9240.c -o kernel/chips/adm9240.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/bt869.c -o kernel/chips/bt869.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/ddcmon.c -o kernel/chips/ddcmon.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/ds1621.c -o kernel/chips/ds1621.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/eeprom.c -o kernel/chips/eeprom.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/fscpos.c -o kernel/chips/fscpos.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/fscscy.c -o kernel/chips/fscscy.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/gl518sm.c -o kernel/chips/gl518sm.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/gl520sm.c -o kernel/chips/gl520sm.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/it87.c -o kernel/chips/it87.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/lm75.c -o kernel/chips/lm75.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/lm78.c -o kernel/chips/lm78.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/lm80.c -o kernel/chips/lm80.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/lm87.c -o kernel/chips/lm87.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/lm92.c -o kernel/chips/lm92.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/ltc1710.c -o kernel/chips/ltc1710.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/matorb.c -o kernel/chips/matorb.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/maxilife.c -o kernel/chips/maxilife.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/mtp008.c -o kernel/chips/mtp008.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/pcf8574.c -o kernel/chips/pcf8574.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/pcf8591.c -o kernel/chips/pcf8591.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/sis5595.c -o kernel/chips/sis5595.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/smsc47m1.c -o kernel/chips/smsc47m1.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/thmc50.c -o kernel/chips/thmc50.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/w83781d.c -o kernel/chips/w83781d.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/via686a.c -o kernel/chips/via686a.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include   -O2   -c kernel/chips/vt1211.c -o kernel/chips/vt1211.o
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/data.c -o lib/data.ao
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/general.c -o lib/general.ao
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/error.c -o lib/error.ao
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/chips.c -o lib/chips.ao
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/proc.c -o lib/proc.ao
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/access.c -o lib/access.ao
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/init.c -o lib/init.ao
bison -p sensors_yy -d lib/conf-parse.y -o lib/conf-parse.c
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/conf-parse.c -o lib/conf-parse.ao
flex -Psensors_yy -t lib/conf-lex.l > lib/conf-lex.c
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c lib/conf-lex.c -o lib/conf-lex.ao
rm -f lib/libsensors.a
ar rcvs lib/libsensors.a lib/data.ao lib/general.ao lib/error.ao lib/chips.ao lib/proc.ao lib/access.ao lib/init.ao lib/conf-parse.ao lib/conf-lex.ao
a - lib/data.ao
a - lib/general.ao
a - lib/error.ao
a - lib/chips.ao
a - lib/proc.ao
a - lib/access.ao
a - lib/init.ao
a - lib/conf-parse.ao
a - lib/conf-lex.ao
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/data.c -o lib/data.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/general.c -o lib/general.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/error.c -o lib/error.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/chips.c -o lib/chips.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/proc.c -o lib/proc.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/access.c -o lib/access.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/init.c -o lib/init.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/conf-parse.c -o lib/conf-parse.lo
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -fpic -O2   -c lib/conf-lex.c -o lib/conf-lex.lo
gcc -shared -Wl,-soname,libsensors.so.1 -o lib/libsensors.so.1.2.1 lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc
rm -f lib/libsensors.so.1
ln -sfn libsensors.so.1.2.1 lib/libsensors.so.1
rm -f lib/libsensors.so 
ln -sfn libsensors.so.1.2.1 lib/libsensors.so
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c prog/sensors/main.c -o prog/sensors/main.ro
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c prog/sensors/chips.c -o prog/sensors/chips.ro
gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro -Llib -lsensors
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c prog/dump/isadump.c -o prog/dump/isadump.ro
gcc  -o prog/dump/isadump prog/dump/isadump.ro
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c prog/dump/i2cdump.c -o prog/dump/i2cdump.ro
gcc  -o prog/dump/i2cdump prog/dump/i2cdump.ro
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c prog/dump/i2cset.c -o prog/dump/i2cset.ro
gcc  -o prog/dump/i2cset prog/dump/i2cset.ro
gcc -I. -Ikernel/include -I/usr/src/linux/include -I/usr/src/linux/include  -O2   -c prog/detect/i2cdetect.c -o prog/detect/i2cdetect.ro
gcc  -o prog/detect/i2cdetect prog/detect/i2cdetect.ro
[ben@mach1 lm_sensors-2.6.4] $ echo $?
0
---------------------------------------------------------

As you can see, it was successful.

---------------------------------------------------------
[ben@mach1 SPECS] $ rpm -bb lm_sensors.spec 
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.42376
+ umask 022
+ cd /home/ben/programming/rpm/BUILD
+ cd /home/ben/programming/rpm/BUILD
+ rm -rf lm_sensors-2.6.4
+ /bin/gzip -dc /home/ben/programming/rpm/SOURCES/lm_sensors-2.6.4.tar.gz
+ tar -xvvf -
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/RPM/
-rw-rw-r-- phil/phil      2874 2000-05-16 00:43:42 lm_sensors-2.6.4/RPM/README
-rw-rw-r-- phil/phil      6268 2000-05-16 00:43:42 lm_sensors-2.6.4/RPM/lm_sensors-rh.spec
-rw-rw-r-- phil/phil      5945 2000-05-16 00:43:42 lm_sensors-2.6.4/RPM/lm_sensors.spec
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/doc/
-rw-rw-r-- phil/phil      3358 2002-02-16 10:00:32 lm_sensors-2.6.4/doc/mkpatch
-rw-rw-r-- phil/phil     51026 2002-07-10 21:49:10 lm_sensors-2.6.4/doc/FAQ
-rw-rw-r-- phil/phil      2875 2002-04-01 21:55:07 lm_sensors-2.6.4/doc/cvs
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/doc/busses/
-rw-rw-r-- phil/phil      1712 2001-11-11 18:40:46 lm_sensors-2.6.4/doc/busses/i2c-ali1535
-rw-rw-r-- phil/phil      4514 2001-09-02 11:25:01 lm_sensors-2.6.4/doc/busses/i2c-ali15x3
-rw-rw-r-- phil/phil       368 2002-05-01 19:33:53 lm_sensors-2.6.4/doc/busses/i2c-amd756
-rw-rw-r-- phil/phil       578 1999-04-30 08:30:04 lm_sensors-2.6.4/doc/busses/i2c-hydra
-rw-rw-r-- phil/phil      2833 2002-07-17 20:51:18 lm_sensors-2.6.4/doc/busses/i2c-i801
-rw-rw-r-- phil/phil      1555 2002-01-05 12:39:11 lm_sensors-2.6.4/doc/busses/i2c-i810
-rw-rw-r-- phil/phil      2857 2001-11-24 14:25:14 lm_sensors-2.6.4/doc/busses/i2c-piix4
-rw-rw-r-- phil/phil       968 2002-04-01 21:01:06 lm_sensors-2.6.4/doc/busses/i2c-savage4
-rw-rw-r-- phil/phil      1673 2002-02-26 21:36:04 lm_sensors-2.6.4/doc/busses/i2c-sis5595
-rw-rw-r-- phil/phil       917 2001-06-01 23:54:59 lm_sensors-2.6.4/doc/busses/i2c-tsunami
-rw-rw-r-- phil/phil      1056 1999-07-23 19:43:13 lm_sensors-2.6.4/doc/busses/i2c-via
-rw-rw-r-- phil/phil      1156 2002-05-27 16:48:46 lm_sensors-2.6.4/doc/busses/i2c-viapro
-rw-rw-r-- phil/phil      2625 2000-01-15 14:10:07 lm_sensors-2.6.4/doc/busses/i2c-voodoo3
-rw-rw-r-- phil/phil      1422 2002-07-11 20:25:43 lm_sensors-2.6.4/doc/donations
-rw-rw-r-- phil/phil      2869 2001-11-27 23:11:44 lm_sensors-2.6.4/doc/fan-divisors
-rw-rw-r-- phil/phil      3059 2002-04-19 23:27:46 lm_sensors-2.6.4/doc/modules
-rw-rw-r-- phil/phil      6263 2002-06-30 19:39:32 lm_sensors-2.6.4/doc/progs
-rw-rw-r-- phil/phil      3744 2001-05-30 22:29:56 lm_sensors-2.6.4/doc/temperature-sensors
-rw-rw-r-- phil/phil     11607 2002-03-13 19:46:23 lm_sensors-2.6.4/doc/useful_addresses.html
-rw-rw-r-- phil/phil      1212 1999-04-22 09:06:24 lm_sensors-2.6.4/doc/version-2
-rw-rw-r-- phil/phil      2733 2002-06-07 19:46:55 lm_sensors-2.6.4/doc/vid
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/doc/chips/
-rw-rw-r-- phil/phil      5467 2002-05-05 12:00:06 lm_sensors-2.6.4/doc/chips/MODPARMS
-rw-rw-r-- phil/phil      4733 2002-07-09 22:10:10 lm_sensors-2.6.4/doc/chips/SUMMARY
-rw-rw-r-- phil/phil     14280 2002-01-30 19:29:44 lm_sensors-2.6.4/doc/chips/adm1021
-rw-rw-r-- phil/phil       295 2001-05-14 23:18:17 lm_sensors-2.6.4/doc/chips/adm1024
-rw-rw-r-- phil/phil       297 2000-05-10 21:35:22 lm_sensors-2.6.4/doc/chips/adm1025
-rw-rw-r-- phil/phil     24652 2000-06-23 01:45:03 lm_sensors-2.6.4/doc/chips/adm9240
-rw-rw-r-- phil/phil     15690 2002-01-29 14:25:37 lm_sensors-2.6.4/doc/chips/bt869
-rw-rw-r-- phil/phil      4814 2001-03-19 22:22:49 lm_sensors-2.6.4/doc/chips/ddcmon
-rw-rw-r-- phil/phil       608 2002-07-09 08:53:49 lm_sensors-2.6.4/doc/chips/ds1307
-rw-rw-r-- phil/phil     10673 2001-07-28 20:17:13 lm_sensors-2.6.4/doc/chips/ds1621
-rw-rw-r-- phil/phil      5989 2001-03-19 22:22:49 lm_sensors-2.6.4/doc/chips/eeprom
-rw-rw-r-- phil/phil      5621 2001-09-18 12:00:23 lm_sensors-2.6.4/doc/chips/fscpos
-rw-rw-r-- phil/phil     10479 2001-11-16 05:21:57 lm_sensors-2.6.4/doc/chips/fscscy
-rw-rw-r-- phil/phil      8812 2002-01-24 22:01:14 lm_sensors-2.6.4/doc/chips/gl518sm
-rw-rw-r-- phil/phil      8104 2000-03-04 11:39:09 lm_sensors-2.6.4/doc/chips/gl520sm
-rw-rw-r-- phil/phil      2936 2000-02-26 19:50:28 lm_sensors-2.6.4/doc/chips/icspll
-rw-rw-r-- phil/phil     11418 2002-01-24 20:22:36 lm_sensors-2.6.4/doc/chips/it87
-rw-rw-r-- phil/phil      3444 2000-03-21 21:39:34 lm_sensors-2.6.4/doc/chips/lm75
-rw-rw-r-- phil/phil     19887 2000-03-04 11:39:09 lm_sensors-2.6.4/doc/chips/lm78
-rw-rw-r-- phil/phil      7960 2000-03-04 11:39:09 lm_sensors-2.6.4/doc/chips/lm80
-rw-rw-r-- phil/phil      5802 2001-01-07 17:13:58 lm_sensors-2.6.4/doc/chips/lm87
-rw-rw-r-- phil/phil      1830 2002-07-12 05:06:20 lm_sensors-2.6.4/doc/chips/lm92
-rw-rw-r-- phil/phil      2545 1999-04-21 10:36:43 lm_sensors-2.6.4/doc/chips/ltc1710
-rw-rw-r-- phil/phil      3790 1999-06-16 21:22:50 lm_sensors-2.6.4/doc/chips/matorb
-rw-rw-r-- phil/phil     20716 2001-05-13 12:44:32 lm_sensors-2.6.4/doc/chips/maxilife
-rw-rw-r-- phil/phil      2468 2001-03-19 20:44:39 lm_sensors-2.6.4/doc/chips/mtp008
-rw-rw-r-- phil/phil      3428 2002-02-10 18:15:12 lm_sensors-2.6.4/doc/chips/pcf8574
-rw-rw-r-- phil/phil      5202 2001-11-27 20:33:26 lm_sensors-2.6.4/doc/chips/pcf8591
-rw-rw-r-- phil/phil      8028 2002-02-26 21:36:04 lm_sensors-2.6.4/doc/chips/sis5595
-rw-rw-r-- phil/phil      1666 2002-07-05 21:36:04 lm_sensors-2.6.4/doc/chips/smbus-arp
-rw-rw-r-- phil/phil      2191 2002-06-30 17:12:33 lm_sensors-2.6.4/doc/chips/smsc74m1
-rw-rw-r-- phil/phil      3497 2001-01-05 21:28:13 lm_sensors-2.6.4/doc/chips/thmc50
-rw-rw-r-- phil/phil      8337 2002-05-27 17:14:10 lm_sensors-2.6.4/doc/chips/via686a
-rw-rw-r-- phil/phil      2601 2002-07-14 21:28:33 lm_sensors-2.6.4/doc/chips/vt1211
-rw-rw-r-- phil/phil     33756 2002-06-28 22:46:50 lm_sensors-2.6.4/doc/chips/w83781d
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/doc/developers/
-rw-rw-r-- phil/phil      4405 2002-01-30 19:46:03 lm_sensors-2.6.4/doc/developers/applications
-rw-rw-r-- phil/phil       935 2002-03-13 19:42:40 lm_sensors-2.6.4/doc/developers/checklist
-rw-rw-r-- phil/phil     18646 1999-04-28 14:18:10 lm_sensors-2.6.4/doc/developers/design
-rwxrwxr-x phil/phil       201 2002-05-11 10:35:53 lm_sensors-2.6.4/doc/developers/editticket
-rwxrwxr-x phil/phil      1143 2001-08-14 22:25:27 lm_sensors-2.6.4/doc/developers/genpasswd.pl
-rw-rw-r-- phil/phil      3240 1998-12-23 20:17:11 lm_sensors-2.6.4/doc/developers/makefiles
-rw-rw-r-- phil/phil      5163 2002-07-13 11:39:34 lm_sensors-2.6.4/doc/developers/new_drivers
-rw-rw-r-- phil/phil      4697 2002-07-11 20:25:43 lm_sensors-2.6.4/doc/developers/proc
-rwxrwxr-x phil/phil       183 2001-01-11 21:00:49 lm_sensors-2.6.4/doc/developers/readticket
-rw-rw-r-- phil/phil       893 1998-12-23 20:17:11 lm_sensors-2.6.4/doc/developers/sysctl
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/doc/kernel/
-rw-rw-r-- phil/phil      3430 1999-01-09 19:58:51 lm_sensors-2.6.4/doc/kernel/file_operations
-rw-rw-r-- phil/phil      5639 1999-01-09 19:58:51 lm_sensors-2.6.4/doc/kernel/proc_dir_entry
-rw-rw-r-- phil/phil      3958 1999-09-20 11:16:57 lm_sensors-2.6.4/BACKGROUND
-rw-rw-r-- phil/phil      6560 2001-09-02 11:25:01 lm_sensors-2.6.4/BUGS
-rw-rw-r-- phil/phil     21547 2002-07-19 16:54:38 lm_sensors-2.6.4/CHANGES
-rw-rw-r-- phil/phil      3391 2002-07-09 08:46:54 lm_sensors-2.6.4/CONTRIBUTORS
-rw-rw-r-- phil/phil     17982 1998-11-18 22:07:17 lm_sensors-2.6.4/COPYING
-rw-rw-r-- phil/phil     15597 2002-07-09 22:20:38 lm_sensors-2.6.4/INSTALL
-rw-rw-r-- phil/phil     10532 2002-04-28 21:37:07 lm_sensors-2.6.4/Makefile
-rw-rw-r-- phil/phil      2100 2002-02-16 19:24:06 lm_sensors-2.6.4/QUICKSTART
-rw-rw-r-- phil/phil      7225 2002-07-09 22:20:38 lm_sensors-2.6.4/README
-rw-rw-r-- phil/phil       730 1999-09-04 12:25:57 lm_sensors-2.6.4/README.directories
-rw-rw-r-- phil/phil       968 2000-02-26 19:50:28 lm_sensors-2.6.4/README.package
-rw-rw-r-- phil/phil       767 2000-02-26 19:50:28 lm_sensors-2.6.4/README.patches
-rw-rw-r-- phil/phil      1131 2001-03-23 15:34:27 lm_sensors-2.6.4/README.thinkpad
-rw-rw-r-- phil/phil      2935 2002-07-17 22:55:22 lm_sensors-2.6.4/TODO
-rw-rw-r-- phil/phil       922 2002-07-19 16:55:08 lm_sensors-2.6.4/lm_sensors.lsm
-rw-rw-r-- phil/phil        54 2002-07-19 16:56:03 lm_sensors-2.6.4/version.h
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/archive/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/etc/
-rw-rw-r-- phil/phil      1345 1999-12-24 14:52:27 lm_sensors-2.6.4/etc/Module.mk
-rw-rw-r-- phil/phil     43407 2002-07-14 21:28:22 lm_sensors-2.6.4/etc/sensors.conf.eg
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/i2c/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/i2c/detect/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/i2c/drivers/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/i2c/eeprom/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/i2c/old-code/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/kernel/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/kernel/busses/
-rw-rw-r-- phil/phil      4500 2002-07-05 20:49:13 lm_sensors-2.6.4/kernel/busses/Module.mk
-rw-rw-r-- phil/phil     19850 2002-06-08 15:49:06 lm_sensors-2.6.4/kernel/busses/i2c-ali1535.c
-rw-rw-r-- phil/phil     18578 2002-06-08 15:49:06 lm_sensors-2.6.4/kernel/busses/i2c-ali15x3.c
-rw-rw-r-- phil/phil     14232 2002-06-08 15:49:06 lm_sensors-2.6.4/kernel/busses/i2c-amd756.c
-rw-rw-r-- phil/phil      4430 2002-07-07 11:45:14 lm_sensors-2.6.4/kernel/busses/i2c-hydra.c
-rw-rw-r-- phil/phil     21138 2002-07-17 20:45:43 lm_sensors-2.6.4/kernel/busses/i2c-i801.c
-rw-rw-r-- phil/phil      8700 2002-07-07 11:45:14 lm_sensors-2.6.4/kernel/busses/i2c-i810.c
-rw-rw-r-- phil/phil      3785 2001-10-13 13:48:43 lm_sensors-2.6.4/kernel/busses/i2c-isa.c
-rw-rw-r-- phil/phil     17239 2002-02-17 19:49:50 lm_sensors-2.6.4/kernel/busses/i2c-keywest.c
-rw-rw-r-- phil/phil      2274 2002-02-17 19:49:50 lm_sensors-2.6.4/kernel/busses/i2c-keywest.h
-rw-rw-r-- phil/phil     15065 2002-06-08 15:49:06 lm_sensors-2.6.4/kernel/busses/i2c-piix4.c
-rw-rw-r-- phil/phil      8470 2002-07-07 11:45:14 lm_sensors-2.6.4/kernel/busses/i2c-savage4.c
-rw-rw-r-- phil/phil     14129 2002-06-08 15:49:06 lm_sensors-2.6.4/kernel/busses/i2c-sis5595.c
-rw-rw-r-- phil/phil      4694 2001-10-13 13:48:43 lm_sensors-2.6.4/kernel/busses/i2c-tsunami.c
-rw-rw-r-- phil/phil      5263 2001-10-13 13:48:43 lm_sensors-2.6.4/kernel/busses/i2c-via.c
-rw-rw-r-- phil/phil     14913 2002-06-08 15:49:06 lm_sensors-2.6.4/kernel/busses/i2c-viapro.c
-rw-rw-r-- phil/phil      8158 2002-07-07 11:45:14 lm_sensors-2.6.4/kernel/busses/i2c-voodoo3.c
-rw-rw-r-- phil/phil      1897 2001-02-05 21:53:46 lm_sensors-2.6.4/kernel/Module.mk
-rw-rw-r-- phil/phil      4329 2002-07-05 14:59:29 lm_sensors-2.6.4/kernel/sensors.c
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/kernel/chips/
-rw-rw-r-- phil/phil      6793 2002-07-05 20:49:13 lm_sensors-2.6.4/kernel/chips/Module.mk
-rw-rw-r-- phil/phil     19892 2001-10-13 13:48:42 lm_sensors-2.6.4/kernel/chips/adm1021.c
-rw-rw-r-- phil/phil     30754 2002-01-13 11:59:19 lm_sensors-2.6.4/kernel/chips/adm1024.c
-rw-rw-r-- phil/phil     24466 2002-06-06 22:58:43 lm_sensors-2.6.4/kernel/chips/adm1025.c
-rw-rw-r-- phil/phil     28057 2001-10-13 13:48:42 lm_sensors-2.6.4/kernel/chips/adm9240.c
-rw-rw-r-- phil/phil     34210 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/bt869.c
-rw-rw-r-- phil/phil     12026 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/ddcmon.c
-rw-rw-r-- phil/phil      8555 2002-07-15 06:08:40 lm_sensors-2.6.4/kernel/chips/ds1307.c
-rw-rw-r-- phil/phil     18477 2001-10-13 13:48:42 lm_sensors-2.6.4/kernel/chips/ds1621.c
-rw-rw-r-- phil/phil     12398 2002-02-16 11:33:57 lm_sensors-2.6.4/kernel/chips/eeprom.c
-rw-rw-r-- phil/phil     24029 2001-10-28 12:06:43 lm_sensors-2.6.4/kernel/chips/fscpos.c
-rw-rw-r-- phil/phil     35222 2001-12-12 11:56:37 lm_sensors-2.6.4/kernel/chips/fscscy.c
-rw-rw-r-- phil/phil     32417 2002-01-24 22:01:14 lm_sensors-2.6.4/kernel/chips/gl518sm.c
-rw-rw-r-- phil/phil     28007 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/gl520sm.c
-rw-rw-r-- phil/phil      9437 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/icspll.c
-rw-rw-r-- phil/phil     29682 2001-10-14 11:18:37 lm_sensors-2.6.4/kernel/chips/it87.c
-rw-rw-r-- phil/phil     11614 2001-10-13 13:48:42 lm_sensors-2.6.4/kernel/chips/lm75.c
-rw-rw-r-- phil/phil     27288 2001-10-13 13:48:42 lm_sensors-2.6.4/kernel/chips/lm78.c
-rw-rw-r-- phil/phil     23519 2001-10-13 13:48:42 lm_sensors-2.6.4/kernel/chips/lm80.c
-rw-rw-r-- phil/phil     33480 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/lm87.c
-rw-rw-r-- phil/phil     10781 2002-07-15 06:08:40 lm_sensors-2.6.4/kernel/chips/lm92.c
-rw-rw-r-- phil/phil     10678 2001-10-13 13:48:42 lm_sensors-2.6.4/kernel/chips/ltc1710.c
-rw-rw-r-- phil/phil      9432 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/matorb.c
-rw-rw-r-- phil/phil     43602 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/maxilife.c
-rw-rw-r-- phil/phil     34655 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/mtp008.c
-rw-rw-r-- phil/phil     11019 2002-02-10 18:15:12 lm_sensors-2.6.4/kernel/chips/pcf8574.c
-rw-rw-r-- phil/phil     19630 2002-02-10 18:15:12 lm_sensors-2.6.4/kernel/chips/pcf8591.c
-rw-rw-r-- phil/phil     27622 2002-02-26 21:36:04 lm_sensors-2.6.4/kernel/chips/sis5595.c
-rw-rw-r-- phil/phil     14290 2002-07-09 21:32:23 lm_sensors-2.6.4/kernel/chips/smbus-arp.c
-rw-rw-r-- phil/phil     15530 2002-07-04 13:15:28 lm_sensors-2.6.4/kernel/chips/smsc47m1.c
-rw-rw-r-- phil/phil     16548 2002-02-09 17:36:26 lm_sensors-2.6.4/kernel/chips/thmc50.c
-rw-rw-r-- phil/phil     34812 2002-07-04 13:14:52 lm_sensors-2.6.4/kernel/chips/via686a.c
-rw-rw-r-- phil/phil     24900 2002-07-17 22:56:06 lm_sensors-2.6.4/kernel/chips/vt1211.c
-rw-rw-r-- phil/phil     71119 2002-06-28 22:46:51 lm_sensors-2.6.4/kernel/chips/w83781d.c
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/kernel/include/
-rw-rw-r-- phil/phil      1770 2001-02-05 21:53:46 lm_sensors-2.6.4/kernel/include/Module.mk
-rw-rw-r-- phil/phil      1625 2002-07-09 08:45:08 lm_sensors-2.6.4/kernel/include/ds1307.h
-rw-rw-r-- phil/phil      1319 2000-01-24 15:37:01 lm_sensors-2.6.4/kernel/include/i2c-isa.h
-rw-rw-r-- phil/phil     23519 2002-07-04 07:35:16 lm_sensors-2.6.4/kernel/include/sensors.h
-rw-rw-r-- phil/phil      2084 2002-04-19 22:59:12 lm_sensors-2.6.4/kernel/include/sensors_vid.h
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/lib/
-rw-rw-r-- phil/phil      4054 2002-03-22 19:53:08 lm_sensors-2.6.4/lib/Module.mk
-rw-rw-r-- phil/phil     16690 2002-07-14 21:42:17 lm_sensors-2.6.4/lib/access.c
-rw-rw-r-- phil/phil      2735 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/access.h
-rw-rw-r-- phil/phil    182620 2002-07-17 20:44:48 lm_sensors-2.6.4/lib/chips.c
-rw-rw-r-- phil/phil     46758 2002-07-14 21:28:22 lm_sensors-2.6.4/lib/chips.h
-rw-rw-r-- phil/phil      5734 1999-12-24 17:44:40 lm_sensors-2.6.4/lib/conf-lex.l
-rw-rw-r-- phil/phil      9154 2002-06-07 21:46:22 lm_sensors-2.6.4/lib/conf-parse.y
-rw-rw-r-- phil/phil      1166 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/conf.h
-rw-rw-r-- phil/phil      7549 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/data.c
-rw-rw-r-- phil/phil      5546 2002-07-09 05:36:06 lm_sensors-2.6.4/lib/data.h
-rw-rw-r-- phil/phil      2298 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/error.c
-rw-rw-r-- phil/phil      2410 2000-02-02 15:19:59 lm_sensors-2.6.4/lib/error.h
-rw-rw-r-- phil/phil      2553 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/general.c
-rw-rw-r-- phil/phil      1818 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/general.h
-rw-rw-r-- phil/phil      4182 1999-12-24 17:44:41 lm_sensors-2.6.4/lib/init.c
-rw-rw-r-- phil/phil      6559 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/libsensors.3
-rw-rw-r-- phil/phil      6265 2001-05-27 18:49:27 lm_sensors-2.6.4/lib/proc.c
-rw-rw-r-- phil/phil      1359 1999-02-08 17:50:28 lm_sensors-2.6.4/lib/proc.h
-rw-rw-r-- phil/phil     10992 1999-12-24 17:44:41 lm_sensors-2.6.4/lib/sensors.conf.5
-rw-rw-r-- phil/phil      5980 2000-02-02 15:19:59 lm_sensors-2.6.4/lib/sensors.h
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/mkpatch/
-rw-rw-r-- phil/phil      3039 2001-12-12 14:25:19 lm_sensors-2.6.4/mkpatch/Config.in
-rw-rw-r-- phil/phil      2309 2002-07-05 14:05:46 lm_sensors-2.6.4/mkpatch/FILES
-rw-rw-r-- phil/phil       101 2002-04-19 22:59:12 lm_sensors-2.6.4/mkpatch/INCLUDES
-rw-rw-r-- phil/phil      1134 1999-09-27 06:52:50 lm_sensors-2.6.4/mkpatch/Module.mk
-rwxrwxr-x phil/phil     45759 2002-07-05 14:59:29 lm_sensors-2.6.4/mkpatch/mkpatch.pl
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/config/
-rwxrwxr-x phil/phil       698 1998-12-23 20:22:19 lm_sensors-2.6.4/prog/config/grab_busses.sh
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/daemon/
-rwxrwxr-x phil/phil      1187 1999-02-15 00:42:01 lm_sensors-2.6.4/prog/daemon/healthd.sh
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/detect/
-rw-rw-r-- phil/phil      1854 1999-12-24 14:52:27 lm_sensors-2.6.4/prog/detect/Module.mk
-rw-rw-r-- phil/phil      4687 2001-03-31 14:00:45 lm_sensors-2.6.4/prog/detect/i2cdetect.c
-rwxrwxr-x phil/phil     97711 2002-07-09 21:34:32 lm_sensors-2.6.4/prog/detect/sensors-detect
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/doc/
-rwxrwxr-x phil/phil      9599 1999-04-15 18:19:59 lm_sensors-2.6.4/prog/doc/doc-features.pl
-rwxrwxr-x phil/phil      2493 1999-04-15 18:19:59 lm_sensors-2.6.4/prog/doc/doc-insmod.pl
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/dump/
-rw-rw-r-- phil/phil      1694 2001-04-02 22:39:23 lm_sensors-2.6.4/prog/dump/Module.mk
-rw-rw-r-- phil/phil     11991 2002-07-10 22:24:56 lm_sensors-2.6.4/prog/dump/i2cdump.c
-rw-rw-r-- phil/phil      7035 2001-06-24 16:33:14 lm_sensors-2.6.4/prog/dump/i2cset.c
-rw-rw-r-- phil/phil      5010 2001-10-13 12:37:16 lm_sensors-2.6.4/prog/dump/isadump.c
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/eeprom/
-rwxrwxr-x phil/phil     17647 2002-02-16 11:41:54 lm_sensors-2.6.4/prog/eeprom/decode-dimms.pl
-rwxrwxr-x phil/phil      4124 2002-02-17 19:43:24 lm_sensors-2.6.4/prog/eeprom/decode-vaio.pl
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/eepromer/
-rw-rw-r-- phil/phil       140 2002-04-28 20:47:41 lm_sensors-2.6.4/prog/eepromer/Makefile
-rw-rw-r-- phil/phil      1360 2002-04-28 20:47:41 lm_sensors-2.6.4/prog/eepromer/README
-rw-rw-r-- phil/phil      3475 2002-04-28 20:47:41 lm_sensors-2.6.4/prog/eepromer/README.eeprom
-rw-rw-r-- phil/phil       837 2001-12-18 19:32:08 lm_sensors-2.6.4/prog/eepromer/README.eepromer
-rw-rw-r-- phil/phil      8274 2002-05-05 14:03:27 lm_sensors-2.6.4/prog/eepromer/eeprom.c
-rw-rw-r-- phil/phil     14031 2001-08-14 22:13:27 lm_sensors-2.6.4/prog/eepromer/eepromer.c
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/hotplug/
-rw-rw-r-- phil/phil       553 2001-03-24 13:35:13 lm_sensors-2.6.4/prog/hotplug/Makefile
-rw-rw-r-- phil/phil       781 2002-02-26 21:47:04 lm_sensors-2.6.4/prog/hotplug/Makefile.p4b
-rw-rw-r-- phil/phil      3910 2002-06-27 22:49:46 lm_sensors-2.6.4/prog/hotplug/README
-rw-rw-r-- phil/phil      2148 2002-06-27 22:49:46 lm_sensors-2.6.4/prog/hotplug/README.p4b
-rw-rw-r-- phil/phil      9969 2002-02-26 22:43:32 lm_sensors-2.6.4/prog/hotplug/m7101.c
-rw-rw-r-- phil/phil      7620 2002-06-27 22:49:46 lm_sensors-2.6.4/prog/hotplug/p4b_smbus.c
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/init/
-rwxrwxr-x phil/phil      4318 2002-06-30 19:31:50 lm_sensors-2.6.4/prog/init/sensord.init
-rw-rw-r-- phil/phil      1354 2002-06-30 19:35:22 lm_sensors-2.6.4/prog/init/README
-rwxrwxr-x phil/phil      2965 2002-06-30 19:35:22 lm_sensors-2.6.4/prog/init/lm_sensors.init
-rwxrwxr-x phil/phil      1152 2002-06-30 19:35:22 lm_sensors-2.6.4/prog/init/lm_sensors.sysconfig
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/matorb/
-rwxrwxr-x phil/phil       784 1999-06-18 01:07:24 lm_sensors-2.6.4/prog/matorb/displayit.pl
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/maxilife/
-rw-rw-r-- phil/phil       459 2000-04-15 13:26:58 lm_sensors-2.6.4/prog/maxilife/sysinfo.sh
-rw-rw-r-- phil/phil       407 2000-04-15 13:26:58 lm_sensors-2.6.4/prog/maxilife/writelcd.sh
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/mkdev/
-rwxrwxr-x phil/phil       376 1999-01-13 15:09:44 lm_sensors-2.6.4/prog/mkdev/mkdev.sh
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/rrd/
-rw-rw-r-- phil/phil      1762 2002-01-05 10:39:17 lm_sensors-2.6.4/prog/rrd/Makefile
-rw-rw-r-- phil/phil      3852 2001-04-07 17:07:08 lm_sensors-2.6.4/prog/rrd/README
-rwxrwxr-x phil/phil      1632 2001-03-30 23:53:45 lm_sensors-2.6.4/prog/rrd/sens_create_rrd
-rw-rw-r-- phil/phil      4927 2001-04-07 14:58:59 lm_sensors-2.6.4/prog/rrd/sens_day.in
-rwxrwxr-x phil/phil      2277 2001-03-30 23:53:45 lm_sensors-2.6.4/prog/rrd/sens_update_rrd
-rw-rw-r-- phil/phil      4897 2001-04-07 14:58:59 lm_sensors-2.6.4/prog/rrd/sens_week.in
-rw-rw-r-- phil/phil      2518 2002-05-05 11:58:20 lm_sensors-2.6.4/prog/rrd/summ_week.in
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/sensord/
-rw-rw-r-- phil/phil      2440 2002-04-28 10:26:07 lm_sensors-2.6.4/prog/sensord/Module.mk
-rw-rw-r-- phil/phil       365 2002-04-28 10:26:07 lm_sensors-2.6.4/prog/sensord/README
-rw-rw-r-- phil/phil      9111 2002-04-27 20:21:49 lm_sensors-2.6.4/prog/sensord/args.c
-rw-rw-r-- phil/phil     34648 2002-04-27 20:21:49 lm_sensors-2.6.4/prog/sensord/chips.c
-rw-rw-r-- phil/phil      3531 2002-04-27 20:21:49 lm_sensors-2.6.4/prog/sensord/lib.c
-rw-rw-r-- phil/phil      9068 2002-04-27 20:21:49 lm_sensors-2.6.4/prog/sensord/rrd.c
-rw-rw-r-- phil/phil      8683 2002-04-27 20:21:49 lm_sensors-2.6.4/prog/sensord/sense.c
-rw-rw-r-- phil/phil     13461 2002-04-27 20:21:49 lm_sensors-2.6.4/prog/sensord/sensord.8
-rw-rw-r-- phil/phil      4682 2002-06-10 13:56:16 lm_sensors-2.6.4/prog/sensord/sensord.c
-rw-rw-r-- phil/phil      2758 2002-04-27 20:21:49 lm_sensors-2.6.4/prog/sensord/sensord.h
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/sensors/
-rw-rw-r-- phil/phil      2185 1999-12-24 14:52:28 lm_sensors-2.6.4/prog/sensors/Module.mk
-rw-rw-r-- phil/phil    129293 2002-07-12 05:11:05 lm_sensors-2.6.4/prog/sensors/chips.c
-rw-rw-r-- phil/phil      2405 2002-07-10 07:57:13 lm_sensors-2.6.4/prog/sensors/chips.h
-rw-rw-r-- phil/phil     10767 2002-07-10 07:57:13 lm_sensors-2.6.4/prog/sensors/main.c
-rw-rw-r-- phil/phil      2663 2002-06-21 23:34:07 lm_sensors-2.6.4/prog/sensors/sensors.1
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/tellerstats/
-rwxrwxr-x phil/phil      3959 2001-03-30 23:50:25 lm_sensors-2.6.4/prog/tellerstats/gather.sh
-rw-rw-r-- phil/phil       975 2001-03-30 23:50:25 lm_sensors-2.6.4/prog/tellerstats/README
-rw-rw-r-- phil/phil      3916 2001-03-30 23:50:25 lm_sensors-2.6.4/prog/tellerstats/gnuplotscript.tmpl
-rw-rw-r-- phil/phil      2460 2001-03-30 23:50:25 lm_sensors-2.6.4/prog/tellerstats/index.shtml
-rw-rw-r-- phil/phil       854 2001-03-30 23:50:25 lm_sensors-2.6.4/prog/tellerstats/tellerstats.conf
-rwxrwxr-x phil/phil      3693 2001-03-30 23:50:25 lm_sensors-2.6.4/prog/tellerstats/tellerstats.sh
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/prog/xeon/
-rwxrwxr-x phil/phil      6366 2002-02-16 11:41:54 lm_sensors-2.6.4/prog/xeon/decode-xeon.pl
drwxrwxr-x phil/phil         0 2002-07-19 16:59:19 lm_sensors-2.6.4/src/
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd lm_sensors-2.6.4
++ /usr/bin/id -u
+ '[' 500 = 0 ']'
++ /usr/bin/id -u
+ '[' 500 = 0 ']'
+ /bin/chmod -Rf a+rX,g-w,o-w .
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.66131
+ umask 022
+ cd /home/ben/programming/rpm/BUILD
+ cd lm_sensors-2.6.4
+ make -j4 I2C_HEADERS=/usr/include/linux
Makefile:221: kernel/busses/i2c-ali1535.d: No such file or directory
Makefile:221: kernel/busses/i2c-ali15x3.d: No such file or directory
Makefile:221: kernel/busses/i2c-amd756.d: No such file or directory
Makefile:221: kernel/busses/i2c-hydra.d: No such file or directory
Makefile:221: kernel/busses/i2c-i801.d: No such file or directory
Makefile:221: kernel/busses/i2c-i810.d: No such file or directory
Makefile:221: kernel/busses/i2c-isa.d: No such file or directory
Makefile:221: kernel/busses/i2c-sis5595.d: No such file or directory
Makefile:221: kernel/busses/i2c-piix4.d: No such file or directory
Makefile:221: kernel/busses/i2c-savage4.d: No such file or directory
Makefile:221: kernel/busses/i2c-via.d: No such file or directory
Makefile:221: kernel/busses/i2c-viapro.d: No such file or directory
Makefile:221: kernel/busses/i2c-voodoo3.d: No such file or directory
Makefile:221: kernel/chips/smbus-arp.d: No such file or directory
Makefile:221: kernel/chips/adm1021.d: No such file or directory
Makefile:221: kernel/chips/adm1024.d: No such file or directory
Makefile:221: kernel/chips/adm1025.d: No such file or directory
Makefile:221: kernel/chips/adm9240.d: No such file or directory
Makefile:221: kernel/chips/bt869.d: No such file or directory
Makefile:221: kernel/chips/ddcmon.d: No such file or directory
Makefile:221: kernel/chips/ds1621.d: No such file or directory
Makefile:221: kernel/chips/eeprom.d: No such file or directory
Makefile:221: kernel/chips/fscpos.d: No such file or directory
Makefile:221: kernel/chips/fscscy.d: No such file or directory
Makefile:221: kernel/chips/gl518sm.d: No such file or directory
Makefile:221: kernel/chips/gl520sm.d: No such file or directory
Makefile:221: kernel/chips/it87.d: No such file or directory
Makefile:221: kernel/chips/lm75.d: No such file or directory
Makefile:221: kernel/chips/lm78.d: No such file or directory
Makefile:221: kernel/chips/lm80.d: No such file or directory
Makefile:221: kernel/chips/lm87.d: No such file or directory
Makefile:221: kernel/chips/lm92.d: No such file or directory
Makefile:221: kernel/chips/ltc1710.d: No such file or directory
Makefile:221: kernel/chips/matorb.d: No such file or directory
Makefile:221: kernel/chips/maxilife.d: No such file or directory
Makefile:221: kernel/chips/mtp008.d: No such file or directory
Makefile:221: kernel/chips/pcf8574.d: No such file or directory
Makefile:221: kernel/chips/pcf8591.d: No such file or directory
Makefile:221: kernel/chips/sis5595.d: No such file or directory
Makefile:221: kernel/chips/smsc47m1.d: No such file or directory
Makefile:221: kernel/chips/thmc50.d: No such file or directory
Makefile:221: kernel/chips/w83781d.d: No such file or directory
Makefile:221: kernel/chips/via686a.d: No such file or directory
Makefile:221: kernel/chips/vt1211.d: No such file or directory
Makefile:221: lib/data.ld: No such file or directory
Makefile:221: lib/general.ld: No such file or directory
Makefile:221: lib/error.ld: No such file or directory
Makefile:221: lib/chips.ld: No such file or directory
Makefile:221: lib/proc.ld: No such file or directory
Makefile:221: lib/access.ld: No such file or directory
Makefile:221: lib/init.ld: No such file or directory
Makefile:221: lib/data.ad: No such file or directory
Makefile:221: lib/general.ad: No such file or directory
Makefile:221: lib/error.ad: No such file or directory
Makefile:221: lib/chips.ad: No such file or directory
Makefile:221: lib/proc.ad: No such file or directory
Makefile:221: lib/access.ad: No such file or directory
Makefile:221: lib/init.ad: No such file or directory
Makefile:221: prog/sensors/main.rd: No such file or directory
Makefile:221: prog/sensors/chips.rd: No such file or directory
Makefile:221: prog/dump/isadump.rd: No such file or directory
Makefile:221: prog/dump/i2cdump.rd: No such file or directory
Makefile:221: prog/dump/i2cset.rd: No such file or directory
Makefile:221: prog/detect/i2cdetect.rd: No such file or directory
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   prog/detect/i2cdetect.c | \
       	sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd prog/detect/i2cdetect.ro: Makefile '`dirname prog/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2cdetect.rd
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   prog/dump/i2cset.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/i2cset.rd prog/dump/i2cset.ro: Makefile '`dirname prog/dump/i2cset.rd`/Module.mk' @' > prog/dump/i2cset.rd
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   prog/dump/i2cdump.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd prog/dump/i2cdump.ro: Makefile '`dirname prog/dump/i2cdump.rd`/Module.mk' @' > prog/dump/i2cdump.rd
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   prog/dump/isadump.c | \
       	sed -e 's@^\(.*\)\.o:@prog/dump/isadump.rd prog/dump/isadump.ro: Makefile '`dirname prog/dump/isadump.rd`/Module.mk' @' > prog/dump/isadump.rd
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   prog/sensors/chips.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd prog/sensors/chips.ro: Makefile '`dirname prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   prog/sensors/main.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/main.rd prog/sensors/main.ro: Makefile '`dirname prog/sensors/main.rd`/Module.mk' @' > prog/sensors/main.rd
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   lib/init.c | \
       	sed -e 's@^\(.*\)\.o:@lib/init.ad lib/init.ao: Makefile '`dirname lib/init.ad`/Module.mk' @' > lib/init.ad
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   lib/access.c | \
       	sed -e 's@^\(.*\)\.o:@lib/access.ad lib/access.ao: Makefile '`dirname lib/access.ad`/Module.mk' @' > lib/access.ad
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ad lib/proc.ao: Makefile '`dirname lib/proc.ad`/Module.mk' @' > lib/proc.ad
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ad lib/chips.ao: Makefile '`dirname lib/chips.ad`/Module.mk' @' > lib/chips.ad
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   lib/error.c | \
       	sed -e 's@^\(.*\)\.o:@lib/error.ad lib/error.ao: Makefile '`dirname lib/error.ad`/Module.mk' @' > lib/error.ad
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   lib/general.c | \
       	sed -e 's@^\(.*\)\.o:@lib/general.ad lib/general.ao: Makefile '`dirname lib/general.ad`/Module.mk' @' > lib/general.ad
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   lib/data.c | \
       	sed -e 's@^\(.*\)\.o:@lib/data.ad lib/data.ao: Makefile '`dirname lib/data.ad`/Module.mk' @' > lib/data.ad
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -fpic -O2   lib/init.c | \
       	sed -e 's@^\(.*\)\.o:@lib/init.ld lib/init.lo: Makefile '`dirname lib/init.ld`/Module.mk' @' > lib/init.ld
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -fpic -O2   lib/access.c | \
       	sed -e 's@^\(.*\)\.o:@lib/access.ld lib/access.lo: Makefile '`dirname lib/access.ld`/Module.mk' @' > lib/access.ld
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -fpic -O2   lib/proc.c | \
       	sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile '`dirname lib/proc.ld`/Module.mk' @' > lib/proc.ld
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -fpic -O2   lib/chips.c | \
       	sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile '`dirname lib/chips.ld`/Module.mk' @' > lib/chips.ld
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -fpic -O2   lib/error.c | \
       	sed -e 's@^\(.*\)\.o:@lib/error.ld lib/error.lo: Makefile '`dirname lib/error.ld`/Module.mk' @' > lib/error.ld
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -fpic -O2   lib/general.c | \
       	sed -e 's@^\(.*\)\.o:@lib/general.ld lib/general.lo: Makefile '`dirname lib/general.ld`/Module.mk' @' > lib/general.ld
gcc -M -MG -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -fpic -O2   lib/data.c | \
       	sed -e 's@^\(.*\)\.o:@lib/data.ld lib/data.lo: Makefile '`dirname lib/data.ld`/Module.mk' @' > lib/data.ld
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/vt1211.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/vt1211.d kernel/chips/vt1211.o: Makefile '`dirname kernel/chips/vt1211.d`/Module.mk' @' > kernel/chips/vt1211.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/via686a.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/via686a.d kernel/chips/via686a.o: Makefile '`dirname kernel/chips/via686a.d`/Module.mk' @' > kernel/chips/via686a.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/w83781d.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/w83781d.d kernel/chips/w83781d.o: Makefile '`dirname kernel/chips/w83781d.d`/Module.mk' @' > kernel/chips/w83781d.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/thmc50.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/thmc50.d kernel/chips/thmc50.o: Makefile '`dirname kernel/chips/thmc50.d`/Module.mk' @' > kernel/chips/thmc50.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/smsc47m1.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/smsc47m1.d kernel/chips/smsc47m1.o: Makefile '`dirname kernel/chips/smsc47m1.d`/Module.mk' @' > kernel/chips/smsc47m1.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/sis5595.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/sis5595.d kernel/chips/sis5595.o: Makefile '`dirname kernel/chips/sis5595.d`/Module.mk' @' > kernel/chips/sis5595.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/pcf8591.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8591.d kernel/chips/pcf8591.o: Makefile '`dirname kernel/chips/pcf8591.d`/Module.mk' @' > kernel/chips/pcf8591.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/pcf8574.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/pcf8574.d kernel/chips/pcf8574.o: Makefile '`dirname kernel/chips/pcf8574.d`/Module.mk' @' > kernel/chips/pcf8574.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/mtp008.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/mtp008.d kernel/chips/mtp008.o: Makefile '`dirname kernel/chips/mtp008.d`/Module.mk' @' > kernel/chips/mtp008.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/maxilife.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/maxilife.d kernel/chips/maxilife.o: Makefile '`dirname kernel/chips/maxilife.d`/Module.mk' @' > kernel/chips/maxilife.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/matorb.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/matorb.d kernel/chips/matorb.o: Makefile '`dirname kernel/chips/matorb.d`/Module.mk' @' > kernel/chips/matorb.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/ltc1710.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ltc1710.d kernel/chips/ltc1710.o: Makefile '`dirname kernel/chips/ltc1710.d`/Module.mk' @' > kernel/chips/ltc1710.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/lm92.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm92.d kernel/chips/lm92.o: Makefile '`dirname kernel/chips/lm92.d`/Module.mk' @' > kernel/chips/lm92.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/lm87.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm87.d kernel/chips/lm87.o: Makefile '`dirname kernel/chips/lm87.d`/Module.mk' @' > kernel/chips/lm87.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/lm80.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm80.d kernel/chips/lm80.o: Makefile '`dirname kernel/chips/lm80.d`/Module.mk' @' > kernel/chips/lm80.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/lm78.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm78.d kernel/chips/lm78.o: Makefile '`dirname kernel/chips/lm78.d`/Module.mk' @' > kernel/chips/lm78.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/lm75.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/lm75.d kernel/chips/lm75.o: Makefile '`dirname kernel/chips/lm75.d`/Module.mk' @' > kernel/chips/lm75.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/li
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/gl518sm.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/gl518sm.d kernel/chips/gl518sm.o: Makefile '`dirname kernel/chips/gl518sm.d`/Module.mk' @' > kernel/chips/gl518sm.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/fscscy.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/fscscy.d kernel/chips/fscscy.o: Makefile '`dirname kernel/chips/fscscy.d`/Module.mk' @' > kernel/chips/fscscy.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/fscpos.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/fscpos.d kernel/chips/fscpos.o: Makefile '`dirname kernel/chips/fscpos.d`/Module.mk' @' > kernel/chips/fscpos.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/eeprom.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/eeprom.d kernel/chips/eeprom.o: Makefile '`dirname kernel/chips/eeprom.d`/Module.mk' @' > kernel/chips/eeprom.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/ds1621.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ds1621.d kernel/chips/ds1621.o: Makefile '`dirname kernel/chips/ds1621.d`/Module.mk' @' > kernel/chips/ds1621.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/ddcmon.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/ddcmon.d kernel/chips/ddcmon.o: Makefile '`dirname kernel/chips/ddcmon.d`/Module.mk' @' > kernel/chips/ddcmon.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/bt869.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/bt869.d kernel/chips/bt869.o: Makefile '`dirname kernel/chips/bt869.d`/Module.mk' @' > kernel/chips/bt869.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/adm9240.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm9240.d kernel/chips/adm9240.o: Makefile '`dirname kernel/chips/adm9240.d`/Module.mk' @' > kernel/chips/adm9240.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/adm1025.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1025.d kernel/chips/adm1025.o: Makefile '`dirname kernel/chips/adm1025.d`/Module.mk' @' > kernel/chips/adm1025.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/adm1024.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1024.d kernel/chips/adm1024.o: Makefile '`dirname kernel/chips/adm1024.d`/Module.mk' @' > kernel/chips/adm1024.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/adm1021.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/adm1021.d kernel/chips/adm1021.o: Makefile '`dirname kernel/chips/adm1021.d`/Module.mk' @' > kernel/chips/adm1021.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/chips/smbus-arp.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/chips/smbus-arp.d kernel/chips/smbus-arp.o: Makefile '`dirname kernel/chips/smbus-arp.d`/Module.mk' @' > kernel/chips/smbus-arp.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-voodoo3.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-voodoo3.d kernel/busses/i2c-voodoo3.o: Makefile '`dirname kernel/busses/i2c-voodoo3.d`/Module.mk' @' > kernel/busses/i2c-voodoo3.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-viapro.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-viapro.d kernel/busses/i2c-viapro.o: Makefile '`dirname kernel/busses/i2c-viapro.d`/Module.mk' @' > kernel/busses/i2c-viapro.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-via.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-via.d kernel/busses/i2c-via.o: Makefile '`dirname kernel/busses/i2c-via.d`/Module.mk' @' > kernel/busses/i2c-via.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-savage4.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-savage4.d kernel/busses/i2c-savage4.o: Makefile '`dirname kernel/busses/i2c-savage4.d`/Module.mk' @' > kernel/busses/i2c-savage4.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-piix4.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-piix4.d kernel/busses/i2c-piix4.o: Makefile '`dirname kernel/busses/i2c-piix4.d`/Module.mk' @' > kernel/busses/i2c-piix4.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-sis5595.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-sis5595.d kernel/busses/i2c-sis5595.o: Makefile '`dirname kernel/busses/i2c-sis5595.d`/Module.mk' @' > kernel/busses/i2c-sis5595.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-isa.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-isa.d kernel/busses/i2c-isa.o: Makefile '`dirname kernel/busses/i2c-isa.d`/Module.mk' @' > kernel/busses/i2c-isa.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-i810.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i810.d kernel/busses/i2c-i810.o: Makefile '`dirname kernel/busses/i2c-i810.d`/Module.mk' @' > kernel/busses/i2c-i810.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-i801.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-i801.d kernel/busses/i2c-i801.o: Makefile '`dirname kernel/busses/i2c-i801.d`/Module.mk' @' > kernel/busses/i2c-i801.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-hydra.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-hydra.d kernel/busses/i2c-hydra.o: Makefile '`dirname kernel/busses/i2c-hydra.d`/Module.mk' @' > kernel/busses/i2c-hydra.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-amd756.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-amd756.d kernel/busses/i2c-amd756.o: Makefile '`dirname kernel/busses/i2c-amd756.d`/Module.mk' @' > kernel/busses/i2c-amd756.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-ali15x3.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali15x3.d kernel/busses/i2c-ali15x3.o: Makefile '`dirname kernel/busses/i2c-ali15x3.d`/Module.mk' @' > kernel/busses/i2c-ali15x3.d
gcc -M -MG  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   kernel/busses/i2c-ali1535.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d kernel/busses/i2c-ali1535.o: Makefile '`dirname kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-ali15x3.c -o kernel/busses/i2c-ali15x3.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-amd756.c -o kernel/busses/i2c-amd756.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-hydra.c -o kernel/busses/i2c-hydra.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-i801.c -o kernel/busses/i2c-i801.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-i810.c -o kernel/busses/i2c-i810.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-isa.c -o kernel/busses/i2c-isa.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-sis5595.c -o kernel/busses/i2c-sis5595.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-piix4.c -o kernel/busses/i2c-piix4.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-savage4.c -o kernel/busses/i2c-savage4.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-via.c -o kernel/busses/i2c-via.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-viapro.c -o kernel/busses/i2c-viapro.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-voodoo3.c -o kernel/busses/i2c-voodoo3.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/smbus-arp.c -o kernel/chips/smbus-arp.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/adm1021.c -o kernel/chips/adm1021.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/adm1024.c -o kernel/chips/adm1024.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/adm1025.c -o kernel/chips/adm1025.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/adm9240.c -o kernel/chips/adm9240.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/bt869.c -o kernel/chips/bt869.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/ddcmon.c -o kernel/chips/ddcmon.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/ds1621.c -o kernel/chips/ds1621.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/eeprom.c -o kernel/chips/eeprom.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/fscpos.c -o kernel/chips/fscpos.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/fscscy.c -o kernel/chips/fscscy.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/gl518sm.c -o kernel/chips/gl518sm.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/gl520sm.c -o kernel/chips/gl520sm.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/it87.c -o kernel/chips/it87.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/lm75.c -o kernel/chips/lm75.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/lm78.c -o kernel/chips/lm78.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/lm80.c -o kernel/chips/lm80.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/lm87.c -o kernel/chips/lm87.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/lm92.c -o kernel/chips/lm92.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/ltc1710.c -o kernel/chips/ltc1710.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/matorb.c -o kernel/chips/matorb.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/maxilife.c -o kernel/chips/maxilife.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/mtp008.c -o kernel/chips/mtp008.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/pcf8574.c -o kernel/chips/pcf8574.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/pcf8591.c -o kernel/chips/pcf8591.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/sis5595.c -o kernel/chips/sis5595.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/smsc47m1.c -o kernel/chips/smsc47m1.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/thmc50.c -o kernel/chips/thmc50.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/w83781d.c -o kernel/chips/w83781d.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/via686a.c -o kernel/chips/via686a.o
gcc  -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include   -O2   -c kernel/chips/vt1211.c -o kernel/chips/vt1211.o
gcc -I. -Ikernel/include -I/usr/include/linux -I/usr/src/linux/include  -O2   -c lib/data.c -o lib/data.ao
In file included from lib/data.c:20:
/usr/include/stdlib.h:133: parse error before `__ctype_get_mb_cur_max'
/usr/include/stdlib.h:133: warning: data definition has no type or storage class
In file included from /usr/include/bits/types.h:143,
                 from /usr/include/sys/types.h:30,
                 from /usr/include/stdlib.h:390,
                 from lib/data.c:20:
/usr/include/bits/pthreadtypes.h:48: parse error before `size_t'
/usr/include/bits/pthreadtypes.h:48: warning: no semicolon at end of struct or union
/usr/include/bits/pthreadtypes.h:51: parse error before `__stacksize'
/usr/include/bits/pthreadtypes.h:51: warning: data definition has no type or storage class
/usr/include/bits/pthreadtypes.h:52: warning: data definition has no type or storage class
In file included from /usr/include/sys/types.h:132,
                 from /usr/include/stdlib.h:390,
                 from lib/data.c:20:
/usr/include/linux/time.h:10: parse error before `time_t'
/usr/include/linux/time.h:10: warning: no semicolon at end of struct or union
/usr/include/linux/time.h:12: parse error before `}'
/usr/include/linux/time.h:89: parse error before `time_t'
/usr/include/linux/time.h:89: warning: no semicolon at end of struct or union
/usr/include/linux/time.h:90: warning: data definition has no type or storage class
/usr/include/linux/time.h:120: field `it_interval' has incomplete type
/usr/include/linux/time.h:121: field `it_value' has incomplete type
/usr/include/linux/time.h:125: field `it_interval' has incomplete type
/usr/include/linux/time.h:126: field `it_value' has incomplete type
In file included from lib/data.c:20:
/usr/include/stdlib.h:407: parse error before `size_t'
/usr/include/stdlib.h:436: parse error before `size_t'
/usr/include/stdlib.h:527: parse error before `__size'
/usr/include/stdlib.h:529: parse error before `__nmemb'
/usr/include/stdlib.h:536: parse error before `size_t'
In file included from /usr/include/stdlib.h:546,
                 from lib/data.c:20:
/usr/include/alloca.h:33: parse error before `__size'
In file included from lib/data.c:20:
/usr/include/stdlib.h:551: parse error before `__size'
/usr/include/stdlib.h:690: parse error before `size_t'
/usr/include/stdlib.h:694: parse error before `size_t'
/usr/include/stdlib.h:756: parse error before `size_t'
/usr/include/stdlib.h:759: parse error before `size_t'
/usr/include/stdlib.h:763: parse error before `size_t'
/usr/include/stdlib.h:766: parse error before `size_t'
/usr/include/stdlib.h:773: parse error before `size_t'
/usr/include/stdlib.h:776: parse error before `*'
/usr/include/stdlib.h:780: parse error before `wchar_t'
/usr/include/stdlib.h:784: parse error before `mbstowcs'
/usr/include/stdlib.h:784: parse error before `*'
/usr/include/stdlib.h:785: warning: data definition has no type or storage class
/usr/include/stdlib.h:787: parse error before `wcstombs'
/usr/include/stdlib.h:788: parse error before `*'
/usr/include/stdlib.h:789: warning: data definition has no type or storage class
In file included from /usr/include/_G_config.h:44,
                 from /usr/include/libio.h:32,
                 from /usr/include/stdio.h:65,
                 from lib/sensors.h:23,
                 from lib/data.h:23,
                 from lib/data.c:24:
/usr/include/gconv.h:72: parse error before `size_t'
/usr/include/gconv.h:85: parse error before `size_t'
/usr/include/gconv.h:94: parse error before `size_t'
/usr/include/gconv.h:170: parse error before `size_t'
/usr/include/gconv.h:170: warning: no semicolon at end of struct or union
/usr/include/gconv.h:173: parse error before `}'
/usr/include/gconv.h:173: warning: data definition has no type or storage class
In file included from /usr/include/libio.h:32,
                 from /usr/include/stdio.h:65,
                 from lib/sensors.h:23,
                 from lib/data.h:23,
                 from lib/data.c:24:
/usr/include/_G_config.h:47: field `__cd' has incomplete type
/usr/include/_G_config.h:50: field `__cd' has incomplete type
In file included from /usr/include/stdio.h:65,
                 from lib/sensors.h:23,
                 from lib/data.h:23,
                 from lib/data.c:24:
/usr/include/libio.h:344: parse error before `size_t'
/usr/include/libio.h:353: parse error before `size_t'
/usr/include/libio.h:461: parse error before `_IO_sgetn'
/usr/include/libio.h:461: parse error before `size_t'
/usr/include/libio.h:461: warning: data definition has no type or storage class
In file included from lib/sensors.h:23,
                 from lib/data.h:23,
                 from lib/data.c:24:
/usr/include/stdio.h:261: parse error before `size_t'
/usr/include/stdio.h:267: parse error before `size_t'
/usr/include/stdio.h:295: parse error before `size_t'
/usr/include/stdio.h:299: parse error before `size_t'
/usr/include/stdio.h:461: parse error before `fread'
/usr/include/stdio.h:461: parse error before `size_t'
/usr/include/stdio.h:462: warning: data definition has no type or storage class
/usr/include/stdio.h:464: parse error before `fwrite'
/usr/include/stdio.h:464: parse error before `size_t'
/usr/include/stdio.h:465: warning: data definition has no type or storage class
/usr/include/stdio.h:469: parse error before `fread_unlocked'
/usr/include/stdio.h:469: parse error before `size_t'
/usr/include/stdio.h:470: warning: data definition has no type or storage class
/usr/include/stdio.h:471: parse error before `fwrite_unlocked'
/usr/include/stdio.h:471: parse error before `size_t'
/usr/include/stdio.h:472: warning: data definition has no type or storage class
lib/data.c: In function `sensors_parse_chip_name':
lib/data.c:67: warning: initialization makes pointer from integer without a cast
lib/data.c:73: warning: assignment makes pointer from integer without a cast
lib/data.c:75: warning: assignment makes pointer from integer without a cast
lib/data.c:77: warning: assignment makes pointer from integer without a cast
lib/data.c:161: warning: assignment makes pointer from integer without a cast
make: *** [lib/data.ao] Error 1
make: *** Waiting for unfinished jobs....
error: Bad exit status from /var/tmp/rpm-tmp.66131 (%build)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.66131 (%build)
[ben@mach1 SPECS] $ 
---------------------------------------------------

Thanks for your help,
Ben

-- 
Ben Logan: ben at wblogan dot net
OpenPGP Key KeyID: A1ADD1F0
-------------- next part --------------
#  Makefile - Makefile for a Linux module for reading sensor data.
#  Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# Everything you may want to change is in the top of this file. Usually, you
# can just use the defaults, fortunately.

# You need a full complement of GNU utilities to run this Makefile succesfully;
# most notably, you need bash, GNU make, flex (>= 2.5.1) and bison.

# If your /bin/sh is not bash, change the below definition so that make can
# find bash. Or you can hope your sh-like shell understands all scripts.
# I think so, but I have not tested it.
# SHELL=/usr/bin/bash

# The location of linux itself. This is used to find the kernel headers
# and other things.
LINUX=/usr/src/linux
LINUX_HEADERS=$(LINUX)/include

# Determine whether we need to compile the kernel modules, or only the
# user-space utilities. By default, the kernel modules are compiled.
#COMPILE_KERNEL := 0
COMPILE_KERNEL := 1

# If you have installed the i2c header at some other place (like 
# /usr/local/include/linux), set that directory here. Please check this out
# if you get strange compilation errors; the default Linux i2c headers
# may be used mistakenly. Note: This should point to the directory
# *above* the linux/ subdirectory, so to /usr/local/include in the
# above example.
#I2C_HEADERS=/usr/local/include
I2C_HEADERS=$(LINUX_HEADERS)

# Uncomment the third line on SMP systems if the magic invocation fails. It
# is a bit complicated because SMP configuration changed around kernel 2.1.130
SMP := $(shell if grep -q '^SMP[[:space:]]*=' $(LINUX)/Makefile || \
                  grep -q '^[[:space:]]*\#define[[:space:]]*CONFIG_SMP[[:space:]]*1' $(LINUX_HEADERS)/linux/autoconf.h ; \
               then echo 1; else echo 0; fi)
#SMP := 0
#SMP := 1

# Uncomment the second or third line if the magic invocation fails.
# We need to know whether CONFIG_MODVERSIONS is defined.
MODVER := $(shell if cat $(LINUX_HEADERS)/linux/config.h $(LINUX_HEADERS)/linux/autoconf.h 2>/dev/null | grep -q '^[[:space:]]*\#define[[:space:]]*CONFIG_MODVERSIONS[[:space:]]*1'; then echo 1; else echo 0; fi)
#MODVER := 0
#MODVER := 1

# Uncomment the second line if you are a developer. This will enable many
# additional warnings at compile-time
WARN := 0
#WARN := 1

# Uncomment the second line if you want to get (loads of) debug information
# at run-time.
# Not recommended, unless you are actually debugging the code
DEBUG := 0
#DEBUG := 1

# If you want to install at some other place then at from which you will run
# everything, set DESTDIR to the extra prefix.
DESTDIR :
# This is the prefix that will be used for almost all directories below.
PREFIX := /usr/local

# This is the directory into which the modules will be installed.
# The magic invocation will return something like this:
#   /lib/modules/2.2.15-ac9/misc
# MODDIR := /lib/modules/`grep UTS_RELEASE $(LINUX_HEADERS)/linux/version.h|cut -f 2 -d'"'`/misc
MODPREF := /lib/modules/`grep UTS_RELEASE $(LINUX_HEADERS)/linux/version.h|cut -f 2 -d'"'`

# This is the directory where sensors.conf will be installed, if no other
# configuration file is found
ETCDIR := /etc

# You should not need to change this. It is the directory into which the
# library files (both static and shared) will be installed.
LIBDIR := $(PREFIX)/lib

# You should not need to change this. It is the directory into which the
# executable program files will be installed. BINDIR for programs that are
# also useful for normal users, SBINDIR for programs that can only be run
# by the superuser.
# Note that not all programs in this package are really installed;
# some are just examples. You can always install them by hand, of
# course.
BINDIR := $(PREFIX)/bin
SBINDIR := $(PREFIX)/sbin

# You should not need to change this. It is the basic directory into which
# include files will be installed. The actual directory will be 
# $(INCLUDEDIR)/linux for system include files, and $(INCLUDEDIR)/sensors
# for library include files. If PREFIX equals the default /usr/local/bin,
# you will be able to use '#include <linux/sensors.h>' regardless of the
# current kernel selected.
INCLUDEDIR := $(PREFIX)/include
SYSINCLUDEDIR := $(INCLUDEDIR)/linux
LIBINCLUDEDIR := $(INCLUDEDIR)/sensors

# You should not need to change this. It is the base directory under which the
# manual pages will be installed.
MANDIR := $(PREFIX)/man

# You should not need to change this. It defines the manual owner and group
# as which manual pages are installed.
MANOWN := root
MANGRP := root

MACHINE := $(shell uname -m)

# Extra non-default programs to build; e.g., sensord
# PROG_EXTRA := sensord

# Set these to add preprocessor or compiler flags, or use
# environment variables
# CFLAGS :# CPPFLAGS :
##################################################
# Below this, nothing should need to be changed. #
##################################################

# Note that this is a monolithic Makefile; it calls no sub-Makefiles,
# but instead, it compiles everything right from here. Yes, there are
# some distinct advantages to this; see the following paper for more info:
#   http://www.tip.net.au/~millerp/rmch/recu-make-cons-harm.html
# Note that is still uses Makefile fragments in sub-directories; these
# are called 'Module.mk'.

# Within each Module.mk, rules and dependencies can be added to targets
# all, install and clean. Use double colons instead of single ones
# to do this. 

# The subdirectories we need to build things in 
SRCDIRS := mkpatch
ifeq ($(COMPILE_KERNEL),1)
SRCDIRS += kernel kernel/busses kernel/chips kernel/include
endif
SRCDIRS += lib prog/sensors prog/dump prog/detect ${PROG_EXTRA:%=prog/%} etc

# Some often-used commands with default options
MKDIR := mkdir -p
RM := rm -f
CC := gcc
BISON := bison
FLEX := flex
AR := ar
INSTALL := install
LN := ln -sfn
GREP := grep

# Determine the default compiler flags
# Set CFLAGS or CPPFLAGS above to add your own flags to all.
# ALLCPPFLAGS/ALLCFLAGS are common flags, plus any user-specified overrides from the environment or make command line.
# MODCPPFLAGS/MODCFLAGS is to create in-kernel object files (modules).
# PROGCPPFLAGS/PROGCFLAGS is to create non-kernel object files (which are linked into executables).
# ARCPPFLAGS/ARCFLAGS are used to create archive object files (static libraries).
# LIBCPPFLAGS/LIBCFLAGS are for shared library objects.
ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -I$(LINUX_HEADERS)
ALL_CFLAGS := -O2 

ifeq ($(DEBUG),1)
ALL_CPPFLAGS += -DDEBUG
endif

ifeq ($(WARN),1)
ALL_CFLAGS += -Wall -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
            -Wcast-align -Wwrite-strings -Wnested-externs -Winline
endif

ALL_CPPFLAGS += $(CPPFLAGS)
ALL_CFLAGS += $(CFLAGS)

MODCPPFLAGS :MODCFLAGS :
ifeq ($(MACHINE),alpha)
MODCFLAGS += -ffixed-8
endif

ifeq ($(SMP),1)
MODCPPFLAGS += -D__SMP__
endif

ifeq ($(MODVER),1)
MODCPPFLAGS += -DMODVERSIONS -include $(LINUX_HEADERS)/linux/modversions.h
endif

MODCPPFLAGS += -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer $(ALL_CPPFLAGS)
MODCFLAGS += $(ALL_CFLAGS)
PROGCPPFLAGS := $(ALL_CPPFLAGS)
PROGCFLAGS := $(ALL_CFLAGS)
ARCPPFLAGS := $(ALL_CPPFLAGS)
ARCFLAGS := $(ALL_CFLAGS)
LIBCPPFLAGS := $(ALL_CPPFLAGS)
LIBCFLAGS := -fpic $(ALL_CFLAGS)

.PHONY: all clean install version package dep

# Make all the default rule
all::

# Include all makefiles for sub-modules
INCLUDEFILES := 
include $(patsubst %,%/Module.mk,$(SRCDIRS))
ifneq ($(MAKECMDGOALS),clean)
include $(INCLUDEFILES)
endif

# Making the dependency files - done automatically!
dep : 

all ::

install :: all

clean::
	$(RM) lm_sensors-*

# This is tricky, but it works like a charm. It needs lots of utilities
# though: cut, find, gzip, ln, tail and tar.
package: version clean
	lmversion=`tail -1 version.h|cut -f 2 -d \"`; \
	lmpackage=lm_sensors-$$lmversion; \
	ln -s . $$lmpackage;  \
	find $$lmpackage/ -type f | grep -v ^$$lmpackage/$$lmpackage$$ | \
	                            grep -v ^$$lmpackage/$$lmpackage.tar$$ | \
	                            grep -v ^$$lmpackage/$$ | \
	                            grep -v /CVS | \
	                            grep -v /\\.# | \
	                            tar rvf $$lmpackage.tar -T -; \
        gzip -9 $$lmpackage.tar ;\
        $(RM) $$lmpackage.tar $$lmpackage
	cat doc/developers/checklist

version:
	$(RM) version.h
	echo '#define LM_DATE "'`date +'%Y%m%d'`\" > version.h
	echo -n 'Version: '; \
	echo '#define LM_VERSION "'`read VER; echo $$VER`\" >> version.h


# Here, we define all implicit rules we want to use.

.SUFFIXES:

# We need to create dependency files. Tricky. We sed rule puts dir/file.d and
# dir/file.c in front of the dependency file rule.

# .o files are used for modules
%.o: %.c
	$(CC) $(MODCPPFLAGS) $(MODCFLAGS) -c $< -o $@

%.d: %.c
	$(CC) -M -MG $(MODCPPFLAGS) $(MODCFLAGS) $< | \
       	sed -e 's@^\(.*\)\.o:@$*.d $*.o: Makefile '`dirname $*.d`/Module.mk' @' > $@



# .ro files are used for programs (as opposed to modules)
%.ro: %.c
	$(CC) $(PROGCPPFLAGS) $(PROGCFLAGS) -c $< -o $@

%.rd: %.c
	$(CC) -M -MG $(PROGCPPFLAGS) $(PROGCFLAGS) $< | \
       	sed -e 's@^\(.*\)\.o:@$*.rd $*.ro: Makefile '`dirname $*.rd`/Module.mk' @' > $@


%: %.ro
	$(CC) $(EXLDFLAGS) -o $@ $^


# .ao files are used for static archives
%.ao: %.c
	$(CC) $(ARCPPFLAGS) $(ARCFLAGS) -c $< -o $@

%.ad: %.c
	$(CC) -M -MG $(ARCPPFLAGS) $(ARCFLAGS) $< | \
       	sed -e 's@^\(.*\)\.o:@$*.ad $*.ao: Makefile '`dirname $*.ad`/Module.mk' @' > $@


# .lo files are used for shared libraries
%.lo: %.c
	$(CC) $(LIBCPPFLAGS) $(LIBCFLAGS) -c $< -o $@

%.ld: %.c
	$(CC) -M -MG $(LIBCPPFLAGS) $(LIBCFLAGS) $< | \
       	sed -e 's@^\(.*\)\.o:@$*.ld $*.lo: Makefile '`dirname $*.ld`/Module.mk' @' > $@


# Flex and Bison
%c: %y
	$(BISON) -p sensors_yy -d $< -o $@

%.c: %.l
	$(FLEX) -Psensors_yy -t $< > $@
-------------- next part --------------
##This source RPM build the foloowing binary packages:
## lm_sensors -- user space stuff
## lm_sensors-devel -- user space stuff for the application development
## lm_sensors-drivers -- kernel space drivers.

##Dependencies: lm_sensors requires lm_sensors_drivers
##              lm_sensors-devel requires lm_sensors
##              lm_sensors-drivers requires new i2c code

## lm_sensors and lm_sensors-devel can be distributed easily as binary
## packages. They will be compatible with different configurations.

## WARNING!!! lm_sensors-drivers must be compiled for the the same kernel
## that will run on the target machine. This implies the same kernel
## version and the  same kernel configuration. Thus, this binary package
## can be provided by distribution vendors only for their stock distribution
## kernels. If you use a custom configured kernel, you must rebuild this
## package. To protect the innocent, we define kversion and make the
## resulting package dependable on the specific version of the kernel.

## The only customizable variables are prefix and kversion.
## If you have used a custom tug in the vesrion of your kernel rpm,
## you may need to adjust mversion as well. 

## If i2c has been installed into a location defferent from prefix or /usr;
## you must define I2C_HEADERS below.
## This package IS relocatable (change prefix to relocate).

%define prefix /usr
%define I2C_HEADERS %{prefix}/include/linux

#Define your kernel version here.
%define kversion 2.4.18
%define mversion %{kversion}
#Another example for the above: %define kversion 2.2.14-SMP

%define name lm_sensors
%define ver 2.6.4
Summary: Hardware Health Monitoring Tools
Name: %{name}
Version: %{ver}
Release: 1
Group: Applications/System
Copyright: GPL
Source0: http://www.lm-sensors.nu/lm-sensors/archive/%{name}-%{ver}.tar.gz
Buildroot: /var/tmp/%{name}
Docdir: %{prefix}/share/doc
Requires: %{name}-drivers >= %{ver}
Url: http://www.netroedge.com/~lm78/

##For officially distributed packages, please sign below
##Packager: Lm_sensors Group <sensors@stimpy.netroedge.com> 

%package drivers
Summary: Chip and bus drivers for general SMBus access and hardware monitoring.
Group: Base/Kernel
###Latest RedHat distributions define a different Group: Group: System Environment/Kernel

Copyright: GPL
Requires: kernel-i2c >= %{ver}, kernel = %{kversion}

%package devel
Summary: Development environment for hardware health monitoring applications
Group: Development/Libraries
Copyright: GPL 
Requires: %{name} = %{ver}

%description
This package contains a collection of user space tools for general SMBus
access and hardware monitoring. SMBus, also known as System Management Bus,
is a protocol for communicating through a I2C ('I squared C') bus. Many modern
mainboards have a System Management Bus. There are a lot of devices which can
be connected to a SMBus; the most notable are modern memory chips with EEPROM
memories and chips for hardware monitoring.

Most modern mainboards incorporate some form of hardware monitoring chips.
These chips read things like chip temperatures, fan rotation speeds and
voltage levels. There are quite a few different chips which can be used
by mainboard builders for approximately the same results.

%description drivers
This package contains a collection of kernel modules for general SMBus
access and hardware monitoring. SMBus, also known as System Management Bus,
is a protocol for communicating through a I2C ('I squared C') bus. Many modern
mainboards have a System Management Bus. There are a lot of devices which can
be connected to a SMBus; the most notable are modern memory chips with EEPROM
memories and chips for hardware monitoring.

Most modern mainboards incorporate some form of hardware monitoring chips.
These chips read things like chip temperatures, fan rotation speeds and
voltage levels. There are quite a few different chips which can be used
by mainboard builders for approximately the same results.

Hardware monitoring chips are often connected to the SMBus, but often they
can also be connected to the ISA bus. The modules in this package usually
support both ways of accessing them.

%description devel
This package contains environment for development of user space applications
for general SMBus access and hardware monitoring. SMBus, also known as
System Management Bus, is a protocol for communicating through a I2C
('I squared C') bus. Many modern mainboards have a System Management Bus.
There are a lot of devices which can be connected to a SMBus; the most
notable are modern memory chips with EEPROM memories and chips for hardware
monitoring.

%prep
%setup

%build
#even for non-SMP systems parallel make will build faster
make -j4 I2C_HEADERS=%{I2C_HEADERS}

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT PREFIX=%{prefix}
#back up stock config
cp -a $RPM_BUILD_ROOT/etc/sensors.conf $RPM_BUILD_ROOT/etc/sensors.ex

%post
ldconfig || /bin/true
echo "please run \`%{prefix}/sbin/sensors-detect' to configure the sensors."

%postun
ldconfig || /bin/true

%post drivers
depmod -a || /bin/true

%postun drivers
depmod -a || /bin/true

%files
%config /etc/sensors.conf
%config /etc/sensors.ex
%{prefix}/bin/*
%{prefix}/lib/lib*.so.*
%dir %{prefix}/man/man1
%dir %{prefix}/man/man5
%{prefix}/man/man1/*
%{prefix}/man/man5/*
%{prefix}/sbin/*
%doc BACKGROUND BUGS CHANGES CONTRIBUTORS INSTALL README TODO
%doc doc/{FAQ,cvs,fan-divisors,modules,progs,temperature-sensors}
%doc doc/{useful_addresses.html,version-2}

%files drivers
%dir /lib/modules/%{mversion}
%dir /lib/modules/%{mversion}/misc
/lib/modules/%{mversion}/misc/*
%dir %{prefix}/include/linux
%{prefix}/include/linux/*.h
%doc doc/busses doc/chips doc/developers doc/kernel

%files devel
%dir %{prefix}/include/sensors
%{prefix}/include/sensors/*.h
%{prefix}/lib/*.a
%{prefix}/lib/*.so
%dir %{prefix}/man/man3
%{prefix}/man/man3/*

%clean
rm -rf $RPM_BUILD_ROOT
rm -rf $RPM_BUILD_DIR/%{name}-%{ver}
