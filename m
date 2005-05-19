From: daniel@oden.homeip.net (Daniel Nilsson)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Patch for i2c-tsunami.c
Message-Id: <3FEF8DD2.8090308@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FEB9352.3080401@oden.homeip.net>
In-Reply-To: <3FEB9352.3080401@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>I've spent some time playing with the i2c-tsunami kernel driver on my 
>>DS10 Alphaserver. I'm working on a Debian stable system using kernel 
>>2.4.18 and I installed i2c and lm-sensors 2.8.1 from backports.org.
>>The supplied i2c-tsunami.c will not compile correctly and even when I
>>fixed the compile issue the module would oops upon any read/write
>>attempts. The simple patch below solved both the compile issues and
>>the kernel oops, though I didn't complete when appears to be an
>>attempt to convert this module to a newer interface (the static struct
>>pci_driver stuff). The module now works fine on this test system,
>>though there is nothing but eeproms on the i2c bus connected to the
>>tsunami chipset on this machine :-)
> 
> 
> Thanks, I've applied your patch (well, somehow modified, but that's it
> really). I think none of us core developers have an Alpha machine to
> test the i2c-tsunami driver on, which must be why we didn't notice the
> problem before.
> 

Jean,

I checked out the latest from CVS and verfied that the i2-tsunami driver 
now compiles and works correctly on the Alpha platform (tested on a 
DS10). Since we are taking about the Alpha, I wanted to mention another 
problem that some users might potentially have compiling and using the 
code on Alphas. Initially I got the following error when trying to compile:

gcc  -DMODVERSIONS -include 
/usr/src/kernel-source-2.4.18/include/linux/modversions.h -D__KERNEL_ _ 
-DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include 
-I/usr/src/modules/i2c -I/us r/src/kernel-source-2.4.18/include 
-nostdinc -I /usr/lib/gcc-lib/alpha-linux/2.95.4/include  -ff ixed-8 
-Wall -O2  -c kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
/tmp/cc4byoeZ.s: Assembler messages:
/tmp/cc4byoeZ.s:132: Error: macro requires $at register while noat in effect
/tmp/cc4byoeZ.s:148: Error: macro requires $at register while noat in effect

The error is from as, and the reason it is failing is not really clear 
to me. Reading through various posts indicates that this might be a gcc 
bug (the author of as for Alpha seemed to think so at one point at 
least). I see these issues using gcc 2.95.4 and gas 2.12.90.0.1.

The "fix" is however to specify what cputype your are compiling for, 
that is how it's done when compiling the Linux kernel on Alpha for 
example. There is also one more flag recommended when compiling kernel 
code for Alpha, and that is the -mno-fp-regs flag.

So I changed the Makefiles for both i2c and lm-sensors from this:

ifeq ($(MACHINE),alpha)
MODCFLAGS += -ffixed-8
endif

to this:

ifeq ($(MACHINE),alpha)
MODCFLAGS += -ffixed-8 -mno-fp-regs -mcpu=ev56
endif

and that solves all the compile issues. The only thing I'm not sure 
about is what would happen if someone tried to execute the code on EV4 
processors for example, and I have no way to test that either. EV56 are 
pretty old processors as well, so going with the above flags per default 
is probably safe.

Thanks
