From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: installation problems
Message-Id: <1080915603.406d769357d1b@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404021403.13048.maik.goette@uni-kassel.de>
In-Reply-To: <200404021403.13048.maik.goette@uni-kassel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please answer to the list, not to me]

According to Maik G?tte:

> I am Linux newbie, and am in need of a cpu temperature monitoring
> tool.
> So I tried to install lm_sensors, as told on your page.
> For I use SuSE 9.0 (2.4.21-199Athlon Kernel), I downloaded Version
> 2.7.0.
> 
> The following occurs and tells me nothing:
> (...)
> /lib/modules/2.4.21-199-athlon/build/include/linux/modversions.h -c 
> kernel/i2c-philips-par.c -o kernel/i2c-philips-par.o
> kernel/i2c-philips-par.c:163: error: initializer element is not
> constant
> kernel/i2c-philips-par.c:163: error: (near initialization for 
> `bit_lp_data.timeout')
> kernel/i2c-philips-par.c:172: error: initializer element is not
> constant
> kernel/i2c-philips-par.c:172: error: (near initialization for 
> `bit_lp_data2.timeout')
> make: *** [kernel/i2c-philips-par.o] Error 1

See tickets 1511 and 1522 in our tickets database, and my answer on the
list here:
http://archives.andrew.net.au/lm-sensors/msg06032.html

The suggested method, especially if you're only starting with Linux, is
to use the official lm_sensors package from SuSE (as opposed to
compiling it by yourself).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
