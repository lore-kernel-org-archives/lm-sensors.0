From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: i2c-isa
Message-Id: <000501c33f0e$fa8c5a20$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33f09$69546520$f265a8c0@gf01>
In-Reply-To: <000801c33f09$69546520$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



>
> > > It most probably has. Run "depmod -ae" (as root) to update your
> > > module dependencies, and your system will see the file again.
> >
> >
> >     no, when doing 'make;: make install' for i2c-2.7.0 dont compile
> >     any
> > i2c-isa, where i can get it?
>
> It really has to be there. If you can't find it, please send us a
> complete log of what happens when you run "make" (preferably after a
> "make clean".) We'll be helpless without that. (We can't just *guess*
> what your problem is.)

    sorry, but in the packet i2c-2.7.0.tar.gz don't exist i2c-isa.c, is
normal? where's the source of i2c-isa.o? from kernel or from i2c packet?
