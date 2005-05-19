From: od@fet.uni-hannover.de (Oliver Dawid)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: [od@fet.uni-hannover.de: Trying to find device chrontel 7009 ...]
Message-Id: <200311050744.10449.od@fet.uni-hannover.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031013205850.GA2164@frodo.local>
In-Reply-To: <20031013205850.GA2164@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tuesday 04 November 2003 22:59, you wrote:

> > Client found at address 0x2e
> > Probing for `National Semiconductor LM80'... Success!
> >     (confidence 3, driver `lm80')
> > Client found at address 0x2f
> > Probing for `National Semiconductor LM80'... Success!
> >     (confidence 3, driver `lm80')
>
> The LM80 is hard to detect, so it might not be LM80's. Load lm80, run
> sensors (and sensors -s before that) and see if the values make sense.

sensors output:
flex scanner jammed

I have lm_sensors 2.7.0. I downloaded 2.8.1 but got this problem while 
compiling:
In file included from /lib/modules/2.4.20/build/include/asm/semaphore.h:39,
                 from /lib/modules/2.4.20/build/include/linux/fs.h:200,
                 from /lib/modules/2.4.20/build/include/linux/capability.h:17,
                 from /lib/modules/2.4.20/build/include/linux/binfmts.h:5,
                 from /lib/modules/2.4.20/build/include/linux/sched.h:9,
                 from /lib/modules/2.4.20/build/include/linux/mm.h:4,
                 from /lib/modules/2.4.20/build/include/linux/slab.h:14,
                 from /lib/modules/2.4.20/build/include/asm/pci.h:32,
                 from /lib/modules/2.4.20/build/include/linux/pci.h:622,
                 from kernel/busses/i2c-nforce2.c:35:
/lib/modules/2.4.20/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.4.20/build/include/asm/system.h:190: warning: dereferencing 
type-punned pointer will break strict-aliasing rules
/lib/modules/2.4.20/build/include/asm/system.h:190: warning: dereferencing 
type-punned pointer will break strict-aliasing rules
kernel/busses/i2c-nforce2.c: In function `nforce2_access':
kernel/busses/i2c-nforce2.c:242: warning: implicit declaration of function 
`i2c_delay'
kernel/busses/i2c-nforce2.c: In function `nforce2_probe_smb':
kernel/busses/i2c-nforce2.c:317: error: structure has no member named `owner'
kernel/busses/i2c-nforce2.c:320: error: `I2C_HW_SMBUS_NFORCE2' undeclared 
(first use in this function)
kernel/busses/i2c-nforce2.c:320: error: (Each undeclared identifier is 
reported only once
kernel/busses/i2c-nforce2.c:320: error: for each function it appears in.)
make: *** [kernel/busses/i2c-nforce2.o] Error 1

Seems that you depend on different kernel header than 2.4.20?

> > Client found at address 0x44
>
> Might be what you're after.

i2cdump 1 0x44 b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 0f 04 00 00 00 00 00 00 00 00 00 00 00 00    ..??............

i2cdump 1 0x2e b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 3f 80 20 5d 5d c7 00 5a 00 1e 21 00 00 00 00    ??? ]]?.Z.?!....
10: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
20: 5d 5d 00 d1 41 33 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]].?A3a]]]]]]]]]
30: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 30 41 83    ]]]]]]]]]]]]]0A?
40: 01 3f 00 20 5d 5d c7 00 5a 00 1e 21 00 00 00 00    ??. ]]?.Z.?!....
50: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
60: 5d 5d 00 d1 41 33 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]].?A3a]]]]]]]]]
70: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 30 41 83    ]]]]]]]]]]]]]0A?
80: 01 3f 00 20 5d 5d c7 00 5a 00 1e 21 00 00 00 00    ??. ]]?.Z.?!....
90: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
a0: 5d 5d 00 d1 41 33 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]].?A3a]]]]]]]]]
b0: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 30 41 83    ]]]]]]]]]]]]]0A?
c0: 01 3f 00 20 5d 5d 07 00 5a 00 1f 21 00 00 00 00    ??. ]]?.Z.?!....
d0: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
e0: 5d 5d 00 d1 41 33 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]].?A3a]]]]]]]]]
f0: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 30 41 83    ]]]]]]]]]]]]]0A?

i2cdump 1 0x2f b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 ff 0f 00 00 ff 0f 00 00 ff 06 00 00 07 85 00    ?.?...?...?..??.
10: c0 11 00 60 ff ff ff ff ff ff ff ff ff ff ff ff    ??.`............

Seems like you are right and only one of 0x2e and 0x2f is a real lm80. Can you 
tell me from dump which one it probably is? Hopefully its 0x2f because 
chrontel 7009 has tons of registers and it better fits to 0x2e ' s dump.

maybe none of these devices is my chrontel so i will have to search on.

Regards,
od

-- 
od@fli4l.de * http://www.fli4l.de/ * the on(e) disk router
