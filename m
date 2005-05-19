From: ottavio@campana.vi.it (Ottavio Campana)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: compile error 2.4.22
Message-Id: <20031127143753.GA13922@campana.vi.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just tried the last patch for 2.4.22 (26th Oct). I get the same error
I got with the previous patch:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.22/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=bttv_cards  -c -o bttv-cards.o bttv-cards.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.22/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=bttv_if  -DEXPORT_SYMTAB -c bttv-if.c
bttv-if.c:244: unknown field `inc_use' specified in initializer
bttv-if.c:244: warning: initialization from incompatible pointer type
bttv-if.c:245: unknown field `dec_use' specified in initializer
bttv-if.c:245: warning: missing braces around initializer
bttv-if.c:245: warning: (near initialization for `bttv_i2c_adap_template.name')
bttv-if.c:245: warning: initialization makes integer from pointer without a cast
bttv-if.c:245: initializer element is not computable at load time
bttv-if.c:245: (near initialization for `bttv_i2c_adap_template.name[0]')
bttv-if.c:246: unknown field `name' specified in initializer
bttv-if.c:246: warning: initialization makes integer from pointer without a cast
bttv-if.c:246: initializer element is not computable at load time
bttv-if.c:246: (near initialization for `bttv_i2c_adap_template.name[1]')
bttv-if.c:247: unknown field `id' specified in initializer
bttv-if.c:248: unknown field `client_register' specified in initializer
bttv-if.c:248: warning: initialization makes integer from pointer without a cast
bttv-if.c:248: initializer element is not computable at load time
bttv-if.c:248: (near initialization for `bttv_i2c_adap_template.name[3]')
make[4]: *** [bttv-if.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.22/drivers/media/video'
make[3]: *** [_modsubdir_video] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.22/drivers/media'
make[2]: *** [_modsubdir_media] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.22/drivers'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.22'
make: *** [stamp-build] Error 2
dirac:/usr/src/linux-2.4.22#

And here's the source:

243 static struct i2c_adapter bttv_i2c_adap_template = {
244         .inc_use           = bttv_inc_use,
245         .dec_use           = bttv_dec_use,
246         I2C_DEVNAME("bt848"),
247         .id                = I2C_HW_B_BT848,
249         .client_register   = attach_inform,
250 };

If you need  more infos please cc  the reply, for I'm  not subscribed to
the list.

Bye

-- 
Non c'? pi? forza nella normalit?, c'? solo monotonia.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031127/8b807ad5/attachment.bin
