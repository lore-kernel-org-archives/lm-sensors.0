From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <20030803033155.GA5202@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gene:

* Gene Heskett <gene.heskett@verizon.net> [2003-08-02 20:42:50 -0400]:
> On Saturday 02 August 2003 17:17, Jean Delvare wrote:
> >I suggest you start from the very beginning with the separate
> >compilation option. This is the way I personnally use, and the one I
> >recommend too.
> >
> >You need to have a kernel tree matching your running kernel.
> 
> This has been one of the sore spots with me, this requirement that I 
> make a new kernel, and sensors doesn't work because its referenceing 
> the one that running, not the one thats building courtesy of the use 
> of the uname facility to discover the version numbers.  I'd much 
> rather it reached back into /usr/src/linux to discover this since 
> that link *will* be valid for the kernel under construction.

Having a kernel tree that matches the running kernel is just the
easiest way for our users to get it right.  However, if you want
to build against some other kernel just point the "LINUX :=" line
of the i2c and lm_sensors2 top-level makefiles to whatever kernel
you want to build against.  Then continue with Jean's instructions.

> > This
> > kernel must not have any I2C element hard-compiled. If it has some
> > as modules, it's OK, they'll be overriden.
> >
> >Then, install i2c-2.8.0. Don't patch your kernel, just compile
> >separately. It's as easy as: make, make install.
> >
> >Then, install lm_sensors-2.8.0. Same as for i2c, don't patch your
> >kernel, compile separately. It's as easy as: make, make install,
> >ldconfig.

Also note it's important to follow this order - don't try to cheat
by building lm_sensors before *installing* i2c.

> ldconfig?  Something tells me I really do need to rtfm better than I 
> have recently...

This just tells your system to update its list of where to find
shared libraries.  There will be notes about this at the end of
the second "make install" - read them and you should be all set.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
