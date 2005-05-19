From: nuppla@gmx.at (fago)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073592110.1007.42.camel@ws1>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Do, den 08.01.2004 schrieb Jean Delvare um 20:04:
> > I've tried choice 1. I(!) would not say it is not complex ;) I've
> > never had a closer look to any linux source code and know just some
> > basics of c. i wondered that it's possible to write several functions
> > with the help of defines.
> 
> OK, this isn't trivial, but I don't consider it unfeasable by someone
> with reasonble C knowledge either.
> > 
> > your instructions were not really clear to me, but with the help of
> > the other modules source code (lm83.c, lm78.c), it was more copy,
> > paste and edit ;)
> > i think the document is alright.
> 
> I agree that looking at an already converted driver helps much more than
> any guide I could write.
> 
> > so now to my problems ;)
> > 
> > 1. i got this error message by compiling it.
> > 
> > w83l785ts.c:86: error: `I2C_DRIVERID_W83L785TS' undeclared here (not
> > in a function)
> > w83l785ts.c:86: error: initializer element is not constant
> > w83l785ts.c:86: error: (near initialization for `w83l785ts_driver.id')
> > 
> > i think i get it, because the driver must be declared somewhere in the
> > kernel sources. if right, where? which value should the ID get?
> > 
> > i just replaced  ".id = I2C_DRIVERID_W83L785TS," with ".id = 
> > I2C_DRIVERID_W83781D + 1,", so it compiled. (i suppose very dirty ;)
> 
> Yes that's dirty, but it the end we don't care because IDs are now used.
> The prefered fix though is to add the relevant line to
> include/linux/i2c-id.h:
> #define I2C_DRIVERID_W83L785TS 1047
> 
> > 2. how can i compile just this one module for my kernel?
> > 
> > i tried compiling with a call i've seen when i was compiling a 2.4.*er
> > kernel.
> > 
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer-pipe -mpreferred-stack-boundary=2 -DMODULE
> > -DMODVERSIONS -nostdinc-iwithprefix include -DKBUILD_BASENAME=isicom 
> > -c w83l785ts.c
> > 
> > so i get a .o file. 
> > the kernel 2.6 compile isn't verbose any more, but i remembered that
> > it has used ld for a modul. but link with what?!?
> > do you know how i can build a kernel 2.6 module (.ko)??
> 
> I don't know. What I'd suggest is that you edit
> drivers/i2c/chips/Kconfig and Makefile to add support for the new
> driver. This is really easy. Cut, paste :) Then, all you have to do is
> configure your kernel, enable the driver, and compile.
> 
> > i've attached the edited source file. i hope it will do its work.....
> 
> Didn't look indeep but it looks overall good to me. I can't test it
> since I do not have any supported device here. Let us know how it goes!
> If you get it to work on your system, we'll prepare a patch and send it
> to Greg KH so that it is included into Linux 2.6.2.
> 
> Thanks :)

Yeah it works :))
Thanky you for your help, really cool =)

I'm getting a temperature of 46?C, which is what i expected about. I'm
also running the ASUS C.O.P feature, which also uses this chip for
determining the temperature (so i've read somewhere), i hope there will
be no problems, let's see.

for know it works fine, i can't believe :)
regards, fago
