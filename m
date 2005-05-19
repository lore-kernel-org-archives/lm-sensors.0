From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: [Fwd: sensors, kernel 2.4.19, bttv ...]
Message-Id: <20031026193437.2790a178.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067191364.14649.3.camel@lenny.homelinux.net>
In-Reply-To: <1067191364.14649.3.camel@lenny.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> It's me again... i just would like to add a word : I've just read i2c
> 2.8.0 was included in kernels after 2.4.21.

No, it isn't. Where did you read that? It might be that *distributions*
patch the 2.4.21 kernels they are packaging with i2c 2.8.0, but it isn't
part of the vanilla sources.

> Does it mean that simply upgrading my kernel from 2.4.19 to - say -
> 2.4.22 will do the trick ?

No, it won't.

> I mean, then I'll only have to compile lm_sensors and everything will
> be fine (bttv and i2c sensors ?)

You're invited to point your browser to:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
and read carefully everything that is written there. You'll find the
patches you need to be able to use i2c-2.8.x and still have bttv
working. Basically, all you'll have to do is patch your kernel sources
using one of the provided patches (i2c 2.8.0 for Linux 2.4.21 or i2c
2.8.1 for Linux 2.4.22), then installing lm_sensors (same version as
i2c) will be done as usual.

Let us know how it work for you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
