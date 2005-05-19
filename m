From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Can't compile.
Message-Id: <20011113151516.L5776@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1004795203.3be3f5436c8d7@imp3-1.free.fr>
In-Reply-To: <1004795203.3be3f5436c8d7@imp3-1.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I've seen this before... I think it happens when CONFIG_MODVERSIONS is
not set or if the makefile for the modules is making the wrong
assumption on versioning...  something like that...


Phil

On Sun, Nov 11, 2001 at 09:29:09PM -0500, Mark D. Studebaker wrote:
> Haven't seen this before.
> What kernel are you compiling against?
> I don't see this in include/linux/modversions.h in
> kernel 2.4.14.
> 
> mds
> 
> 
> 
> Boris de Laage wrote:
> > 
> > I can't compile the I2C modules:
> > 
> > gcc -I/usr/src/linux/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE
> > -fomit-frame-pointer -DEXPORT_SYMTAB -c kernel/i2c-core.c -o kernel/i2c-core.o
> > In file included from /usr/src/linux/include/linux/module.h:21,
> >                  from kernel/i2c-core.c:25:
> > /usr/include/linux/modversions.h:1:2: #error Modules should never use
> > kernel-headers system headers,
> > /usr/include/linux/modversions.h:2:2: #error but rather headers from an
> > appropriate kernel-source package.
> > /usr/include/linux/modversions.h:3:2: #error Change -I/usr/src/linux/include (or
> > similar) to
> > /usr/include/linux/modversions.h:4:2: #error -I/lib/modules/$(uname
> > -r)/build/include
> > /usr/include/linux/modversions.h:5:2: #error to build against the
> > currently-running kernel.

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
