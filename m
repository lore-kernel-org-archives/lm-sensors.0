From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040105214654.GB29790@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 05, 2004 at 09:21:25PM +0100, Jean Delvare wrote:
> > > BTW, it'd be nice if someone converted these to module_param, too...
> > (...)
> > -MODULE_PARM(force, "i");
> > +module_param (force, int, 0);
> >  MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
> 
> Two questions for my personal knowledge:
> 1* What does the final 0 stand for?

As found in include/linux/moduleparam.h:
	/* This is the fundamental function for registering boot/module
	   parameters.  perm sets the visibility in driverfs: 000 means
	   it's not there, read bits mean it's readable, write bits mean
	   it's writable. */

So a 0 there, means it doesn't show up in sysfs.  I don't know if anyone
has ever enabled that option yet, unfortunatly...

> 2* Aren't we supposed to convert MODULE_PARM_DESC too?

To what?  There isn't a module_param_desc() call/macro in the kernel,
yet.

> There are loads of MODULE_PARM() used in the whole i2c subsystem. If we
> are supposed to convert them all, let me know, tell me how to do this
> cleanly (i.e. what to with that third parameter of module_param, and
> what to do with MODULE_PARM_DESC) and I'll submit a patch.

They should be converted.  From module.h:
	/* DEPRECATED: Do not use. */
	#define MODULE_PARM(var,type) 	\
	...

thanks,

greg k-h
