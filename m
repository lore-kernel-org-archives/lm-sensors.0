From: s.roa@computer.org (Sergio Roa Ovalle)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: error compiling with i2c 2.8.0 patch
Message-Id: <m3vfu071bn.fsf@athlon.familiaroa>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3oeztep4f.fsf@athlon.familiaroa>
In-Reply-To: <m3oeztep4f.fsf@athlon.familiaroa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have tried with the SuSE  kernel v. 2.4.21 and I get similar errors,
like these (maybe a problem of compatibility between SuSE and standard
kernel?):

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-4/include  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=scx200_i2c  -c -o scx200_i2c.o scx200_i2c.c
scx200_i2c.c:107: unknown field `inc_use' specified in initializer
scx200_i2c.c:107: warning: initialization from incompatible pointer type
scx200_i2c.c:108: unknown field `dec_use' specified in initializer
scx200_i2c.c:108: warning: initialization from incompatible pointer type
scx200_i2c.c:109: duplicate initializer
scx200_i2c.c:109: (near initialization for `scx200_i2c_ops.client_register')
scx200_i2c.c:110: duplicate initializer
scx200_i2c.c:110: (near initialization for `scx200_i2c_ops.client_unregister')
make[2]: *** [scx200_i2c.o] Error 1
make[2]: Saliendo directorio `/usr/src/linux-2.4.21-4/drivers/i2c'
make[1]: *** [_modsubdir_i2c] Error 2
make[1]: Saliendo directorio `/usr/src/linux-2.4.21-4/drivers'
make: *** [_mod_drivers] Error 2

Disabling the previous module:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-4/include  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=i2c_ali1535  -c -o i2c-ali1535.o i2c-ali1535.c
i2c-ali1535.c:171: warning: initialization from incompatible pointer type
i2c-ali1535.c:172: warning: missing braces around initializer
i2c-ali1535.c:172: warning: (near initialization for `smbus_algorithm.name')
i2c-ali1535.c:172: warning: overflow in implicit constant conversion
i2c-ali1535.c:173: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:174: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:174: initializer element is not computable at load time
i2c-ali1535.c:174: (near initialization for `smbus_algorithm.name[2]')
i2c-ali1535.c:175: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:176: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:177: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:178: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:178: initializer element is not computable at load time
i2c-ali1535.c:178: (near initialization for `smbus_algorithm.name[6]')
i2c-ali1535.c:182: warning: initialization from incompatible pointer type
i2c-ali1535.c:183: warning: missing braces around initializer
i2c-ali1535.c:183: warning: (near initialization for `ali1535_adapter.name')
i2c-ali1535.c:183: warning: overflow in implicit constant conversion
i2c-ali1535.c:184: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:184: initializer element is not computable at load time
i2c-ali1535.c:184: (near initialization for `ali1535_adapter.name[1]')
i2c-ali1535.c:185: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:186: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:186: initializer element is not computable at load time
i2c-ali1535.c:186: (near initialization for `ali1535_adapter.name[3]')
i2c-ali1535.c:187: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:187: initializer element is not computable at load time
i2c-ali1535.c:187: (near initialization for `ali1535_adapter.name[4]')
i2c-ali1535.c:188: warning: initialization makes integer from pointer without a cast
i2c-ali1535.c:189: warning: initialization makes integer from pointer without a cast
make[2]: *** [i2c-ali1535.o] Error 1
make[2]: Saliendo directorio `/usr/src/linux-2.4.21-4/drivers/i2c/busses'
make[1]: *** [_modsubdir_i2c/busses] Error 2
make[1]: Saliendo directorio `/usr/src/linux-2.4.21-4/drivers'
make: *** [_mod_drivers] Error 2

I also attach the .config file...

Thanks.

Jean Delvare escribi? (Thu, 17 Jul 2003 09:06:15 +0200):

    >> I have SuSE 8.0 with kernel 2.4.18.  I am trying to use the i2c patch,
    >> in order  to use my webcam  (module bttv) and lm_sensors.  I have used
    >> the mkpatch  script which comes  with the i2c  package. When I  try to
    >> compile the kernel I get the following errors for various i2c modules:
    >> (...)

    JD> Could you send us your .config file? I could then try to reproduce the
    JD> problem on my system.

    JD> However, why are you using such an old kernel? It's 17 month and three
    JD> version old! If you are to recompile your kernel, you should update to
    JD> 2.4.21 before doing so, methinks.

    >> Besides I am not  sure if the file i2c-2.8.0-drivers-media-video.diff,
    >> which I also used for patching, is appropriate for my kernel.

    JD> If it applied cleanly (I mean not part was rejected) it should be OK.

    JD> -- 
    JD> Jean Delvare
    JD> http://www.ensicaen.ismra.fr/~delvare/


-- 
Sergio Roa Ovalle
Key fingerprint = 5427 E535 8E18 8B3B C38B  ADB5 9DF5 89DE FBF4 738C
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/octet-stream
Size: 49542 bytes
Desc: config
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030718/28659040/config.obj
