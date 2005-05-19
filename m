From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: #1353 still error!!
Message-Id: <20030731113302.0a010244.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've swapped the 2 lines (6th and 7th) but nothing happened, exactly
> the same error!

Strange, I would have expected it to solve at least the
"config_must_be_included_before_module" error. Can you double-check you
have #include <linux/config.h> before #include <linux/module.h> by now?
(Didn't you forget to save the changes before compiling again?)

> It prints a lot more things, I just copy some of them here and the 
> dmi_scan error:
> 
> gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. 
> -Ikernel/include -I/usr/include
> -I/lib/modules/2.4.18-4GB/build/include  -nostdinc -I
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3/include  -Wall -O2   -c
> kernel/busses/i2c-piix4.c -o kernel/busses/i2c-piix4.o In file
> included from /usr/include/asm/semaphore.h:39,
>                  from /usr/include/linux/fs.h:198,
>                  from /usr/include/linux/capability.h:17,
>                  from /usr/include/linux/binfmts.h:5,
>                  from /usr/include/linux/sched.h:8,
>                  from /usr/include/linux/mm.h:4,
>                  from /usr/include/linux/slab.h:14,
>                  from /usr/include/asm/pci.h:32,
>                  from /usr/include/linux/pci.h:610,
>                  from kernel/busses/i2c-piix4.c:34:
> /usr/include/asm/system.h: In function `__set_64bit_var':
> /usr/include/asm/system.h:184: warning: dereferencing type-punned 
> pointer will break strict-aliasing rules
> /usr/include/asm/system.h:184: warning: dereferencing type-punned 
> pointer will break strict-aliasing rules
> gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. 
> -Ikernel/include -I/usr/include
> -I/lib/modules/2.4.18-4GB/build/include  -nostdinc -I
> /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3/include  -Wall -O2   -c
> kernel/busses/dmi_scan.c -o kernel/busses/dmi_scan.o In file included
> from /usr/include/asm/semaphore.h:39,
>                  from /usr/include/linux/fs.h:198,
>                  from /usr/include/linux/capability.h:17,
>                  from /usr/include/linux/binfmts.h:5,
>                  from /usr/include/linux/sched.h:8,
>                  from /usr/include/linux/mm.h:4,
>                  from /usr/include/linux/slab.h:14,
>                  from kernel/busses/dmi_scan.c:13:
> /usr/include/asm/system.h: In function `__set_64bit_var':
> /usr/include/asm/system.h:184: warning: dereferencing type-punned
> pointer will break strict-aliasing rules
> /usr/include/asm/system.h:184: warning: dereferencing type-punned 
> pointer will break strict-aliasing rules
> kernel/busses/dmi_scan.c: At top level:
> kernel/busses/dmi_scan.c:232: error: parse error before 
> "config_must_be_included_before_module"
> kernel/busses/dmi_scan.c:232: warning: type defaults to `int' in 
> declaration of `config_must_be_included_before_module'
> kernel/busses/dmi_scan.c:232: warning: data definition has no type or 
> storage class
> kernel/busses/dmi_scan.c:233: error: parse error before 
> "config_must_be_included_before_module"
> kernel/busses/dmi_scan.c:233: warning: type defaults to `int' in 
> declaration of `config_must_be_included_before_module'
> kernel/busses/dmi_scan.c:233: warning: data definition has no type or 
> storage class
> make: *** [kernel/busses/dmi_scan.o] Error 1

OK, there are actually much more errors than you first told. I guess you
are on an IA-64 system, using gcc-3.3?

Are there no warnings at all for the other modules? Just i2c-piix4 and
dmi_scan?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
