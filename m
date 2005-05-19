From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040106054159.798C92C015@lists.samba.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In message <20040105212125.4e26a7e4.khali@linux-fr.org> you write:
> > > BTW, it'd be nice if someone converted these to module_param, too...
> > (...)
> > -MODULE_PARM(force, "i");
> > +module_param (force, int, 0);
> >  MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
> 
> Two questions for my personal knowledge:
> 1* What does the final 0 stand for?
> 2* Aren't we supposed to convert MODULE_PARM_DESC too?

1) Permissions when these appear in sysfs (there's a patch floating
   around from Greg).  0 means it won't appear.  0400 means it'll be
   read only, etc.  If the parameter only effects behavior at
   insertion time, or is __initdata, then 0 is appropriate.  If it
   doesn't make sense to change, or you can't be bothered writing the
   code to change it safely, then 0400 or 0444 is appropriate.
   Something like 'debug' might be 0644 though.

2) I didn't change that at all.  It's a little messy, perhaps, but I
   don't like to break things unless there's a good reason.

> There are loads of MODULE_PARM() used in the whole i2c subsystem. If we
> are supposed to convert them all, let me know, tell me how to do this
> cleanly (i.e. what to with that third parameter of module_param, and
> what to do with MODULE_PARM_DESC) and I'll submit a patch.

The big advantage of changing is that you also get boot parameters of
the form "modulename.paramname".  Type safety, sysfs, ability to add
own types are benifits mainly for new code.

Hope that clarifies!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
