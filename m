From: thenders@math.tamu.edu (Troy Henderson)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: i2c, lm_sensors, and 2.4.22 kernel
Message-Id: <Pine.LNX.4.44.0309191056490.20651-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have recently downloaded the CVS version of i2c and lm_sensors.  I 
wanted to implement the i2c and lm_sensors drivers for my hardware only 
into my kernel (2.4.22).  After downloading both of these, performed the 
following

cd /usr/src/linux-2.4.22
$I2C_PATH/mkpatch/mkpatch.pl $I2C_PATH . | patch -p1
$LM_SENSORS_PATH/mkpatch/mkpatch.pl $LM_SENSORS_PATH . | patch -p1

The patches seem to have succeeded.  However, when I try to compile the 
kernel, I get the following error(s)

-------------------------Begin cut here-----------------------------------

make[3]: Entering directory `/usr/src/linux-2.4.22/drivers/media/video'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes
-Wno- trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpref erred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/li nux-2.4.22/include/linux/modversions.h  -nostdinc
-iwithprefix include -DKBUILD_ BASENAME=videodev  -DEXPORT_SYMTAB -c
videodev.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes
-Wno- trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpref erred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/li nux-2.4.22/include/linux/modversions.h  -nostdinc
-iwithprefix include -DKBUILD_ BASENAME=bttv_driver  -c -o bttv-driver.o
bttv-driver.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes
-Wno- trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpref erred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/li nux-2.4.22/include/linux/modversions.h  -nostdinc
-iwithprefix include -DKBUILD_ BASENAME=bttv_cards  -c -o bttv-cards.o
bttv-cards.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes
-Wno- trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpref erred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/li nux-2.4.22/include/linux/modversions.h  -nostdinc
-iwithprefix include -DKBUILD_ BASENAME=bttv_if  -DEXPORT_SYMTAB -c
bttv-if.c
bttv-if.c:244: error: unknown field `inc_use' specified in initializer
bttv-if.c:244: warning: initialization from incompatible pointer type
bttv-if.c:245: error: unknown field `dec_use' specified in initializer
bttv-if.c:245: warning: missing braces around initializer
bttv-if.c:245: warning: (near initialization for
`bttv_i2c_adap_template.name')
bttv-if.c:245: warning: initialization makes integer from pointer without
a cast
bttv-if.c:245: error: initializer element is not computable at load time
bttv-if.c:245: error: (near initialization for
`bttv_i2c_adap_template.name[0]')
bttv-if.c:246: error: initializer element is not constant
bttv-if.c:246: error: (near initialization for
`bttv_i2c_adap_template.name')
make[3]: *** [bttv-if.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.22/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.22/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.22/drivers'
make: *** [_mod_drivers] Error 2

--------------------------End cut here------------------------------------

I do have a BTTV card and I was having it built into the kernel as well.  
If you have any insight onto this error, I would appreciate some help.

Thanks,

##########################################################################
Troy Henderson                  Office: Blocker Building 619
Department of Mathematics       Phone : (979) 845-7769
Texas A&M University            E-mail: thenders@math.tamu.edu
College Station, TX 77845       URL   : http://www.math.tamu.edu/~thenders
##########################################################################
