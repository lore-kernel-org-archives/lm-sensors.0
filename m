From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: I2c (cvs upload) compile problem.
Message-Id: <20030410094003.13bdae6c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304092003.10837.rob.blomquist@verizon.net>
In-Reply-To: <200304092003.10837.rob.blomquist@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I uploaded the freshest i2c and lm_sensors packages by cvs tonight in
> the hopes that my ASUS A7N8X board with its Nivida chips would be
> detected. I am running a fresh build of Mandrake 9.1, with the
> 2.4.21-0.13mdk kernel running.

You mean you *downloaded* the packages?

> I get a compile error in "make install" right at the begininning:

That's bad. Let's fix it.

> [root@timmy2 i2c]# make install
> (...)
> install: `/lib/modules/2.4.21-0.13mdksmp' is a directory
> install: `2.4.21-0.13mdkenterprise' is a directory
> install: `2.4.21-0.13mdk' is a directory
> make: *** [install-kernel] Error 1

Can you show me the output of the following commands:

uname -r

grep UTS_RELEASE
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 -d'"'

It should help me understand what happened.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
