From: bunk@stusta.de (Adrian Bunk)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-Id: <20041122165145.GH19419@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041121220251.GE13254@stusta.de> <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de> <1101140745.9784.7.camel@uganda>
In-Reply-To: <1101140745.9784.7.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:25:45PM +0300, Evgeniy Polyakov wrote:
> On Mon, 2004-11-22 at 14:33 +0100, Adrian Bunk wrote:
> > On Mon, Nov 22, 2004 at 10:31:12AM +0300, Evgeniy Polyakov wrote:
> > > On Mon, 2004-11-22 at 01:02, Adrian Bunk wrote:
> > > > Hi Evgeniy,
> > > 
> > > Hello, Adrian.
> > 
> > Hi Evgeniy,
> > 
> > > > drivers/w1/Makefile in recent 2.6 kernels contains:
> > > >   obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
> > > >   ds9490r-objs    := dscore.o
> > > > 
> > > > Is there a reason, why dscore.c isn't simply named ds9490r.c ?
> > > 
> > > dscore.c is a core function set to work with ds2490 chip.
> > > ds9490* is built on top of it.
> > > Any vendor can create it's own w1 bus master using this chip, 
> > > not ds9490.
> > 
> > if it was built on top of it, I'd have expected ds9490r.o to contain 
> > additional object files.
> 
> DS9490 does not have anything except this chip and simple 64bit memory
> chip,
> so it is not needed to have any additional code.
> 
> > How would a different w1 bus master chip look like in 
> > drivers/w1/Makefile?
> 
> obj-m: proprietary_module.o
> proprietary_module-objs: dscore.o proprietary_module_init.o
> 
> Actually it will live outside the kernel tree, but will require ds2490
> driver.
> It could be called ds2490.c but I think dscore is better name.

Why are you talking about proprietary modules living outside the kernel 
tree?

The only interesting case is the one of modules shipped with the kernel.
And for them, this will break at link time if two such modules are 
included statically into the kernel.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
