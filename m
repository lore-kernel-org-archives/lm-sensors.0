From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: ticket 1372 (A7V333)
Message-Id: <20030816144615.41580598.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061027552.6648.11.camel@campgrounds>
In-Reply-To: <1061027552.6648.11.camel@campgrounds>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> with reference to my ticket 1372 i provide my dmesg and lsmod output.
> 
> dmesg:
> i2c-core.o: i2c core module
> i2c-viapro.o version 2.6.5 (20020915)
> i2c-viapro.o: Can't detect vt82c596 or compatible device, module not
> inserted.

Too old, and this is the problem. In your ticket you say you are using
2.8.0, and the userspace tools must be (since sensors-detect detects the
chip correctly), but your modules are *not*. Fix that, and it should
work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
