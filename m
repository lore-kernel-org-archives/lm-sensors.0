From: stanitz@ekp.physik.uni-karlsruhe.de (Marcel Stanitzki)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Problems with Opteron compilation
Message-Id: <3F128749.7010603@ekp.physik.uni-karlsruhe.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

sorry for sending this to the lm_sensors address, but I did not find any 
separate i2c address one the web.


I checked out the most recent source code from CVS and tried to compile 
the i2c package first, the compilation stopped with the message below


gcc -D__SMP__ -I/lib/modules/2.4.19-SMP/build/include -nostdinc -I 
/opt/gcc33/lib64/gcc-lib/x86_64-suse-linux/3.3/include -Wall -O2 
-DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB 
-fno-strict-aliasing -fno-common -fomit-frame-pointer -mno-red-zone 
-mcmodel=kernel -fno-reorder-blocks -finline-limit 00 
-fno-strength-reduce -c kernel/i2c-algo-biths.c -o kernel/i2c-algo-biths.o
/lib/modules/2.4.19-SMP/build/include/linux/module.h:300: warning: 
`__module_kernel_version' defined but not used
kernel/i2c-algo-biths.c:771: warning: `__module_license' defined but not 
used
/tmp/cckgMevc.s: Assembler messages:
/tmp/cckgMevc.s:1387: Error: Incorrect register `%rdx' used with `l' suffix
make: *** [kernel/i2c-algo-biths.o] Error 1


I run Suse Linux Enterprise Server at the moment with Dual Opteron in 64 
Bit mode with SLES 2.4.19 kernel (according to suse with the latest 
relevant Opteron patches.
The error occurs both with gcc-3.2.2 und gcc-3.3

Maybe this is interesting for you ..

Cheers

Marcel


-- 
---------------------------------------------------------------------
Marcel Stanitzki
    DELPHI
Institut fuer Experimentelle Kernphysik (IEKP) /Universitaet Karlsruhe
Engesserstr. 7  76128 Karlsruhe
--------------------------------------------------------------------
Telefon: +49-721-608-7034  Telefax: +49-721-607-262

Email : stanitz@ekp.physik.uni-karlsruhe.de
Email : Marcel.Stanitzki@cern.ch
WWW : http://www-ekp.physik.uni-karlsruhe.de/~stanitz
