From: s.roa@computer.org (Sergio Roa Ovalle)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: error compiling with i2c 2.8.0 patch
Message-Id: <m3oeztep4f.fsf@athlon.familiaroa>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I have SuSE 8.0 with kernel 2.4.18.  I am trying to use the i2c patch,
in order  to use my webcam  (module bttv) and lm_sensors.  I have used
the mkpatch  script which comes  with the i2c  package. When I  try to
compile the kernel I get the following errors for various i2c modules:

i2c-isa.c:58: warning: initialization from incompatible pointer type
i2c-isa.c:59: warning: missing braces around initializer
i2c-isa.c:59: warning: (near initialization for `isa_algorithm.name')
i2c-isa.c:59: warning: overflow in implicit constant conversion
i2c-isa.c:60: warning: initialization makes integer from pointer without a cast
i2c-isa.c:61: warning: initialization makes integer from pointer without a cast
i2c-isa.c:62: warning: initialization makes integer from pointer without a cast
i2c-isa.c:63: warning: initialization makes integer from pointer without a cast
i2c-isa.c:64: warning: initialization makes integer from pointer without a cast
i2c-isa.c:65: warning: initialization makes integer from pointer without a cast
i2c-isa.c:65: initializer element is not computable at load time
i2c-isa.c:65: (near initialization for `isa_algorithm.name[6]')
i2c-isa.c:70: warning: initialization from incompatible pointer type
i2c-isa.c:71: warning: missing braces around initializer
i2c-isa.c:71: warning: (near initialization for `isa_adapter.name')
i2c-isa.c:71: warning: overflow in implicit constant conversion
i2c-isa.c:72: warning: initialization makes integer from pointer without a cast
i2c-isa.c:72: initializer element is not computable at load time
i2c-isa.c:72: (near initialization for `isa_adapter.name[1]')
i2c-isa.c:73: warning: initialization makes integer from pointer without a cast
i2c-isa.c:74: warning: initialization makes integer from pointer without a cast
i2c-isa.c:74: initializer element is not computable at load time
i2c-isa.c:74: (near initialization for `isa_adapter.name[3]')
i2c-isa.c:75: warning: initialization makes integer from pointer without a cast
i2c-isa.c:75: initializer element is not computable at load time
i2c-isa.c:75: (near initialization for `isa_adapter.name[4]')
i2c-isa.c:76: warning: initialization makes integer from pointer without a cast
make[2]: *** [i2c-isa.o] Error 1
make[2]: Saliendo directorio `/usr/src/linux-2.4.18.SuSE/drivers/i2c'
make[1]: *** [_modsubdir_i2c] Error 2
make[1]: Saliendo directorio `/usr/src/linux-2.4.18.SuSE/drivers'
make: *** [_mod_drivers] Error 2

Besides I am not  sure if the file i2c-2.8.0-drivers-media-video.diff,
which I also used for patching, is appropriate for my kernel.

Thanks for your help.
-- 
Sergio Roa Ovalle
Key fingerprint = 5427 E535 8E18 8B3B C38B  ADB5 9DF5 89DE FBF4 738C
