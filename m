From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Unresolved Symbols question lm_sensors 2.8.0/i2c 2.8.0/linux
Message-Id: <20031003200340.53dd477b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F7B83FF.2060409@yml.com>
In-Reply-To: <3F7B83FF.2060409@yml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i2c-piix4 compiled just fine:
> 
> root@nbi_master lm_sensors-2.8.0]# find . -name "*piix4*"
> ./doc/busses/i2c-piix4
> ./kernel/busses/i2c-piix4.c
> ./kernel/busses/i2c-piix4.d
> ./kernel/busses/i2c-piix4.o
> 
> [root@nbi_master lm_sensors-2.8.0]# find . -exec fgrep -l
> dmi_scan_mach {} \;
> ./kernel/busses/dmi_scan.c
> ./kernel/busses/i2c-piix4.c
> ./kernel/busses/i2c-piix4.o

What about 'find . -name "*dmi_scan*"'?

> Maybe it's something simple stupid I did (wouldn't be the first time).
> 
> Build i2c-2.8.0
> make, make install, depmod -aij
> 
> build lm_sensors
> 
> make, make install, depmod -a
> 
> do the ldconfig thing.
> 
> do the sensors-detect thing.

Looks good. Doesn't depmod -a complain about the missing symbol?

> get the unresolved symbol I reported.

OK, not so good ;)

> How is dmi-scan linked in?

dmi_scan is a kernel module, exactly as i2c-piix4 is, and i2c-piix4
depends on it. It looks like you were able to build the second without
the first, which should not happend. Could you try explicitely asking
for it? 'make kernel/busses/dmi_scan.o' should do it. BTW, could you
give a try to i2c/lm_sensors CVS, in case it changes something? (I think
I remember we made some adjustements to the build process right after -
or was it right before - the 2.8.0 release.)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
