From: zf@seznam.cz (Filipko Zdenko)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Compile problem RH9
Message-Id: <1053818740.7444.16.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 
 
I have a new board (MSI KT4V, with VIA KT400 & VT8235 & W83697HF). While trying to compile current lm_sensors cvs,
the following errors occur:

gcc  -D__SMP__ -DMODVERSIONS -include /lib/modules/2.4.20-8/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -idirafter /lib/modules/2.4.20-8/build/include   -O2   -c kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
In file included from /usr/include/linux/prefetch.h:13,
                 from /usr/include/linux/list.h:6,
                 from /usr/include/linux/module.h:11,
                 from kernel/busses/i2c-nforce2.c:34:
/usr/include/asm/processor.h:51: field `loops_per_jiffy_R_ver_str' declared as a function
/usr/include/asm/processor.h:72: invalid suffix on integer constant
/usr/include/asm/processor.h:72: parse error before numeric constant
/usr/include/asm/processor.h:435: invalid suffix on integer constant
/usr/include/asm/processor.h:435: parse error before numeric constant
/usr/include/asm/processor.h:435: `kernel_thread_R_ver_str' declared as function returning a function
In file included from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/sched.h:6: invalid suffix on integer constant
/usr/include/linux/sched.h:6: parse error before numeric constant
In file included from /usr/include/linux/fs.h:16,
                 from /usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/kdev_t.h:76: `kdevname_R_ver_str' declared as function returning a function
In file included from /usr/include/linux/fs.h:23,
                 from /usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/string.h:8:2: warning: #warning Using kernel header in userland!
In file included from /usr/include/linux/fs.h:23,
                 from /usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/string.h:19: invalid suffix on integer constant
/usr/include/linux/string.h:19: parse error before numeric constant
/usr/include/linux/string.h:20: invalid suffix on integer constant
/usr/include/linux/string.h:20: parse error before numeric constant
/usr/include/linux/string.h:20: `strpbrk_R_ver_str' declared as function returning a function
/usr/include/linux/string.h:21: `strtok_R_ver_str' declared as function returning a function
/usr/include/linux/string.h:22: invalid suffix on integer constant
/usr/include/linux/string.h:22: parse error before numeric constant
/usr/include/linux/string.h:22: `strsep_R_ver_str' declared as function returning a function
/usr/include/linux/string.h:23: `strspn_R_ver_str' declared as function returning a function
In file included from /usr/include/linux/fs.h:23,
                 from /usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/string.h:50: invalid suffix on floating constant
/usr/include/linux/string.h:50: parse error before numeric constant
/usr/include/linux/string.h:50: `strnicmp_R_ver_str' declared as function returning a function
/usr/include/linux/string.h:59: invalid suffix on floating constant
/usr/include/linux/string.h:59: parse error before numeric constant
/usr/include/linux/string.h:59: `strstr_R_ver_str' declared as function returning a function
In file included from /usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/fs.h:53: invalid suffix on integer constant
/usr/include/linux/fs.h:53: parse error before numeric constant
In file included from /usr/include/linux/timex.h:152,
                 from /usr/include/linux/sched.h:14,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/asm/timex.h:47: invalid suffix on integer constant
/usr/include/asm/timex.h:47: parse error before numeric constant
In file included from /usr/include/linux/sched.h:14,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/timex.h:173: field `time' has incomplete type
In file included from /usr/include/linux/bitops.h:69,
                 from /usr/include/asm/system.h:7,
                 from /usr/include/linux/sched.h:16,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/asm/bitops.h:327:2: warning: #warning This includefile is not available on all architectures.
/usr/include/asm/bitops.h:328:2: warning: #warning Using kernel headers in userspace: atomicity not guaranteed
In file included from /usr/include/linux/sched.h:16,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/asm/system.h:232: floating constant exponent has no digits
/usr/include/asm/system.h:232: parse error before numeric constant
/usr/include/asm/system.h:232: `disable_hlt_R_ver_str' declared as function returning a function
/usr/include/asm/system.h:233: invalid suffix on integer constant
/usr/include/asm/system.h:233: parse error before numeric constant
/usr/include/asm/system.h:233: `enable_hlt_R_ver_str' declared as function returning a function
In file included from /usr/include/linux/signal.h:4,
                 from /usr/include/linux/sched.h:25,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/asm/signal.h:107: parse error before "sigset_t"
/usr/include/asm/signal.h:110: parse error before '}' token
In file included from /usr/include/linux/sched.h:81,
                 from kernel/busses/i2c-nforce2.c:38:
/usr/include/linux/timer.h:45: parse error before "spinlock_t"
/usr/include/linux/timer.h:53: parse error before '}' token
/usr/include/linux/timer.h:67: parse error before "tvec_base_t"
/usr/include/linux/timer.h:70: `add_timer_R_ver_str' declared as function returning a function
/usr/include/linux/timer.h:71: `del_timer_R_ver_str' declared as function returning a function
/usr/include/linux/timer.h:94: invalid suffix on integer constant
/usr/include/linux/timer.h:94: parse error before numeric constant
/usr/include/linux/timer.h:94: `mod_timer_R_ver_str' declared as function returning a function
/usr/include/linux/timer.h:101: parse error before "tvec_bases"
/usr/include/linux/timer.h: In function `init_timer':
/usr/include/linux/timer.h:105: dereferencing pointer to incomplete type
/usr/include/linux/timer.h:105: dereferencing pointer to incomplete type
/usr/include/linux/timer.h:106: dereferencing pointer to incomplete type
/usr/include/linux/timer.h: In function `timer_pending':
/usr/include/linux/timer.h:121: dereferencing pointer to incomplete type
In file included from kernel/busses/i2c-nforce2.c:39:
/usr/include/linux/ioport.h: At top level:
/usr/include/linux/ioport.h:83: floating constant exponent has no digits
/usr/include/linux/ioport.h:83: parse error before numeric constant
/usr/include/linux/ioport.h:84: floating constant exponent has no digits
/usr/include/linux/ioport.h:84: parse error before numeric constant
/usr/include/linux/ioport.h:88: `check_resource_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:89: invalid suffix on integer constant
/usr/include/linux/ioport.h:89: parse error before numeric constant
/usr/include/linux/ioport.h:89: `request_resource_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:90: parse error before numeric constant
/usr/include/linux/ioport.h:90: `release_resource_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:96: `allocate_resource_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:102: invalid suffix on integer constant
/usr/include/linux/ioport.h:102: parse error before numeric constant
/usr/include/linux/ioport.h:102: `__request_region_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:110: `__check_region_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:111: `__release_region_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:117: invalid suffix on integer constant
/usr/include/linux/ioport.h:117: parse error before numeric constant
/usr/include/linux/ioport.h:117: `autoirq_setup_R_ver_str' declared as function returning a function
/usr/include/linux/ioport.h:118: invalid suffix on integer constant
/usr/include/linux/ioport.h:118: parse error before numeric constant
/usr/include/linux/ioport.h:118: `autoirq_report_R_ver_str' declared as function returning a function
In file included from kernel/busses/i2c-nforce2.c:41:
/usr/local/include/linux/i2c.h:224: field `bus' has incomplete type
/usr/local/include/linux/i2c.h:225: field `list' has incomplete type
/usr/local/include/linux/i2c.h: In function `i2c_client_command':
/usr/local/include/linux/i2c.h:327: `EINVAL' undeclared (first use in this function)
/usr/local/include/linux/i2c.h:327: (Each undeclared identifier is reported only once
/usr/local/include/linux/i2c.h:327: for each function it appears in.)
In file included from /usr/include/linux/delay.h:13,
                 from kernel/busses/i2c-nforce2.c:42:
/lib/modules/2.4.20-8/build/include/asm/delay.h: At top level:
/lib/modules/2.4.20-8/build/include/asm/delay.h:13: invalid suffix on floating constant
/lib/modules/2.4.20-8/build/include/asm/delay.h:13: parse error before numeric constant
/lib/modules/2.4.20-8/build/include/asm/delay.h:13: `__udelay_R_ver_str' declared as function returning a function
/lib/modules/2.4.20-8/build/include/asm/delay.h:14: `__ndelay_R_ver_str' declared as function returning a function
/lib/modules/2.4.20-8/build/include/asm/delay.h:15: `__const_udelay_R_ver_str' declared as function returning a function
/lib/modules/2.4.20-8/build/include/asm/delay.h:16: invalid suffix on integer constant
/lib/modules/2.4.20-8/build/include/asm/delay.h:16: parse error before numeric constant
/lib/modules/2.4.20-8/build/include/asm/delay.h:16: `__delay_R_ver_str' declared as function returning a function
kernel/busses/i2c-nforce2.c: In function `nforce2_do_pause':
kernel/busses/i2c-nforce2.c:134: `current' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:135: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:135: called object is not a function
kernel/busses/i2c-nforce2.c: In function `nforce2_access':
kernel/busses/i2c-nforce2.c:184: parse error before "u8"
kernel/busses/i2c-nforce2.c:193: parse error before "u8"
kernel/busses/i2c-nforce2.c:203: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:203: `KERN_WARNING' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:203: parse error before string constant
kernel/busses/i2c-nforce2.c:215: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:215: parse error before string constant
kernel/busses/i2c-nforce2.c:233: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:233: parse error before string constant
kernel/busses/i2c-nforce2.c:237: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:237: parse error before string constant
kernel/busses/i2c-nforce2.c:253: `eae3dfd6' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:253: called object is not a function
kernel/busses/i2c-nforce2.c:253: invalid suffix on floating constant
kernel/busses/i2c-nforce2.c:253: called object is not a function
kernel/busses/i2c-nforce2.c:257: `current' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:258: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:258: called object is not a function
kernel/busses/i2c-nforce2.c:283: parse error before "u8"
kernel/busses/i2c-nforce2.c: At top level:
kernel/busses/i2c-nforce2.c:304: elements of array `nforce2_ids' have incomplete type
kernel/busses/i2c-nforce2.c:305: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:305: warning: (near initialization for `nforce2_ids[0]')
kernel/busses/i2c-nforce2.c:305: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:305: warning: (near initialization for `nforce2_ids[0]')
kernel/busses/i2c-nforce2.c:306: `PCI_ANY_ID' undeclared here (not in a function)
kernel/busses/i2c-nforce2.c:306: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:306: warning: (near initialization for `nforce2_ids[0]')
kernel/busses/i2c-nforce2.c:306: `PCI_ANY_ID' undeclared here (not in a function)
kernel/busses/i2c-nforce2.c:306: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:306: warning: (near initialization for `nforce2_ids[0]')
kernel/busses/i2c-nforce2.c:306: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:306: warning: (near initialization for `nforce2_ids[0]')
kernel/busses/i2c-nforce2.c:306: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:306: warning: (near initialization for `nforce2_ids[0]')
kernel/busses/i2c-nforce2.c:306: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:306: warning: (near initialization for `nforce2_ids[0]')
kernel/busses/i2c-nforce2.c:307: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:307: warning: (near initialization for `nforce2_ids[1]')
kernel/busses/i2c-nforce2.c: In function `nforce2_probe_smb':
kernel/busses/i2c-nforce2.c:316: `d25f3240' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:316: called object is not a function
kernel/busses/i2c-nforce2.c:316: `PCIBIOS_SUCCESSFUL' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:317: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:317: `KERN_ERR' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:317: parse error before string constant
kernel/busses/i2c-nforce2.c:324: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:324: floating constant exponent has no digits
kernel/busses/i2c-nforce2.c:324: invalid lvalue in unary `&'
kernel/busses/i2c-nforce2.c:324: called object is not a function
kernel/busses/i2c-nforce2.c:325: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:325: parse error before string constant
kernel/busses/i2c-nforce2.c:335: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:335: called object is not a function
kernel/busses/i2c-nforce2.c:342: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:342: `KERN_WARNING' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:342: parse error before string constant
kernel/busses/i2c-nforce2.c:343: `d49501d4' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:343: floating constant exponent has no digits
kernel/busses/i2c-nforce2.c:343: invalid lvalue in unary `&'
kernel/busses/i2c-nforce2.c:343: called object is not a function
kernel/busses/i2c-nforce2.c:346: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:346: `KERN_INFO' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:346: parse error before string constant
kernel/busses/i2c-nforce2.c: In function `nforce2_probe':
kernel/busses/i2c-nforce2.c:357: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:358: `GFP_KERNEL' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:358: called object is not a function
kernel/busses/i2c-nforce2.c:359: `ENOMEM' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:366: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:366: `KERN_ERR' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:366: parse error before string constant
kernel/busses/i2c-nforce2.c:371: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:371: parse error before string constant
kernel/busses/i2c-nforce2.c:376: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:376: called object is not a function
kernel/busses/i2c-nforce2.c:377: `ENODEV' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c: In function `nforce2_remove':
kernel/busses/i2c-nforce2.c:391: `d49501d4' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:391: floating constant exponent has no digits
kernel/busses/i2c-nforce2.c:391: invalid lvalue in unary `&'
kernel/busses/i2c-nforce2.c:391: called object is not a function
kernel/busses/i2c-nforce2.c:395: floating constant exponent has no digits
kernel/busses/i2c-nforce2.c:395: invalid lvalue in unary `&'
kernel/busses/i2c-nforce2.c:395: called object is not a function
kernel/busses/i2c-nforce2.c:397: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:397: called object is not a function
kernel/busses/i2c-nforce2.c: At top level:
kernel/busses/i2c-nforce2.c:400: variable `nforce2_driver' has initializer but incomplete type
kernel/busses/i2c-nforce2.c:401: unknown field `name' specified in initializer
kernel/busses/i2c-nforce2.c:401: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:401: warning: (near initialization for `nforce2_driver')
kernel/busses/i2c-nforce2.c:402: unknown field `id_table' specified in initializer
kernel/busses/i2c-nforce2.c:402: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:402: warning: (near initialization for `nforce2_driver')
kernel/busses/i2c-nforce2.c:403: unknown field `probe' specified in initializer
kernel/busses/i2c-nforce2.c:403: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:403: warning: (near initialization for `nforce2_driver')
kernel/busses/i2c-nforce2.c:404: unknown field `remove' specified in initializer
kernel/busses/i2c-nforce2.c:404: warning: excess elements in struct initializer
kernel/busses/i2c-nforce2.c:404: warning: (near initialization for `nforce2_driver')
kernel/busses/i2c-nforce2.c: In function `nforce2_init':
kernel/busses/i2c-nforce2.c:409: invalid suffix on integer constant
kernel/busses/i2c-nforce2.c:409: `KERN_INFO' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:409: parse error before string constant
kernel/busses/i2c-nforce2.c: In function `nforce2_exit':
kernel/busses/i2c-nforce2.c:415: `da41300e' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:415: called object is not a function
kernel/busses/i2c-nforce2.c: At top level:
kernel/busses/i2c-nforce2.c:400: storage size of `nforce2_driver' isn't known
make: *** [kernel/busses/i2c-nforce2.o] Error 1


So current i2c cvs is OK.
 
thanks
Zdeno 
