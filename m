From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: lm_sensors 2.8.5 on i2c 2.8.2: `I2C_DRIVERID_ADM1026' undeclared
Message-Id: <1078827479.404d99d746dff@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040309090846.GG17881@neu.nirvana>
In-Reply-To: <20040309090846.GG17881@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Axel Thimm <Axel.Thimm@physik.fu-berlin.de>:

> I tried to build lm_sensors for the RH9 kernels, for which I have
> i2c 2.8.2. The build fails with (...)
> kernel/chips/adm1026.c:385: `I2C_DRIVERID_ADM1026' undeclared here
> (not in a function)
> (...)
> make: *** [kernel/chips/adm1026.o] Error 1
> 
> Did I do something wrong, or does lm_sensors still need newer i2c in
> the kernel?

My bad, I forgot this one :(

You can add these lines right after the includes in adm1026.c:

#ifndef I2C_DRIVERID_ADM1026
#define I2C_DRIVERID_ADM1026	1048
#endif

And it should then compile correctly.

I'll fix that in CVS this evening (UTC +0100).

> Thanks!
> P.S. lm_sensors 2.8.5 for FC1 build fine and will be upload later
> today.

Great :)

Sorry for the trouble again,
thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
