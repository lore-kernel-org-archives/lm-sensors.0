From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: location of modules with make install
Message-Id: <1040346296.16788.54.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040275150.16788.41.camel@linux.local>
In-Reply-To: <1040275150.16788.41.camel@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2002-12-19 at 08:48, Mark Studebaker wrote:
> what docs are wrong? 

Bad choice of terminology.  I meant the comments in Makefile:

# Determine whether we need to compile the kernel modules, or only the
# user-space utilities. By default, the kernel modules are compiled.
#COMPILE_KERNEL := 0
COMPILE_KERNEL := 1

I assumed that this choice would put them where the kernel would--busses
in /lib/modules/2.4.19-4GB/kernel/drivers/i2c/busses.  Make install puts
them one level higher, in drivers/i2c.  Chips .o files are put in
i2c/chips by kernel; in drivers/sensors by make install.



> I couldn't find any.
> doc/modules in particular looks correct to me.
> Don't know why you would have to move them for depmod to work.
> I assume "../../" below means "/lib/modules/`uname -r`/" ?

If I don't move them, then modprobe prefers the ones where the kernel's
make modules_install puts them.  depmod -ae is not the problem, but I
have 2 of each and modprobe prefers and loads the wrong ones.  This is a
SuSE kernel and they make everything into modules, I guess for
compatibility across as many systems as possible.

By moving the 2.7.0 modules to the preferred locations, they get loaded
with modprobe.


> Ed Harrison wrote:
> > Apart from the problem I am having with the as99127f, make install isn't putting the drivers where the docs say they go.
> > 
> > buss drivers end up in ../../kernel/drivers/i2c (which I then have to mv to ../i2c/busses, and
> > chip drivers end up in ../../kernel/drivers/sensors (which I mv to ../i2c/chips, thenm do a depmod -ae.
> > 
> > I may not be compiling correctly.  The inline comments in Makefile confuse me as to whether I want the kernel modules or not.
-- 


Ed Harrison, broadcasting on
 _
| |
| |
| |     
| |___ || ||\\ || || || \\//
|_____||| || \\|| ||_|| //\\

by SuSE(8.1), Kernel 2.4.19, X 4.2
or Windows98 (running in vmware 3.2)
