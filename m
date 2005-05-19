From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-Id: <1101145020.9784.17.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041121220251.GE13254@stusta.de>
	 <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de>
	 <1101140745.9784.7.camel@uganda> <20041122165145.GH19419@stusta.de>
	 <1101143109.9784.9.camel@uganda>  <20041122171956.GI19419@stusta.de>
In-Reply-To: <20041122171956.GI19419@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 18:19 +0100, Adrian Bunk wrote:
> On Mon, Nov 22, 2004 at 08:05:09PM +0300, Evgeniy Polyakov wrote:
> > On Mon, 2004-11-22 at 17:51 +0100, Adrian Bunk wrote:
> > > On Mon, Nov 22, 2004 at 07:25:45PM +0300, Evgeniy Polyakov wrote:
> > > > 
> > > > > How would a different w1 bus master chip look like in 
> > > > > drivers/w1/Makefile?
> > > > 
> > > > obj-m: proprietary_module.o
> > > > proprietary_module-objs: dscore.o proprietary_module_init.o
> > > > 
> > > > Actually it will live outside the kernel tree, but will require ds2490
> > > > driver.
> > > > It could be called ds2490.c but I think dscore is better name.
> > > 
> > > Why are you talking about proprietary modules living outside the kernel 
> > > tree?
> > > 
> > > The only interesting case is the one of modules shipped with the kernel.
> > > And for them, this will break at link time if two such modules are 
> > > included statically into the kernel.
> > 
> > If we _currently_ do not have any open hw/module that depends on ds2490
> > core then it does not
> > mean that tomorrow noone will add it.
> 
> Once again:
>   _this will break at link time if two such modules are included 
>    statically into the kernel_
> 
> obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
> ds9490r-objs    := dscore.o
> 
> obj-$(CONFIG_W1_FOO)         += foo.o 
> foo-objs    := dscore.o
> 

that should be follwing:

Kconfig:
foo depends on ds9490r

obj-$() += foo.o
foo-objs := foo_1.o foo_2.o

It just happened that ds9490r does not need any other parts but
dscore.o.
That is why ds9490r.o have only dscore.o in it's dependency.

> This will break with CONFIG_W1_DS9490=y and CONFIG_W1_FOO=y.
> 
> 
> That drivers/w1/ contains many EXPORT_SYMBOL's with no in-kernel users 
> is a different issue I might send a separate patch for (that besides 
> proprietary modules there might come some day open source drivers using 
> them is not a reason).

Why remove existing non disturbing set of exported functions?
Are they violate some unknown issues?

> 
> cu
> Adrian
> 
-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041122/e08891e6/attachment.bin
