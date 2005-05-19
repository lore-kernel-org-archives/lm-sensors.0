From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Problem compiling ic2
Message-Id: <3E2CB0A9.4010106@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c2b385$3c3f0320$0b0aa8c0@sentlap01>
In-Reply-To: <000001c2b385$3c3f0320$0b0aa8c0@sentlap01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Be sure the source at /usr/src/linux is good and has been built;
you appear to have modversions problems or a kernel source
that hasn't been compiled.

Frans Boerefijn wrote:
> When compiling the ic2 package on a Redhat 8.0 with kernel 2.4.18-19.8.0 I
> get the following compile error:
> 
> gcc -I/usr/src/linux/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-f
> rame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include
> /usr/src/linux/include/linux/modversions.h -c kernel/i2c-core.c -o
> kernel/i2c-core.o
> In file included from /usr/src/linux/include/linux/prefetch.h:13,
>                  from /usr/src/linux/include/linux/list.h:6,
>                  from /usr/src/linux/include/linux/module.h:12,
>                  from kernel/i2c-core.c:26:
> /usr/src/linux/include/asm/processor.h:51: warning: parameter names (without
> types) in function declaration
> /usr/src/linux/include/asm/processor.h:51: field `loops_per_jiffy_R_ver_str'
> declared as a function
> /usr/src/linux/include/asm/processor.h:73: invalid suffix on integer
> constant
> /usr/src/linux/include/asm/processor.h:73: parse error before numeric
> constant
> /usr/src/linux/include/asm/processor.h:256: invalid suffix on integer
> constant
> /usr/src/linux/include/asm/processor.h:256: parse error before numeric
> constant
> /usr/src/linux/include/asm/processor.h:260: warning: parameter names
> (without types) in function declaration
> /usr/src/linux/include/asm/processor.h:436: invalid suffix on floating
> constant
> /usr/src/linux/include/asm/processor.h:436: parse error before numeric
> constant
> /usr/src/linux/include/asm/processor.h:436: `kernel_thread_R_ver_str'
> declared as function returning a function
> In file included from kernel/i2c-core.c:26:
> /usr/src/linux/include/linux/module.h:183: invalid suffix on integer
> constant
> /usr/src/linux/include/linux/module.h:183: parse error before numeric
> constant
> /usr/src/linux/include/linux/module.h:183: `inter_module_register_R_ver_str'
> declared as function returning a function
> /usr/src/linux/include/linux/module.h:184: invalid suffix on integer
> constant
> /usr/src/linux/include/linux/module.h:184: parse error before numeric
> constant
> /usr/src/linux/include/linux/module.h:184:
> `inter_module_unregister_R_ver_str' declared as function returning a
> function
> /usr/src/linux/include/linux/module.h:185: `inter_module_get_R_ver_str'
> declared as function returning a function
> /usr/src/linux/include/linux/module.h:185: warning: parameter names (without
> types) in function declaration
> /usr/src/linux/include/linux/module.h:186:
> `inter_module_get_request_R_ver_str' declared as function returning a
> function
> /usr/src/linux/include/linux/module.h:186: warning: parameter names (without
> types) in function declaration
> /usr/src/linux/include/linux/module.h:187: invalid suffix on integer
> constant
> /usr/src/linux/include/linux/module.h:187: parse error before numeric
> constant
> /usr/src/linux/include/linux/module.h:187: `inter_module_put_R_ver_str'
> declared as function returning a function
> /usr/src/linux/include/linux/module.h:196: `try_inc_mod_count_R_ver_str'
> declared as function returning a function
> /usr/src/linux/include/linux/module.h:196: warning: parameter names (without
> types) in function declaration
> make: *** [kernel/i2c-core.o] Error 1
> 
> 
> I have no patches installed, just the bare i2c-2.7.0 package in
> /usr/src/redhat/SOURCES/i2c-2.7.0 Is there something that I miss??
> 
> Please assist,
> frans
> 
> 
> 
