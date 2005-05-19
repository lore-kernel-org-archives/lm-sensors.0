From: mmosny@postel.sk (Martin Mosny)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Tickets #1322 and #1323
Message-Id: <833155336.20030708100139@postel.sk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030708093213.642bde1a.khali@linux-fr.org>
In-Reply-To: <20030708093213.642bde1a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jean,

> I'm a bit troubled by your tickets. First, I guess that you were using
> i2c & lm_sensors CVS, not 2.7.0.

no!

I'm using:
i2c-2.7.0.tar.gz
lm_sensors-2.7.0.tar.gz

I  download  only  the  Makefile  and  the  etc/config.c file from the
web-to-CVS interface.


> You say that the depmod commands at the end of our Makefile were
> preventing you from compiling lm_sensors. I can't understand, since they
> are run by "make install", not make. Also, didn't you have the same
> problem with installing i2c? The very same commands are run when you run
> "make install" for i2c.

Yes,  I  understand  it  too. I'm using LM for a few years on a lot of
Linux machines, not any packages, all are compiled.

I have not this problem with i2c compiling.

here is the log from i2c:

- ------ BEGIN --------

[root@voice i2c-2.7.0]# make
Makefile:188: kernel/i2c-core.d: No such file or directory
Makefile:188: kernel/i2c-dev.d: No such file or directory
Makefile:188: kernel/i2c-algo-bit.d: No such file or directory
Makefile:188: kernel/i2c-elv.d: No such file or directory
Makefile:188: kernel/i2c-velleman.d: No such file or directory
Makefile:188: kernel/i2c-algo-pcf.d: No such file or directory
Makefile:188: kernel/i2c-elektor.d: No such file or directory
Makefile:188: kernel/i2c-proc.d: No such file or directory
Makefile:188: kernel/i2c-pport.d: No such file or directory
Makefile:188: kernel/i2c-pcf-epp.d: No such file or directory
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-pcf-epp.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-pcf-epp.d kernel/i2c-pcf-epp.o: Makefile '`dirname kernel/i2c-pcf-epp.d`/Module.mk' @' > kernel/i2c-pcf-epp.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-pport.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-pport.d kernel/i2c-pport.o: Makefile '`dirname kernel/i2c-pport.d`/Module.mk' @' > kernel/i2c-pport.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-proc.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-proc.d kernel/i2c-proc.o: Makefile '`dirname kernel/i2c-proc.d`/Module.mk' @' > kernel/i2c-proc.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-elektor.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-elektor.d kernel/i2c-elektor.o: Makefile '`dirname kernel/i2c-elektor.d`/Module.mk' @' > kernel/i2c-elektor.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-algo-pcf.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-algo-pcf.d kernel/i2c-algo-pcf.o: Makefile '`dirname kernel/i2c-algo-pcf.d`/Module.mk' @' > kernel/i2c-algo-pcf.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-velleman.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-velleman.d kernel/i2c-velleman.o: Makefile '`dirname kernel/i2c-velleman.d`/Module.mk' @' > kernel/i2c-velleman.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-elv.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-elv.d kernel/i2c-elv.o: Makefile '`dirname kernel/i2c-elv.d`/Module.mk' @' > kernel/i2c-elv.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-algo-bit.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-algo-bit.d kernel/i2c-algo-bit.o: Makefile '`dirname kernel/i2c-algo-bit.d`/Module.mk' @' > kernel/i2c-algo-bit.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-dev.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-dev.d kernel/i2c-dev.o: Makefile '`dirname kernel/i2c-dev.d`/Module.mk' @' > kernel/i2c-dev.d
gcc -M -MG -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h kernel/i2c-core.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-core.d kernel/i2c-core.o: Makefile '`dirname kernel/i2c-core.d`/Module.mk' @' > kernel/i2c-core.d
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-core.c -o kernel/i2c-core.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-dev.c -o kernel/i2c-dev.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-algo-bit.c -o kernel/i2c-algo-bit.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-elv.c -o kernel/i2c-elv.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-velleman.c -o kernel/i2c-velleman.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-algo-pcf.c -o kernel/i2c-algo-pcf.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-elektor.c -o kernel/i2c-elektor.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-proc.c -o kernel/i2c-proc.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-pport.c -o kernel/i2c-pport.o
gcc -I/lib/modules/2.4.21-mvts/build/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include /lib/modules/2.4.21-mvts/build/include/linux/modversions.h -c kernel/i2c-pcf-epp.c -o kernel/i2c-pcf-epp.o
[root@voice i2c-2.7.0]#

- ------ END -------

All modules are compiled successfully.

> A more detailed problem description than "I have problem to compile"
> would be greatly appreciated. For example, could you provide a log of
> the error as it shows? These commands are specificaly meant not to
> interrupt the installation even if they fail (see the leading dash) so I
> just don't understand what your problem could be.

Ok, here is the log from the ORIGINAL Make file from CVS tree with the
etc/config.c

- --- BEGIN ------

[root@voice lm_sensors-2.7.0]# make
Makefile:246: kernel/busses/i2c-ali1535.d: No such file or directory
Makefile:246: kernel/busses/i2c-ali15x3.d: No such file or directory
Makefile:246: kernel/busses/i2c-amd756.d: No such file or directory
Makefile:246: kernel/busses/i2c-amd8111.d: No such file or directory
Makefile:246: kernel/busses/i2c-hydra.d: No such file or directory
Makefile:246: kernel/busses/i2c-i801.d: No such file or directory
Makefile:246: kernel/busses/i2c-i810.d: No such file or directory
Makefile:246: kernel/busses/i2c-isa.d: No such file or directory
Makefile:246: kernel/busses/i2c-sis5595.d: No such file or directory
Makefile:246: kernel/busses/i2c-sis630.d: No such file or directory
Makefile:246: kernel/busses/i2c-sis645.d: No such file or directory
Makefile:246: kernel/busses/i2c-piix4.d: No such file or directory
Makefile:246: kernel/busses/dmi_scan.d: No such file or directory
Makefile:246: kernel/busses/i2c-savage4.d: No such file or directory
Makefile:246: kernel/busses/i2c-via.d: No such file or directory
Makefile:246: kernel/busses/i2c-viapro.d: No such file or directory
Makefile:246: kernel/busses/i2c-voodoo3.d: No such file or directory
Makefile:246: kernel/chips/smartbatt.d: No such file or directory
Makefile:246: kernel/chips/smbus-arp.d: No such file or directory
Makefile:246: kernel/chips/vt8231.d: No such file or directory
Makefile:246: kernel/chips/adm1021.d: No such file or directory
Makefile:246: kernel/chips/adm1024.d: No such file or directory
Makefile:246: kernel/chips/adm1025.d: No such file or directory
Makefile:246: kernel/chips/adm9240.d: No such file or directory
Makefile:246: kernel/chips/bt869.d: No such file or directory
Makefile:246: kernel/chips/ddcmon.d: No such file or directory
Makefile:246: kernel/chips/ds1621.d: No such file or directory
Makefile:246: kernel/chips/eeprom.d: No such file or directory
Makefile:246: kernel/chips/fscpos.d: No such file or directory
Makefile:246: kernel/chips/fscscy.d: No such file or directory
Makefile:246: kernel/chips/gl518sm.d: No such file or directory
Makefile:246: kernel/chips/gl520sm.d: No such file or directory
Makefile:246: kernel/chips/it87.d: No such file or directory
Makefile:246: kernel/chips/lm75.d: No such file or directory
Makefile:246: kernel/chips/lm78.d: No such file or directory
Makefile:246: kernel/chips/lm80.d: No such file or directory
Makefile:246: kernel/chips/lm87.d: No such file or directory
Makefile:246: kernel/chips/lm92.d: No such file or directory
Makefile:246: kernel/chips/ltc1710.d: No such file or directory
Makefile:246: kernel/chips/matorb.d: No such file or directory
Makefile:246: kernel/chips/maxilife.d: No such file or directory
Makefile:246: kernel/chips/mtp008.d: No such file or directory
Makefile:246: kernel/chips/pcf8574.d: No such file or directory
Makefile:246: kernel/chips/pcf8591.d: No such file or directory
Makefile:246: kernel/chips/sis5595.d: No such file or directory
Makefile:246: kernel/chips/smsc47m1.d: No such file or directory
Makefile:246: kernel/chips/thmc50.d: No such file or directory
Makefile:246: kernel/chips/w83781d.d: No such file or directory
Makefile:246: kernel/chips/via686a.d: No such file or directory
Makefile:246: kernel/chips/vt1211.d: No such file or directory
Makefile:246: lib/data.ld: No such file or directory
Makefile:246: lib/general.ld: No such file or directory
Makefile:246: lib/error.ld: No such file or directory
Makefile:246: lib/chips.ld: No such file or directory
Makefile:246: lib/proc.ld: No such file or directory
Makefile:246: lib/access.ld: No such file or directory
Makefile:246: lib/init.ld: No such file or directory
Makefile:246: lib/data.ad: No such file or directory
Makefile:246: lib/general.ad: No such file or directory
Makefile:246: lib/error.ad: No such file or directory
Makefile:246: lib/chips.ad: No such file or directory
Makefile:246: lib/proc.ad: No such file or directory
Makefile:246: lib/access.ad: No such file or directory
Makefile:246: lib/init.ad: No such file or directory
Makefile:246: prog/sensors/main.rd: No such file or directory
Makefile:246: prog/sensors/chips.rd: No such file or directory
Makefile:246: prog/dump/isadump.rd: No such file or directory
Makefile:246: prog/dump/i2cdump.rd: No such file or directory
Makefile:246: prog/dump/i2cset.rd: No such file or directory
Makefile:246: prog/detect/i2cdetect.rd: No such file or directory
Makefile:246: prog/detect/dmidecode.rd: No such file or directory
Makefile:257: *** missing separator.  Stop.
[root@voice lm_sensors-2.7.0]#
- ----- END ----

so  as  you can see there is an error on the line 257 I look into the
makefile,  and I can see only the lines with depmods. I make some test
with  the  condition  "ifeq ($(DESTDIR),)", because if the is only the
line  with  depmod, all runs successfully. So I try to comment out the
lines and all troubles go away.

I have running standard packages from distro (redhat 9)

automake-1.6.3-5
make-3.79.1-17
bash-2.05b-20.1

As I can see this can be a problem from bash or make.

I attach a little diff


256,260c256,260
< ifeq ($(DESTDIR),)
<     -/sbin/depmod -a
< else
<     -/sbin/depmod -a -b $(DESTDIR)
< endif
- ---
> #ifeq ($(DESTDIR),)
> #    -/sbin/depmod -a
> #else
> #    -/sbin/depmod -a -b $(DESTDIR)
> #endif

!!!If I can help do not hesitate to contact me!!!

- --
  Best regards
               Ing. Martin Mosny
- ----------------------------------------------------------------------
                        IP Network Manager

        PosTel, a.s. Kvacalova 53,82108 Bratislava 2, Slovakia
                  Tel.: +421-2-50203169, Fax.: +421-2-50203198
               http://www.postel.sk, http://www.globalphone.sk

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5i

iQA/AwUBPwpsV5dguByG9Q4aEQJd6wCggqk3uVvSRZr4V+96DeQVPkrYA9gAoKGr
iYAM9LqwDzs6QVgcONR2aBMK
=lRAs
-----END PGP SIGNATURE-----
