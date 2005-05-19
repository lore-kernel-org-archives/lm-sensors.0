From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040106054159.9AAF82C06C@lists.samba.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In message <20040105214654.GB29790@kroah.com> you write:
> > There are loads of MODULE_PARM() used in the whole i2c subsystem. If we
> > are supposed to convert them all, let me know, tell me how to do this
> > cleanly (i.e. what to with that third parameter of module_param, and
> > what to do with MODULE_PARM_DESC) and I'll submit a patch.
> 
> They should be converted.  From module.h:
> 	/* DEPRECATED: Do not use. */
> 	#define MODULE_PARM(var,type) 	\
> 	...

Note that realistically, it's not going away in 2.6, so mass migration
doesn't really win anything.  However, I never implemented mixing old
and new style in the same module, so if you're adding a parameter, it
makes sense to convert them all.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
