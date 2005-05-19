From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Problems with Opteron compilation
Message-Id: <20030715183730.7be4235c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F128749.7010603@ekp.physik.uni-karlsruhe.de>
In-Reply-To: <3F128749.7010603@ekp.physik.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> sorry for sending this to the lm_sensors address, but I did not find
> any separate i2c address one the web.

We are the i2c people too :)

> I checked out the most recent source code from CVS and tried to
> compile the i2c package first, the compilation stopped with the
> message below
> 
> 
> gcc -D__SMP__ -I/lib/modules/2.4.19-SMP/build/include -nostdinc -I 
> /opt/gcc33/lib64/gcc-lib/x86_64-suse-linux/3.3/include -Wall -O2 
> -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer
> -DEXPORT_SYMTAB -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -mno-red-zone -mcmodel=kernel -fno-reorder-blocks -finline-limit 00 
> -fno-strength-reduce -c kernel/i2c-algo-biths.c -o
> kernel/i2c-algo-biths.o/lib/modules/2.4.19-SMP/build/include/linux/mo
> dule.h:300: warning: `__module_kernel_version' defined but not used
> kernel/i2c-algo-biths.c:771: warning: `__module_license' defined but
> not used
> /tmp/cckgMevc.s: Assembler messages:
> /tmp/cckgMevc.s:1387: Error: Incorrect register `%rdx' used with `l'
> suffix make: *** [kernel/i2c-algo-biths.o] Error 1
> 
> 
> I run Suse Linux Enterprise Server at the moment with Dual Opteron in
> 64 Bit mode with SLES 2.4.19 kernel (according to suse with the latest
> relevant Opteron patches.
> The error occurs both with gcc-3.2.2 und gcc-3.3
> 
> Maybe this is interesting for you ..

Sure. This module as a very short asm part in it, I think this is what
causes the problem. Anyway, this module isn't very useful yet, so the
best you can do is skip it. Edit kernel/Module.mk and comment out the
following lines:
KERNELTARGETS += $(MODULE_DIR)/i2c-algo-biths.o
KERNELINCLUDES += $(MODULE_DIR)/i2c-algo-biths.h

After that, i2c should compile and install OK (I hope).

We'll have a look at the faulty module and see what we can do to fix it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
