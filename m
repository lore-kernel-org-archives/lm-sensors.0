From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: i2c-isa
Message-Id: <001901c33f10$407d83a0$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33f09$69546520$f265a8c0@gf01>
In-Reply-To: <000801c33f09$69546520$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



>
> >     sorry, but in the packet i2c-2.7.0.tar.gz don't exist i2c-isa.c,
> >     is
> > normal? where's the source of i2c-isa.o? from kernel or from i2c
> > packet?
>
> I2c-isa is actually part of lm_sensors-2.7.0, not i2c-2.7.0 (sorry I
> missed that at first).

        ok, trying to compile lmsensors with Makefile patch and
etc/config.in patch breaks with:


        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d
kernel/busses/i2c-ali1535.o: Makefile '`dirname
kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
make: *** No hay ninguna regla para construir el objetivo `stdarg.h',
necesario para `kernel/chips/vt1211.d'.  Alto.


in english: no target to rule to build 'stdarg.h'
