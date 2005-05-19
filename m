From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: problems with redhat 8.0
Message-Id: <3E2C9E35.8020602@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <067b01c2bdb2$74a935f0$e381add5@vortex>
In-Reply-To: <067b01c2bdb2$74a935f0$e381add5@vortex>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

looks like it might be a problem with modversions;
also make sure the kernel source at /lib/modules/2.4.18-19.8.0/build
is good. You may need to rebuild the kernel source first.

Jouni Viikari wrote:
> Hi,
> 
> Since the original lm_sensors in Redhat 8.0 does not detect my ASUS P4PE
> sensors I decided to try if the latest lm_sensors version 2.7.0 works.
> However when I try to compile the new i2c (just "make", no corrections to
> Makefile) I get following results:
> 
> [root@celon i2c-2.7.0]# make
> gcc -I/lib/modules/2.4.18-19.8.0/build/include -O2 -DLM_SENSORS -D__KERNEL__
>  -DMOD
> ULE -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include
> /lib/modules/2.4.1
> 8-19.8.0/build/include/linux/modversions.h -c kernel/i2c-core.c -o
> kernel/i2c-core
> .o
> In file included from
> /lib/modules/2.4.18-19.8.0/build/include/linux/prefetch.h:13
> ,
>                  from
> /lib/modules/2.4.18-19.8.0/build/include/linux/list.h:6,
>                  from
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:12,
>                  from kernel/i2c-core.c:26:
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:51: warning:
> parameter names (without types) in function declaration
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:51: field
> `loops_per_jiffy_R_ver_str' declared as a function
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:73: invalid suffix
> on integer constant
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:73: parse error
> before numeric constant
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:256: invalid suffix
> on integer constant
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:256: parse error
> before numeric constant
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:260: warning:
> parameter names (without types) in function declaration
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:436: invalid suffix
> on floating constant
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:436: parse error
> before numeric constant
> /lib/modules/2.4.18-19.8.0/build/include/asm/processor.h:436:
> `kernel_thread_R_ver_str' declared as function returning a function
> In file included from kernel/i2c-core.c:26:
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:183: invalid suffix
> on integer constant
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:183: parse error
> before numeric constant
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:183:
> `inter_module_register_R_ver_str' declared as function returning a function
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:184: invalid suffix
> on integer constant
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:184: parse error
> before numeric constant
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:184:
> `inter_module_unregister_R_ver_str' declared as function returning a
> function
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:185:
> `inter_module_get_R_ver_str' declared as function returning a function
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:185: warning:
> parameter names (without types) in function declaration
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:186:
> `inter_module_get_request_R_ver_str' declared as function returning a
> function
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:186: warning:
> parameter names (without types) in function declaration
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:187: invalid suffix
> on integer constant
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:187: parse error
> before numeric constant
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:187:
> `inter_module_put_R_ver_str' declared as function returning a function
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:196:
> `try_inc_mod_count_R_ver_str' declared as function returning a function
> /lib/modules/2.4.18-19.8.0/build/include/linux/module.h:196: warning:
> parameter names (without types) in function declaration
> make: *** [kernel/i2c-core.o] Error 1
> 
> I wonder what is wrong?  (path to modules is ok, i2c in RH8.0 is built as
> modules.  Standard i2c in RH8.0 is in 2.6.3 level, gcc version is 3.2, My
> RH8.0 is just installed with all the latest errata)
> 
> Hopefully I did not bother you with old news, I did not find anything
> relevant in your FAQ's nor Self-Serve area.
> 
> Best regards,
> 
> Jouni
> 
