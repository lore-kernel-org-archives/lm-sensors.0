From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: SMbus problem ?
Message-Id: <20030603084138.700962b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030602222815.14c7b37f.sesshoumaru@altern.org>
In-Reply-To: <20030602222815.14c7b37f.sesshoumaru@altern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have a few problems with lm_sensors. I installed i2c-2.7.0 packages
> and after that i do a depmod -a.
> But when i compile lm_sensors i have this errors at make step :
> 
> [root@calculus:/tmp/lm_sensors-2.7.0]# make
> gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.
> -Ikernel/include -I/usr/local/include
> -I/lib/modules/2.4.20/build/include   -O2   -c
> kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
> kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old -
> (...)
> However i have installed i2c-2.7.0.
> 
> An ideas ?

This is a known problem. Pick the fixed Makefile there:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/Makefile
That should do it. If not, please checkout both i2c CVS (branch lk2-4)
and lm_sensors2 CVS, that should work too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
