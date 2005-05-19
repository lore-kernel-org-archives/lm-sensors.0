From: mshannon@themattpad.com (Matthew M. Shannon)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c kernel patch issue with bttv-if module
Message-Id: <3F16DAEA.1060802@themattpad.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors team-

I have no idea who the right person is for this sort of email, however I 
trust someone will forward it on to the right person.

I applied your new i2c patch (i2c-2.8.0) to a virgin 2.4.21 kernel with 
zero issues. However during the build process I die at the same point in 
the middle of the bttv modules. The bummer is I still love my bttv card 
and can't stand to part with it.

Perhaps there's something missing from the patch.

Here's the error:

gcc -D__KERNEL__ -D__SMP__ -I/home/mshannon/kernel/linux-2.4.21/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/mshannon/kernel/linux-2.4.21/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=bttv_if 
-DEXPORT_SYMTAB -c bttv-if.c
bttv-if.c:255: unknown field `inc_use' specified in initializer
bttv-if.c:255: warning: initialization from incompatible pointer type
bttv-if.c:256: unknown field `dec_use' specified in initializer
bttv-if.c:256: warning: missing braces around initializer
bttv-if.c:256: warning: (near initialization for 
`bttv_i2c_adap_template.name')
bttv-if.c:256: warning: initialization makes integer from pointer 
without a cast
bttv-if.c:256: initializer element is not computable at load time
bttv-if.c:256: (near initialization for `bttv_i2c_adap_template.name[0]')
bttv-if.c:257: initializer element is not constant
bttv-if.c:257: (near initialization for `bttv_i2c_adap_template.name')
make[3]: *** [bttv-if.o] Error 1
make[3]: Leaving directory 
`/home/mshannon/kernel/linux-2.4.21/drivers/media/video'

Any thoughts? I'll try any suggestions you may have.

Thanks!

Matt Shannon
