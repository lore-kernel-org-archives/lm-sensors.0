From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Apr 2009 10:11:48 +0000
Subject: Re: [lm-sensors] Please,
Message-Id: <20090428121148.607a6e48@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <fe6167c00904270421g19534018n7d544427e675d412@mail.gmail.com>
In-Reply-To: <fe6167c00904270421g19534018n7d544427e675d412@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre, Didier,

On Tue, 28 Apr 2009 11:12:49 +0200, Andre Prendel wrote:
> On Mon, Apr 27, 2009 at 01:21:58PM +0200, Didier Roche wrote:
> > Hi lm-sensors developer,
> > 
> > It would be great if lm-sensors can take into account distribution
> > LDFLAGS so that exported variables change linker behavior.
> > 
> > For instance, ubuntu uses -Wl,-Bsymbolic-functions. Taking this patch
> > will enable us to just sync from debian on this package.
> > 
> > In Ubuntu, we've applied the attached patch to achieve the following:
> > 
> >   * handle default ubuntu LDFLAGS for linking option (LP: #321632)
> >     - Remove the old hack directly pushed in lib/Module.mk (now
> >       lib/Module.mk if from pristine source)
> >     - add debian/patches/07-use-LDFLAGS.patch to take LDFLAGS into account
> > 
> > Debian and Ubuntu thought you might be interested to handle this
> > directly upstream.
> > 
> > 
> > --- lm-sensors-3-3.0.2.orig/lib/Module.mk      2008-05-18
> > 8:07:48.000000000 +0200
> > +++ lm-sensors-3-3.0.2/lib/Module.mk   2009-01-26 22:15:02.000000000 +0100
> > @@ -60,7 +60,7 @@
> > 
> >  # How to create the shared library
> >  $(MODULE_DIR)/$(LIBSHLIBNAME): $(LIBSHOBJECTS)
> > -      $(CC) -shared -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm
> > +      $(CC) -shared $(LDFLAGS) -Wl,-soname,$(LIBSHSONAME) -o $@ $^ -lc -lm
> > 
> >  $(MODULE_DIR)/$(LIBSHSONAME): $(MODULE_DIR)/$(LIBSHLIBNAME)
> >        $(RM) $@
> > 
> > 
> 
> Jean, your'e more familiar with the build system. Any objections? If
> no, I will apply this patch.

No objection, if distributions need this, this doesn't cost us a thing,
so just go ahead.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
