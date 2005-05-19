From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: i2c-isa
Message-Id: <000501c33f12$383403c0$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33f09$69546520$f265a8c0@gf01>
In-Reply-To: <000801c33f09$69546520$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
> >         ok, trying to compile lmsensors with Makefile patch and
> > etc/config.in patch breaks with:
> >
> >
> >         sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d
> > kernel/busses/i2c-ali1535.o: Makefile '`dirname
> > kernel/busses/i2c-ali1535.d`/Module.mk' @' >
> > kernel/busses/i2c-ali1535.d make: *** No hay ninguna regla para
> > construir el objetivo `stdarg.h', necesario para
> > `kernel/chips/vt1211.d'.  Alto.
> >
> >
> > in english: no target to rule to build 'stdarg.h'
>
> You must have locales set (check with "locale"). Try "export LC_ALL=C"
> before runing "make".
>
> A better fix will be commited before 2.8.0 is released.
>

            ok thx, now compile fine, but don't install sensors-detect. but
is in prog.
