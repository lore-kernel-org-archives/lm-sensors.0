From: maik.goette@uni-kassel.de (Maik =?iso-8859-1?q?G=F6tte?=)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: installation problems
Message-Id: <200404021403.13048.maik.goette@uni-kassel.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I am Linux newbie, and am in need of a cpu temperature monitoring tool.
So I tried to install lm_sensors, as told on your page.
For I use SuSE 9.0 (2.4.21-199Athlon Kernel), I downloaded Version 2.7.0.

The following occurs and tells me nothing:

BCH-PC33:/install/hardmon/i2c-2.7.0 # make all
Makefile:188: kernel/i2c-core.d: No such file or directory
Makefile:188: kernel/i2c-dev.d: No such file or directory
Makefile:188: kernel/i2c-algo-bit.d: No such file or directory
Makefile:188: kernel/i2c-philips-par.d: No such file or directory
Makefile:188: kernel/i2c-elv.d: No such file or directory
Makefile:188: kernel/i2c-velleman.d: No such file or directory
Makefile:188: kernel/i2c-algo-pcf.d: No such file or directory
Makefile:188: kernel/i2c-elektor.d: No such file or directory
Makefile:188: kernel/i2c-proc.d: No such file or directory
Makefile:188: kernel/i2c-pport.d: No such file or directory
Makefile:188: kernel/i2c-pcf-epp.d: No such file or directory
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-pcf-epp.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-pcf-epp.d kernel/i2c-pcf-epp.o: Makefile 
'`dirname kernel/i2c-pcf-epp.d`/Module.mk' @' > kernel/i2c-pcf-epp.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-pport.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-pport.d kernel/i2c-pport.o: Makefile 
'`dirname kernel/i2c-pport.d`/Module.mk' @' > kernel/i2c-pport.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-proc.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-proc.d kernel/i2c-proc.o: Makefile '`dirname 
kernel/i2c-proc.d`/Module.mk' @' > kernel/i2c-proc.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-elektor.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-elektor.d kernel/i2c-elektor.o: Makefile 
'`dirname kernel/i2c-elektor.d`/Module.mk' @' > kernel/i2c-elektor.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-algo-pcf.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-algo-pcf.d kernel/i2c-algo-pcf.o: Makefile 
'`dirname kernel/i2c-algo-pcf.d`/Module.mk' @' > kernel/i2c-algo-pcf.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-velleman.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-velleman.d kernel/i2c-velleman.o: Makefile 
'`dirname kernel/i2c-velleman.d`/Module.mk' @' > kernel/i2c-velleman.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-elv.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-elv.d kernel/i2c-elv.o: Makefile '`dirname 
kernel/i2c-elv.d`/Module.mk' @' > kernel/i2c-elv.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-philips-par.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-philips-par.d kernel/i2c-philips-par.o: 
Makefile '`dirname kernel/i2c-philips-par.d`/Module.mk' @' > kernel/
i2c-philips-par.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-algo-bit.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-algo-bit.d kernel/i2c-algo-bit.o: Makefile 
'`dirname kernel/i2c-algo-bit.d`/Module.mk' @' > kernel/i2c-algo-bit.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-dev.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-dev.d kernel/i2c-dev.o: Makefile '`dirname 
kernel/i2c-dev.d`/Module.mk' @' > kernel/i2c-dev.d
gcc -M -MG -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h 
kernel/i2c-core.c | \
sed -e 's@^\(.*\)\.o:@kernel/i2c-core.d kernel/i2c-core.o: Makefile '`dirname 
kernel/i2c-core.d`/Module.mk' @' > kernel/i2c-core.d
gcc -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h -c 
kernel/i2c-core.c -o kernel/i2c-core.o
gcc -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h -c 
kernel/i2c-dev.c -o kernel/i2c-dev.o
gcc -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h -c 
kernel/i2c-algo-bit.c -o kernel/i2c-algo-bit.o
gcc -I/lib/modules/2.4.21-199-athlon/build/include -O2 -DLM_SENSORS 
-D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS 
-include /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h -c 
kernel/i2c-philips-par.c -o kernel/i2c-philips-par.o
kernel/i2c-philips-par.c:163: error: initializer element is not constant
kernel/i2c-philips-par.c:163: error: (near initialization for 
`bit_lp_data.timeout')
kernel/i2c-philips-par.c:172: error: initializer element is not constant
kernel/i2c-philips-par.c:172: error: (near initialization for 
`bit_lp_data2.timeout')
make: *** [kernel/i2c-philips-par.o] Error 1

Regards

-- 
Maik G?tte
University of Kassel, Germany
Student, Dipl. Biology
 
Email: maik.goette@uni-kassel.de
Webpage: http://www.biologie.uni-kassel.de/ 

