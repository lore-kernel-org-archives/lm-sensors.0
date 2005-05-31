From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 31 May 2005 16:36:37 +0000
Subject: [lm-sensors] lm_sensors 2.9.1 sensord compile failure on 2.6.11.11
Message-Id: <sqmwxN0v.1117549657.9689150.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1lhn91hj2hvhq65un08m8nae3f7fvt3ubv@4ax.com>
In-Reply-To: <1lhn91hj2hvhq65un08m8nae3f7fvt3ubv@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant and all, greetings live from the Guadec :)

> Can't compile sensord 2.9.1 with 2.6.11.11 -- neither can my test user,
> and he's done it before.
>
> make clean; make PROG_EXTRA:=sensord
>
> make: *** No rule to make target `linux/i2c-proc.h', needed by
> `kernel/chips/xeontemp.d'.  Stop.
>
> Does anyone know a fix?  Or magical incantation?
>
> It is probably something stupid, but I cannot see it, make user; make
> user_install work fine, why not other stuff?

Try:
make PROG_EXTRA:=sensord user

Without a target explicitely handled to not build kernel dependency
files, these dependency files are built, but this doesn't work with 2.6
kernels, only 2.4 ones. Specifying "user" as the target solves the
problem. If you can fix the Makefile system to behave better, patches
are welcome :)

Thanks,
--
Jean Delvare
