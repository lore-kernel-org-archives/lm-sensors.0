From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: can't compile i2c-2.8.3 on linux-2.6.2
Message-Id: <20040205191644.6ab4b8f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040204194802.35A2CACA5@sitemail.everyone.net>
In-Reply-To: <20040204194802.35A2CACA5@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i compiled the kernel with make clean; lm_sensors compiled after a
> make clean in lm_sensors. but i2c won't compile, it keeps giving me a
> "no rule to make target" error:
> 
> make: *** No rule to make target `mach_mpspec.h', needed by
> `kernel/i2c-pport.d'.  Stop.

I2c and the lm_sensors kernel modules are already part of Linux 2.6.2.
You don't need to compile them apart (and it wouldn't work, as you
noticed).

All you need to do is compile and install the lm_sensors user-space
tools with "make user" and "make user_install" (in lm_sensors,
obviously). The rest is meant for 2.4 kernels, not 2.6 kernels.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
